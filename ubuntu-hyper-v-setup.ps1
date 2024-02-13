# Define variables
$VMName = "UbuntuVM"
$UbuntuISOURL = "https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-desktop-amd64.iso"
$ISOPath = "$env:USERPROFILE\Downloads\ubuntu-22.04.3-desktop-amd64.iso"
$ScriptURL = "https://raw.githubusercontent.com/tomblanchard312/DSWorkloadInstallScripts/main/hyper_v_post_install.sh"
$ScriptPath = "$env:USERPROFILE\Downloads\hyper_v_post_install.sh"

# Download Ubuntu ISO
Invoke-WebRequest -Uri $UbuntuISOURL -OutFile $ISOPath

# Wait for download to complete
Write-Host "Downloading Ubuntu ISO. Please wait..."
while ((Test-Path $ISOPath) -eq $false) {
    Start-Sleep -Seconds 10
}
Write-Host "Download complete."

# Download post-installation script
Invoke-WebRequest -Uri $ScriptURL -OutFile $ScriptPath

# Wait for download to complete
Write-Host "Downloading post-installation script. Please wait..."
while ((Test-Path $ScriptPath) -eq $false) {
    Start-Sleep -Seconds 10
}
Write-Host "Download complete."

# Create new VM
New-VM -Name $VMName -MemoryStartupBytes 4GB -Generation 2 -BootDevice VHD -VHDFormat VHDX -VHDPath "C:\Hyper-V\$VMName.vhdx" -Path "C:\Hyper-V"

# Set DVD drive to boot from Ubuntu ISO
Set-VMDvdDrive -VMName $VMName -Path $ISOPath

# Start VM
Start-VM -Name $VMName

Write-Host "Ubuntu VM setup completed."

