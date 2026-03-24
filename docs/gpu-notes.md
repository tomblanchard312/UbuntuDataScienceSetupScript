# GPU Notes

## Native Ubuntu

Use `gpu` (mapped to `gpu-native`) on native Ubuntu hosts.

```bash
./ubuntu_post_install.sh --profile base,python,ml,gpu
```

The repository intentionally avoids hardcoding stale CUDA repository flows. Validate your driver/toolkit path against current vendor guidance for Ubuntu 24.04.

## WSL

Use `gpu` (mapped to `gpu-wsl`) on WSL.

```bash
./wsl_post_install.sh --profile base,python,ml,gpu
```

WSL GPU requires an NVIDIA Windows host driver with WSL support. This project does not install Linux display drivers inside WSL.
