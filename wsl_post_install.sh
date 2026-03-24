#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${ROOT_DIR}/lib/logging.sh"
source "${ROOT_DIR}/lib/common.sh"
source "${ROOT_DIR}/lib/detect.sh"
source "${ROOT_DIR}/lib/apt.sh"
source "${ROOT_DIR}/lib/vscode.sh"

PROFILES="base,python,wsl"
# Defaults consumed by sourced profiles under ./profiles/
: "${WITH_MINIFORGE:=1}"
: "${WITH_ANACONDA:=0}"
NON_INTERACTIVE=0
LIGHT=0
: "${INSTALL_VSCODE:=1}"

usage() {
	cat <<'EOF'
Usage: ./wsl_post_install.sh [options]

Options:
	--profile <csv>        Comma-separated profiles (default: base,python,wsl)
	--light                Keep setup minimal for WSL
	--with-miniforge       Install Miniforge (default behavior)
	--with-anaconda        Install Anaconda (disables Miniforge)
	--non-interactive      Run without prompts
	--help                 Show this help
EOF
}

while [ "$#" -gt 0 ]; do
	case "$1" in
		--profile)
			[ "$#" -gt 1 ] || die "--profile requires a value"
			PROFILES="$2"
			shift 2
			;;
		--light)
			LIGHT=1
			shift
			;;
		--with-miniforge)
			# shellcheck disable=SC2034
			WITH_MINIFORGE=1
			# shellcheck disable=SC2034
			WITH_ANACONDA=0
			shift
			;;
		--with-anaconda)
			# shellcheck disable=SC2034
			WITH_ANACONDA=1
			# shellcheck disable=SC2034
			WITH_MINIFORGE=0
			shift
			;;
		--non-interactive)
			NON_INTERACTIVE=1
			shift
			;;
		--help)
			usage
			exit 0
			;;
		*)
			die "Unknown argument: $1"
			;;
	esac
done

assert_supported_ubuntu_version
is_wsl || die "This script is for WSL only. Use ./ubuntu_post_install.sh on native Ubuntu."
require_sudo

if ! systemd_enabled; then
	log_warn "WSL systemd is not enabled. Some features may not work as expected."
	cat <<'EOF'
Enable systemd in /etc/wsl.conf:

[boot]
systemd=true

Then restart WSL from Windows:
	wsl --shutdown
EOF
fi

if [ "${LIGHT}" -eq 1 ] && [ "${PROFILES}" = "base,python,wsl" ]; then
	PROFILES="base,python"
fi

run_profile() {
	local requested="$1"
	local profile_name="${requested}"

	case "${requested}" in
		gpu|gpu-native)
			profile_name="gpu-wsl"
			;;
	esac

	local profile_file="${ROOT_DIR}/profiles/${profile_name}.sh"
	[ -f "${profile_file}" ] || die "Profile '${requested}' not found at ${profile_file}"

	# shellcheck disable=SC1090
	source "${profile_file}"

	local fn_name="profile_${profile_name//-/_}"
	declare -F "${fn_name}" >/dev/null 2>&1 || die "Profile function '${fn_name}' not defined in ${profile_file}"

	"${fn_name}"
}

mapfile -t selected_profiles < <(parse_csv_profiles "${PROFILES}")
[ "${#selected_profiles[@]}" -gt 0 ] || die "No profiles selected."

for profile in "${selected_profiles[@]}"; do
	run_profile "${profile}"
done

log_info "Completed WSL bootstrap for profiles: ${PROFILES}"
