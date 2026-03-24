#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${ROOT_DIR}/lib/logging.sh"
source "${ROOT_DIR}/lib/common.sh"
source "${ROOT_DIR}/lib/detect.sh"
source "${ROOT_DIR}/lib/apt.sh"
source "${ROOT_DIR}/lib/vscode.sh"

PROFILES="base,python"
# Defaults consumed by sourced profiles under ./profiles/
: "${WITH_MINIFORGE:=1}"
: "${WITH_ANACONDA:=0}"
NON_INTERACTIVE=0
FULL_UPGRADE=0
: "${INSTALL_VSCODE:=1}"

usage() {
	cat <<'EOF'
Usage: ./ubuntu_post_install.sh [options]

Options:
	--profile <csv>        Comma-separated profiles (default: base,python)
	--with-miniforge       Install Miniforge (default behavior)
	--with-anaconda        Install Anaconda (disables Miniforge)
	--non-interactive      Run without prompts
	--full-upgrade         Run apt full-upgrade before profiles
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
		--full-upgrade)
			FULL_UPGRADE=1
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
if is_wsl; then
	log_warn "WSL environment detected. For WSL-specific defaults, prefer ./wsl_post_install.sh."
fi

require_sudo

if [ "${FULL_UPGRADE}" -eq 1 ]; then
	apt_update_once
	sudo DEBIAN_FRONTEND=noninteractive apt-get full-upgrade -y
fi

run_profile() {
	local requested="$1"
	local profile_name="${requested}"

	case "${requested}" in
		gpu)
			if is_wsl; then
				profile_name="gpu-wsl"
			else
				profile_name="gpu-native"
			fi
			;;
		wsl)
			if ! is_wsl; then
				log_warn "Skipping wsl profile outside WSL."
				return 0
			fi
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

log_info "Completed Ubuntu bootstrap for profiles: ${PROFILES}"
