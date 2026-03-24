# Project Index

This file is a quick navigation guide for UbuntuDataScienceSetupScript.

## Start Here

- [README.md](README.md): user-facing installation and usage guide.
- [docs/supported-matrix.md](docs/supported-matrix.md): support matrix by environment.
- [docs/architecture.md](docs/architecture.md): module, manifest, and profile design.

## Entrypoints

- [ubuntu_post_install.sh](ubuntu_post_install.sh): native Ubuntu entrypoint.
- [wsl_post_install.sh](wsl_post_install.sh): WSL-focused entrypoint.
- [hyper_v_post_install.sh](hyper_v_post_install.sh): Hyper-V Ubuntu guest entrypoint.
- [ubuntu-hyper-v-setup.ps1](ubuntu-hyper-v-setup.ps1): Hyper-V VM provisioning helper.

## Core Modules

- [lib/logging.sh](lib/logging.sh): logging and fatal error helpers.
- [lib/common.sh](lib/common.sh): shared utility helpers and idempotent file editing helpers.
- [lib/detect.sh](lib/detect.sh): OS/environment detection and support checks.
- [lib/apt.sh](lib/apt.sh): apt repository and package helper functions.
- [lib/vscode.sh](lib/vscode.sh): VS Code install and extension manifest handling.

## Profiles

- [profiles/base.sh](profiles/base.sh): baseline packages and optional VS Code.
- [profiles/python.sh](profiles/python.sh): Python + Miniforge/Anaconda selection.
- [profiles/ml.sh](profiles/ml.sh): ML package installation.
- [profiles/viz.sh](profiles/viz.sh): visualization/notebook packages.
- [profiles/db.sh](profiles/db.sh): database clients and VS Code SQL path.
- [profiles/docker.sh](profiles/docker.sh): Docker official repository installation.
- [profiles/k8s.sh](profiles/k8s.sh): Kubernetes CLI tooling.
- [profiles/r.sh](profiles/r.sh): optional R environment.
- [profiles/gpu-native.sh](profiles/gpu-native.sh): native Ubuntu GPU path.
- [profiles/gpu-wsl.sh](profiles/gpu-wsl.sh): WSL GPU user-space guidance.
- [profiles/wsl.sh](profiles/wsl.sh): WSL-specific package adjustments.

## Manifests

- [manifests/apt-base.txt](manifests/apt-base.txt)
- [manifests/apt-db.txt](manifests/apt-db.txt)
- [manifests/conda-ml.txt](manifests/conda-ml.txt)
- [manifests/pip-viz.txt](manifests/pip-viz.txt)
- [manifests/vscode-extensions.txt](manifests/vscode-extensions.txt)

## Validation and Editor Standards

- [.editorconfig](.editorconfig): consistent formatting defaults.
- [.github/workflows/validation.yml](.github/workflows/validation.yml): shell lint/format validation.
