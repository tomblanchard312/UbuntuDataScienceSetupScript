[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$VmName = "UbuntuDataScienceVM",

    [Parameter()]
    [ValidateRange(2, 256)]
    [int]$MemoryStartupGB = 8,

    [Parameter()]
    [ValidateRange(32, 2048)]
    [int]$VhdSizeGB = 128,

    [Parameter()]
    [string]$UbuntuIsoPath,

    [Parameter()]
    [string]$VirtualSwitchName,

    [Parameter()]
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Test-HyperVAvailable {
    [CmdletBinding()]
    param()

    if (-not (Get-Command -Name New-VM -ErrorAction SilentlyContinue)) {
        return $false
    }

    $feature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -ErrorAction SilentlyContinue
    return $null -ne $feature -and $feature.State -eq 'Enabled'
}

function Ensure-UbuntuIso {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$IsoPath
    )

    $ubuntuIsoUrl = 'https://releases.ubuntu.com/24.04.1/ubuntu-24.04.1-desktop-amd64.iso'
    if (Test-Path -LiteralPath $IsoPath) {
        return
    }

    $isoDir = Split-Path -Path $IsoPath -Parent
    if (-not (Test-Path -LiteralPath $isoDir)) {
        New-Item -ItemType Directory -Path $isoDir -Force | Out-Null
    }

    Write-Host "Downloading Ubuntu ISO to '$IsoPath'"
    Invoke-WebRequest -Uri $ubuntuIsoUrl -OutFile $IsoPath
}

function Get-ValidatedSwitchName {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$Name
    )

    if ([string]::IsNullOrWhiteSpace($Name)) {
        return $null
    }

    $switch = Get-VMSwitch -Name $Name -ErrorAction SilentlyContinue
    if ($null -eq $switch) {
        throw "Virtual switch '$Name' was not found. Use Get-VMSwitch to list available switches."
    }

    return $switch.Name
}

if (-not (Test-HyperVAvailable)) {
    throw 'Hyper-V is not available or not enabled. Enable Hyper-V and run this script from an elevated PowerShell session.'
}

$scriptRoot = Split-Path -Parent $PSCommandPath
$logDir = Join-Path $scriptRoot 'logs'
if (-not (Test-Path -LiteralPath $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

$logPath = Join-Path $logDir ("hyper-v-setup-{0:yyyyMMdd-HHmmss}.log" -f (Get-Date))
Start-Transcript -Path $logPath | Out-Null

try {
    if ([string]::IsNullOrWhiteSpace($UbuntuIsoPath)) {
        $UbuntuIsoPath = Join-Path $env:USERPROFILE 'Downloads\ubuntu-24.04.1-desktop-amd64.iso'
    }

    Ensure-UbuntuIso -IsoPath $UbuntuIsoPath

    if (-not (Test-Path -LiteralPath $UbuntuIsoPath)) {
        throw "Ubuntu ISO not found at '$UbuntuIsoPath'."
    }

    $resolvedSwitchName = Get-ValidatedSwitchName -Name $VirtualSwitchName

    $vmRoot = Join-Path $env:PUBLIC "Documents\Hyper-V\$VmName"
    $vhdPath = Join-Path $vmRoot "$VmName.vhdx"

    if (Get-VM -Name $VmName -ErrorAction SilentlyContinue) {
        if (-not $Force) {
            throw "VM '$VmName' already exists. Re-run with -Force to recreate it."
        }

        Write-Host "Removing existing VM '$VmName' because -Force was specified."
        Stop-VM -Name $VmName -TurnOff -Force -ErrorAction SilentlyContinue
        Remove-VM -Name $VmName -Force
    }

    if (Test-Path -LiteralPath $vhdPath) {
        if (-not $Force) {
            throw "VHD '$vhdPath' already exists. Re-run with -Force to recreate it."
        }
        Remove-Item -LiteralPath $vhdPath -Force
    }

    if (-not (Test-Path -LiteralPath $vmRoot)) {
        New-Item -ItemType Directory -Path $vmRoot -Force | Out-Null
    }

    $newVmParams = @{
        Name               = $VmName
        Generation         = 2
        MemoryStartupBytes = ($MemoryStartupGB * 1GB)
        NewVHDPath         = $vhdPath
        NewVHDSizeBytes    = ($VhdSizeGB * 1GB)
        Path               = $vmRoot
    }

    if ($null -ne $resolvedSwitchName) {
        $newVmParams['SwitchName'] = $resolvedSwitchName
    }

    Write-Host "Creating VM '$VmName'"
    New-VM @newVmParams | Out-Null

    Set-VM -Name $VmName -AutomaticCheckpointsEnabled $false
    Set-VMDvdDrive -VMName $VmName -Path $UbuntuIsoPath
    Set-VMFirmware -VMName $VmName -EnableSecureBoot On -SecureBootTemplate 'MicrosoftUEFICertificateAuthority'

    Write-Host "Starting VM '$VmName'"
    Start-VM -Name $VmName | Out-Null

    Write-Host ''
    Write-Host 'VM provisioning completed.'
    Write-Host "VM Name: $VmName"
    Write-Host "ISO Path: $UbuntuIsoPath"
    Write-Host "VHD Path: $vhdPath"
    if ($null -ne $resolvedSwitchName) {
        Write-Host "Virtual Switch: $resolvedSwitchName"
    }
    Write-Host ''
    Write-Host 'Next steps:'
    Write-Host '1. Complete Ubuntu installation in the VM console.'
    Write-Host '2. Copy this repository into the VM (git clone or shared folder).'
    Write-Host '3. Run ./hyper_v_post_install.sh inside Ubuntu with the desired profiles.'
}
finally {
    Stop-Transcript | Out-Null
}

