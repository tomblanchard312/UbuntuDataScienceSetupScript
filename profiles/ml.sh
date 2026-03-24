#!/usr/bin/env bash

read_conda_packages() {
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

find_conda_executable() {
  local candidates=(
    "${HOME}/miniforge3/bin/conda"
    "${HOME}/anaconda3/bin/conda"
  )
  local path_candidate

  if command -v conda >/dev/null 2>&1; then
    command -v conda
    return 0
  fi

  for path_candidate in "${candidates[@]}"; do
    if [ -x "${path_candidate}" ]; then
      printf '%s\n' "${path_candidate}"
      return 0
    fi
  done

  return 1
}

profile_ml() {
  log_info "Running profile: ml"

  local manifest_file="${ROOT_DIR}/manifests/conda-ml.txt"
  [ -f "${manifest_file}" ] || die "Missing manifest: ${manifest_file}"

  mapfile -t ml_packages < <(read_conda_packages "${manifest_file}")

  if conda_path="$(find_conda_executable)"; then
    "${conda_path}" install -y -c conda-forge "${ml_packages[@]}"
  else
    log_warn "Conda not found. Falling back to pip for a reduced ML package set."
    python3 -m pip install --upgrade pip
    python3 -m pip install numpy pandas scikit-learn scipy matplotlib seaborn jupyterlab ipykernel
  fi

  log_info "ML profile completed."
}
