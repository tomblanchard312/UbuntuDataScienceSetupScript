#!/usr/bin/env bash

install_miniforge() {
  local install_dir="${HOME}/miniforge3"
  local installer_url="https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
  local installer_path="/tmp/miniforge-installer.sh"

  if [ -x "${install_dir}/bin/conda" ]; then
    log_info "Miniforge already installed at ${install_dir}."
    return 0
  fi

  retry 3 2 curl -fsSL "${installer_url}" -o "${installer_path}" || die "Failed to download Miniforge installer."
  bash "${installer_path}" -b -p "${install_dir}"
  rm -f "${installer_path}"

  ensure_file_contains_block \
    "${HOME}/.profile" \
    "# >>> ubuntu-data-science-setup miniforge >>>" \
    "# <<< ubuntu-data-science-setup miniforge <<<" \
    "export PATH=\"${install_dir}/bin:\$PATH\""

  safe_export_path_hint "${install_dir}/bin"
}

install_anaconda() {
  local install_dir="${HOME}/anaconda3"
  local installer_url="https://repo.anaconda.com/archive/Anaconda3-latest-Linux-x86_64.sh"
  local installer_path="/tmp/anaconda-installer.sh"

  if [ -x "${install_dir}/bin/conda" ]; then
    log_info "Anaconda already installed at ${install_dir}."
    return 0
  fi

  retry 3 2 curl -fsSL "${installer_url}" -o "${installer_path}" || die "Failed to download Anaconda installer."
  bash "${installer_path}" -b -p "${install_dir}"
  rm -f "${installer_path}"

  ensure_file_contains_block \
    "${HOME}/.profile" \
    "# >>> ubuntu-data-science-setup anaconda >>>" \
    "# <<< ubuntu-data-science-setup anaconda <<<" \
    "export PATH=\"${install_dir}/bin:\$PATH\""

  safe_export_path_hint "${install_dir}/bin"
}

profile_python() {
  log_info "Running profile: python"

  install_apt_packages python3 python3-pip python3-venv python3-dev pipx

  if [ "${WITH_MINIFORGE:-0}" -eq 1 ]; then
    install_miniforge
  fi

  if [ "${WITH_ANACONDA:-0}" -eq 1 ]; then
    install_anaconda
  fi

  log_info "Python profile completed."
}
