#!/usr/bin/env bash

profile_gpu_wsl() {
  log_info "Running profile: gpu-wsl"

  if ! is_wsl; then
    log_warn "gpu-wsl profile requested outside WSL. Skipping."
    return 0
  fi

  log_info "WSL GPU support uses the Windows host NVIDIA driver and WSL GPU integration."
  log_info "This profile does not install Linux NVIDIA display drivers inside WSL."

  if command_exists nvidia-smi; then
    log_info "nvidia-smi is available in WSL."
  else
    log_warn "nvidia-smi is not available. Install/update the NVIDIA Windows driver with WSL support on the host."
  fi

  log_info "gpu-wsl profile completed."
}
