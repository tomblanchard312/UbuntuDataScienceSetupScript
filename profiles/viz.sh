#!/usr/bin/env bash

read_pip_packages() {
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

profile_viz() {
  log_info "Running profile: viz"

  local manifest_file="${ROOT_DIR}/manifests/pip-viz.txt"
  [ -f "${manifest_file}" ] || die "Missing manifest: ${manifest_file}"

  mapfile -t viz_packages < <(read_pip_packages "${manifest_file}")
  python3 -m pip install --upgrade pip
  python3 -m pip install "${viz_packages[@]}"

  log_info "Viz profile completed."
}
