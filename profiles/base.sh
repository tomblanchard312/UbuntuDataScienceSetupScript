#!/usr/bin/env bash

read_manifest_packages() {
  local manifest_file="$1"
  local packages=()
  local line

  while IFS= read -r line; do
    line="${line%%#*}"
    line="${line//[$'\t\r ']/}"
    if [ -n "${line}" ]; then
      packages+=("${line}")
    fi
  done <"${manifest_file}"

  printf '%s\n' "${packages[@]}"
}

profile_base() {
  log_info "Running profile: base"

  local manifest_file="${ROOT_DIR}/manifests/apt-base.txt"
  [ -f "${manifest_file}" ] || die "Missing manifest: ${manifest_file}"

  mapfile -t base_packages < <(read_manifest_packages "${manifest_file}")
  install_apt_packages "${base_packages[@]}"

  if [ "${INSTALL_VSCODE:-1}" -eq 1 ]; then
    install_vscode
    install_vscode_extensions_from_manifest "${ROOT_DIR}/manifests/vscode-extensions.txt"
  fi

  log_info "Base profile completed."
}
