#!/usr/bin/env bash

profile_wsl() {
  log_info "Running profile: wsl"

  if ! is_wsl; then
    log_warn "wsl profile requested outside WSL. Skipping."
    return 0
  fi

  install_apt_packages wslu dos2unix
  log_info "WSL profile completed."
}
