# Ubuntu Data Science Setup Script

## Overview
This repository provides a modular, profile-based bootstrap system for data science and development environments on:
- Ubuntu 24.04 LTS (native)
- WSL2 (Windows Subsystem for Linux)
- Ubuntu running inside Hyper-V

The project is designed for:
- Reproducible environments
- Safe, idempotent installation
- Optional profiles instead of installing everything by default

---

## Supported Environments

| Environment | Supported | Notes |
|---|---|---|
| Ubuntu 24.04 LTS | Yes | Primary target |
| WSL2 (Ubuntu) | Yes | Separate WSL-specific logic |
| Hyper-V Ubuntu VM | Yes | Uses same modular installer |
| Other Ubuntu versions | Limited | Not fully tested |

---

## Key Features

- Modular profile-based installation
- Idempotent scripts safe to re-run
- Separate handling for native Ubuntu and WSL
- Official Docker installation (Docker Engine + Compose plugin)
- VS Code-based tooling (including SQL support)
- Optional GPU support (native vs WSL separated)
- Lightweight defaults with opt-in components

---

## Installation

### Clone the Repository

```bash
git clone https://github.com/tomblanchard312/UbuntuDataScienceSetupScript.git
cd UbuntuDataScienceSetupScript
```

---

## Usage

### Native Ubuntu

```bash
./ubuntu_post_install.sh --profile base,python,viz
```

---

### WSL

```bash
./wsl_post_install.sh --profile base,python --light
```

WSL requires systemd for some features. If not enabled, instructions will be provided by the script.

---

### Hyper-V

1. Use the PowerShell script to provision the VM.
2. Run the Linux installer inside the VM.

```powershell
.\ubuntu-hyper-v-setup.ps1 -VmName "DataScienceVM"
```

---

## Profiles

Profiles allow you to install only what you need.

| Profile | Description |
|---|---|
| base | Core system tools and dependencies |
| python | Python, pip, virtual environments, optional Miniforge |
| ml | Machine learning libraries |
| viz | Visualization and notebook tools |
| db | Database clients and VS Code SQL tooling |
| docker | Docker Engine and Compose plugin (official install) |
| k8s | Kubernetes CLI tools |
| r | R environment (optional) |
| gpu | GPU support (native Ubuntu only) |
| wsl | WSL-specific optimizations |

---

## Example Configurations

Minimal setup:

```bash
./ubuntu_post_install.sh --profile base,python
```

Data science workstation:

```bash
./ubuntu_post_install.sh --profile base,python,ml,viz
```

Full dev environment:

```bash
./ubuntu_post_install.sh --profile base,python,ml,viz,db,docker
```

WSL lightweight:

```bash
./wsl_post_install.sh --profile base,python --light
```

---

## GPU Support

- Native Ubuntu GPU setup is handled separately.
- WSL GPU support relies on the Windows host NVIDIA driver.
- The scripts do not install Linux GPU drivers inside WSL.

---

## Package Management Notes

- Uses modern APT repository handling (no apt-key).
- Uses official vendor repositories where appropriate.
- Docker is installed via Docker's official repository.
- VS Code is used for development and SQL tooling.

---

## Python Environment Options

- Miniforge or micromamba is the recommended default.
- The installers default to Miniforge unless `--with-anaconda` is provided.
- Anaconda is optional.
- Select behavior with:
	- `--with-miniforge`
	- `--with-anaconda`

---

## Idempotency

- Scripts can be safely re-run.
- Existing installations are detected and skipped where possible.
- The design supports repeatable environment setup.

---

## Repository Structure

```text
lib/        -> shared helpers
profiles/   -> modular install profiles
manifests/  -> package lists
docs/       -> supporting documentation
```

---

## Documentation

- docs/architecture.md
- docs/wsl-notes.md
- docs/gpu-notes.md

---

## Contributing

- Pull requests are welcome.
- Follow shell best practices.
- Ensure scripts remain idempotent.
- Test on Ubuntu 24.04 or WSL.

---

## License

See LICENSE.





