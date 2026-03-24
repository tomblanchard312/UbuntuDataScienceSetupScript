# Architecture

This repository uses a modular shell architecture designed for repeatable, profile-based bootstrap operations.

## Design Goals

- Keep installer logic idempotent and safe to re-run.
- Separate environment detection and platform-specific behavior.
- Keep heavy or specialized tooling opt-in.
- Avoid duplicated logic across Ubuntu, WSL, and Hyper-V flows.

## Components

### Entrypoints

- `ubuntu_post_install.sh`: native Ubuntu entrypoint.
- `wsl_post_install.sh`: WSL-specific entrypoint.
- `hyper_v_post_install.sh`: Hyper-V Ubuntu guest entrypoint.

Each entrypoint:
- Parses arguments and profile selection.
- Loads shared helpers from `lib/`.
- Executes selected profiles from `profiles/`.

### Shared Helpers (`lib/`)

- `logging.sh`: structured logging and fatal-exit helper.
- `common.sh`: generic utility functions and safe file mutation helpers.
- `detect.sh`: OS/environment detection and support checks.
- `apt.sh`: apt update/install/remove and repository helper functions.
- `vscode.sh`: VS Code install and extension manifest application.

### Profiles (`profiles/`)

Profiles encapsulate one concern each and are sourced at runtime. They expose one `profile_<name>` function and do not execute on import.

Examples:
- `base`, `python`, `ml`, `viz`, `db`
- `docker`, `k8s`, `r`
- `gpu-native`, `gpu-wsl`, `wsl`

### Manifests (`manifests/`)

Manifest files define package lists independently of installer logic.

Examples:
- `apt-base.txt`, `apt-db.txt`
- `conda-ml.txt`, `pip-viz.txt`
- `vscode-extensions.txt`

## Execution Model

1. Entrypoint validates environment.
2. Entrypoint parses selected profiles.
3. For each profile:
   - Source profile file.
   - Resolve profile function name.
   - Execute profile function.
4. Shared helpers enforce idempotent operations where possible.

## Idempotency Strategy

- Skip apt packages already installed.
- Only add repository entries when missing.
- Only append shell/file blocks when markers are absent.
- Keep environment-specific steps gated by detection logic.
