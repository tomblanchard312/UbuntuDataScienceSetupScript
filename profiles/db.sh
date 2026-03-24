#!/usr/bin/env bash

read_db_packages() {
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

profile_db() {
  log_info "Running profile: db"

  local manifest_file="${ROOT_DIR}/manifests/apt-db.txt"
  [ -f "${manifest_file}" ] || die "Missing manifest: ${manifest_file}"

  mapfile -t db_packages < <(read_db_packages "${manifest_file}")
  install_apt_packages "${db_packages[@]}"

  if [ "${INSTALL_VSCODE:-1}" -eq 1 ]; then
    install_vscode
    install_vscode_extensions_from_manifest "${ROOT_DIR}/manifests/vscode-extensions.txt"
    log_info "Legacy SQL GUI packages are intentionally not installed. Use VS Code with SQL extensions instead."
  fi

  log_info "DB profile completed."
}
