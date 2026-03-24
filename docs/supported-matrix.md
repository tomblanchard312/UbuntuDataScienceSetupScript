# Supported Matrix

| Environment | Status | Notes |
|---|---|---|
| Ubuntu 24.04 LTS (native) | Supported | Primary target |
| WSL2 with Ubuntu 24.04 | Supported | Uses WSL-specific entrypoint and profile logic |
| Ubuntu 24.04 in Hyper-V | Supported | Uses shared Linux modules and profiles |
| Other Ubuntu releases | Limited | May work, but not validated by this repository |

## Notes

- Use `ubuntu_post_install.sh` for native Ubuntu.
- Use `wsl_post_install.sh` for WSL.
- Use `hyper_v_post_install.sh` for Ubuntu guests in Hyper-V.
- GPU handling differs between native Linux and WSL. See `docs/gpu-notes.md`.
