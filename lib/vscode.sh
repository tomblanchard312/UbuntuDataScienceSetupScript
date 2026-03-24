#!/usr/bin/env bash

install_vscode() {
  if command -v code >/dev/null 2>&1; then
    log_info "VS Code is already installed."
    return 0
  fi

  log_info "Installing VS Code from the official Microsoft repository."
  install_prereqs_for_https_repos
  install_keyring_from_url "https://packages.microsoft.com/keys/microsoft.asc" "/etc/apt/keyrings/microsoft.gpg"
  add_apt_repo_deb_line "/etc/apt/sources.list.d/vscode.list" "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main"
  apt_update_once
  install_apt_packages code
}

install_vscode_extensions_from_manifest() {
  local manifest_file="$1"

  if ! command -v code >/dev/null 2>&1; then
    log_warn "Skipping VS Code extension install because 'code' is not available in PATH."
    return 0
  fi

  if [ ! -f "${manifest_file}" ]; then
    log_warn "VS Code extension manifest not found: ${manifest_file}"
    return 0
  fi

  while IFS= read -r extension_id; do
    if [ -z "${extension_id}" ] || [[ "${extension_id}" == \#* ]]; then
      continue
    fi
    if code --list-extensions | grep -Fqx "${extension_id}"; then
      continue
    fi
    code --install-extension "${extension_id}" || log_warn "Failed to install extension ${extension_id}"
  done <"${manifest_file}"
}
