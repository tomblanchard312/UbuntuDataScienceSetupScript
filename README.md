# DSWorkloadInstallScripts
This repository contains scripts to set up a development environment for Ubuntu and Windows Subsystem for Linux (WSL) with various tools commonly used for software development, data science, and machine learning.

## Installation Steps

### Ubuntu

1. Clone this repository:
   ```bash
   git clone https://github.com/tomblanchard312/DSWorkloadInstallScripts.git
	 cd DSWorkloadInstallScripts
   ```
2. Make the script executable
   ```bash
   chmod +x ubuntu_post_install.sh
   ```
3. Run the script to set up the development environment:
    ```bash
    ./ubuntu_post_install.sh
    ```
### Windows Subsystem for Linux (WSL)
1. Clone this repository:
   ```bash
   git clone https://github.com/tomblanchard312/DSWorkloadInstallScripts.git
	 cd repository
   ```
2. Make the script executable
    ```bash
    chmod +x wsl_post_install.sh
    ```
3. Run the script to set up the development environment
    ```bash
    ./wsl_post_install.sh
    ```


# Ubuntu Development Environment Setup on Hyper-V

This repository contains scripts to set up a development environment for Ubuntu running on Hyper-V, including both CUDA and non-CUDA setups.

## Prerequisites

Before running the scripts, ensure that you have the following prerequisites:

- Hyper-V installed and enabled on your Windows machine.
- PowerShell with administrative privileges.
- Internet connection to download Ubuntu ISO and necessary packages.

## Installation Steps

1. **Download Ubuntu ISO**:
   - Download the Ubuntu ISO file from the official Ubuntu website: [Download Ubuntu Desktop](https://ubuntu.com/download/desktop/thank-you?version=22.04.3&architecture=amd64).

2. **Set Execution Policy**:
   - Open PowerShell with administrative privileges.
   - Run the following command to bypass execution policy:
     ```powershell
     Set-ExecutionPolicy Bypass -Scope Process -Force
     ```

3. **Run the Installation Script**:
   - Run the PowerShell script provided in this repository to set up Ubuntu on Hyper-V and execute the post-installation tasks.

4. **Follow Script Instructions**:
   - Follow the instructions in the PowerShell script prompts to complete the installation process.
   - Once the installation is complete, the Ubuntu VM will be set up with the development environment configured.

## Post-Installation Scripts

- **Ubuntu Post-Installation Script (No CUDA)**: For Ubuntu on Hyper-V without CUDA support.
  - Script Name: `hyper_v_post_install.sh`
  - GitHub URL: [https://github.com/tomblanchard312/DSWorkloadInstallScripts/blob/main/hyper_v_post_install.sh](https://github.com/tomblanchard312/DSWorkloadInstallScripts/blob/main/hyper_v_post_install.sh)
## Additional Notes

- Ensure that the Ubuntu ISO and post-installation scripts are accessible from your Windows machine.
- Adjust paths and URLs in the scripts as necessary based on your environment.


Feel free to contribute by submitting pull requests or opening issues!

    
