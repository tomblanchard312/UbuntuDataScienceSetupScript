#!/usr/bin/env bash

profile_k8s() {
  log_info "Running profile: k8s"

  if ! command_exists kubectl; then
    install_apt_packages kubectl || log_warn "kubectl was not installed from current apt sources. Add your preferred Kubernetes repo if needed."
  fi

  if ! command_exists helm; then
    local helm_script="/tmp/get-helm-3"
    retry 3 2 curl -fsSL "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3" -o "${helm_script}" || die "Failed to download Helm installer script."
    chmod +x "${helm_script}"
    sudo "${helm_script}"
    rm -f "${helm_script}"
  fi

  log_info "k8s profile completed."
}
