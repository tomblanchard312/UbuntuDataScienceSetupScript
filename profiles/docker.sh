#!/usr/bin/env bash

profile_docker() {
  log_info "Running profile: docker"

  remove_apt_packages docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc

  install_prereqs_for_https_repos
  install_keyring_from_url "https://download.docker.com/linux/ubuntu/gpg" "/etc/apt/keyrings/docker.gpg"

  . /etc/os-release
  add_apt_repo_deb_line \
    "/etc/apt/sources.list.d/docker.list" \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${VERSION_CODENAME} stable"

  apt_update_once
  install_apt_packages docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  local target_user
  target_user="${SUDO_USER:-${USER}}"
  if [ -n "${target_user}" ] && id -nG "${target_user}" | grep -qw docker; then
    log_info "User '${target_user}' is already in the docker group."
  elif [ -n "${target_user}" ]; then
    sudo usermod -aG docker "${target_user}"
    log_info "Added '${target_user}' to docker group. Re-login is required for group changes to apply."
  fi

  log_info "Docker profile completed."
}
