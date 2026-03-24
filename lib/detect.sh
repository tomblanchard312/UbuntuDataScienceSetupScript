#!/usr/bin/env bash

ubuntu_version() {
  if [ -r /etc/os-release ]; then
    . /etc/os-release
    printf '%s\n' "${VERSION_ID:-unknown}"
    return 0
  fi
  printf 'unknown\n'
}

is_ubuntu() {
  if [ ! -r /etc/os-release ]; then
    return 1
  fi
  . /etc/os-release
  [ "${ID:-}" = "ubuntu" ]
}

is_wsl() {
  if [ -n "${WSL_INTEROP:-}" ]; then
    return 0
  fi
  if grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
    return 0
  fi
  return 1
}

is_hyperv_guest() {
  if command -v systemd-detect-virt >/dev/null 2>&1; then
    local virt
    virt="$(systemd-detect-virt 2>/dev/null || true)"
    [ "${virt}" = "microsoft" ] || [ "${virt}" = "hyperv" ]
    return $?
  fi

  grep -qi 'hyper-v' /sys/class/dmi/id/product_name 2>/dev/null
}

systemd_enabled() {
  [ -d /run/systemd/system ]
}

assert_supported_ubuntu_version() {
  local version
  version="$(ubuntu_version)"

  if ! is_ubuntu; then
    die "Unsupported distribution. This project supports Ubuntu only."
  fi

  case "${version}" in
    24.04|24.10)
      return 0
      ;;
    *)
      die "Unsupported Ubuntu version '${version}'. Use Ubuntu 24.04 LTS (or compatible 24.x Ubuntu) for this bootstrap."
      ;;
  esac
}
