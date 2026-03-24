#!/usr/bin/env bash

APT_UPDATED=0

apt_update_once() {
  if [ "${APT_UPDATED}" -eq 0 ]; then
    sudo apt-get update -y
    APT_UPDATED=1
  fi
}

install_apt_packages() {
  local packages=()
  local pkg

  for pkg in "$@"; do
    if ! dpkg -s "${pkg}" >/dev/null 2>&1; then
      packages+=("${pkg}")
    fi
  done

  if [ "${#packages[@]}" -eq 0 ]; then
    log_info "All requested apt packages are already installed."
    return 0
  fi

  apt_update_once
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "${packages[@]}"
}

remove_apt_packages() {
  local packages=()
  local pkg

  for pkg in "$@"; do
    if dpkg -s "${pkg}" >/dev/null 2>&1; then
      packages+=("${pkg}")
    fi
  done

  if [ "${#packages[@]}" -eq 0 ]; then
    return 0
  fi

  apt_update_once
  sudo DEBIAN_FRONTEND=noninteractive apt-get remove -y "${packages[@]}"
}

install_prereqs_for_https_repos() {
  install_apt_packages ca-certificates curl gnupg lsb-release
  sudo install -m 0755 -d /etc/apt/keyrings
}

install_keyring_from_url() {
  local url="$1"
  local output_keyring="$2"
  local tmp_key

  tmp_key="$(mktemp)"
  retry 3 2 curl -fsSL "${url}" -o "${tmp_key}" || die "Failed to download keyring from ${url}"
  sudo gpg --dearmor --yes --output "${output_keyring}" "${tmp_key}"
  sudo chmod a+r "${output_keyring}"
  rm -f "${tmp_key}"
}

add_apt_repo_deb_line() {
  local list_file="$1"
  local repo_line="$2"

  if [ ! -f "${list_file}" ] || ! grep -Fqx "${repo_line}" "${list_file}"; then
    printf '%s\n' "${repo_line}" | sudo tee "${list_file}" >/dev/null
  fi
}
