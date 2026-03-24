#!/usr/bin/env bash

profile_r() {
  log_info "Running profile: r"
  install_apt_packages r-base r-base-dev
  log_info "R profile completed. RStudio is not installed by default."
}
