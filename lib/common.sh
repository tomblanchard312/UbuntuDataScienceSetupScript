#!/usr/bin/env bash

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

require_sudo() {
  if [ "${EUID}" -eq 0 ]; then
    return 0
  fi

  if ! command_exists sudo; then
    die "sudo is required but was not found."
  fi

  if ! sudo -v; then
    die "Failed to acquire sudo privileges."
  fi
}

ensure_directory() {
  local dir_path="$1"
  mkdir -p "${dir_path}"
}

retry() {
  local attempts="$1"
  local delay_seconds="$2"
  shift 2

  local i
  for i in $(seq 1 "${attempts}"); do
    if "$@"; then
      return 0
    fi
    if [ "${i}" -lt "${attempts}" ]; then
      sleep "${delay_seconds}"
    fi
  done
  return 1
}

maybe_run() {
  local prompt="$1"
  shift

  if [ "${NON_INTERACTIVE:-0}" -eq 1 ]; then
    "$@"
    return $?
  fi

  read -r -p "${prompt} [y/N]: " response
  case "${response}" in
    y|Y|yes|YES)
      "$@"
      ;;
    *)
      log_info "Skipped: ${prompt}"
      ;;
  esac
}

parse_csv_profiles() {
  local csv="$1"
  local item

  csv="${csv// /}"
  IFS=',' read -r -a _profile_array <<<"${csv}"
  for item in "${_profile_array[@]}"; do
    if [ -n "${item}" ]; then
      printf '%s\n' "${item}"
    fi
  done
}

append_line_if_missing() {
  local file_path="$1"
  local line="$2"

  touch "${file_path}"
  if ! grep -Fqx "${line}" "${file_path}"; then
    printf '%s\n' "${line}" >>"${file_path}"
  fi
}

ensure_file_contains_block() {
  local file_path="$1"
  local begin_marker="$2"
  local end_marker="$3"
  local block_content="$4"

  touch "${file_path}"
  if grep -Fq "${begin_marker}" "${file_path}"; then
    return 0
  fi

  {
    printf '\n%s\n' "${begin_marker}"
    printf '%s\n' "${block_content}"
    printf '%s\n' "${end_marker}"
  } >>"${file_path}"
}

safe_export_path_hint() {
  local path_value="$1"
  log_info "To use this toolchain immediately in your current shell, run: export PATH=\"${path_value}:\$PATH\""
}
