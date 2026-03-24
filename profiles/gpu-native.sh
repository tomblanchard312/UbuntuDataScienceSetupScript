#!/usr/bin/env bash

profile_gpu_native() {
  log_info "Running profile: gpu-native"

  if is_wsl; then
    die "gpu-native profile is not supported in WSL. Use gpu-wsl profile instead."
  fi

  install_apt_packages ubuntu-drivers-common

  if command_exists nvidia-smi; then
    log_info "NVIDIA GPU tooling appears available (nvidia-smi found)."
  else
    log_warn "NVIDIA user-space tooling was not detected. Install/validate host GPU driver support for your hardware and Ubuntu release."
  fi

  log_info "For CUDA toolkit selection, prefer vendor documentation matching Ubuntu 24.04 and your driver stack."
  log_info "gpu-native profile completed."
}
