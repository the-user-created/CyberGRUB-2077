#!/bin/bash

# Get the script's directory to allow running it from anywhere
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

THEME_NAME="CyberGRUB-2077"
GRUB_CFG="/etc/default/grub"
SYS_LANG="$SCRIPT_DIR/lang/${LANG:0:2}.sh"
THEME_LOGO="samurai"

source "$SCRIPT_DIR/scripts/outs.sh"

printf "$OUT_TITLE"

# Get distro
if [ -f /etc/os-release ]; then
	. /etc/os-release
	DISTRO=$ID
elif [ -f /etc/lsb-release ]; then
	. /etc/lsb-release
	DISTRO=$DISTRIB_ID
elif [ -f /etc/debian_version ]; then
	DISTRO="debian"
elif [ -f /etc/redhat-release ]; then
	DISTRO="rhel"
else
	DISTRO="linux"
fi

# Define THEME_DIR based on distro
if [[ "$DISTRO" == "fedora" || "$DISTRO" == "centos" || "$DISTRO" == "rhel" || "$DISTRO" == "rocky" || "$DISTRO" == "almalinux" ]]; then
	THEME_DIR="/boot/grub2/themes"
	GRUB_CFG_PATH="/boot/grub2/grub.cfg"
else
	THEME_DIR="/boot/grub/themes"
	GRUB_CFG_PATH="/boot/grub/grub.cfg"
fi

# Determine the correct GRUB update command
UPDATE_GRUB_CMD=""
if command -v update-grub &>/dev/null; then
	UPDATE_GRUB_CMD="update-grub"
elif command -v grub2-mkconfig &>/dev/null; then
	UPDATE_GRUB_CMD="grub2-mkconfig -o $GRUB_CFG_PATH"
elif command -v grub-mkconfig &>/dev/null; then
	UPDATE_GRUB_CMD="grub-mkconfig -o $GRUB_CFG_PATH"
fi

# Set lang outs
if [ ! -f "$SYS_LANG" ]; then
	source "$SCRIPT_DIR/lang/en.sh"
else
	# shellcheck source=./lang/${LANG:0:2}.sh
	source "$SYS_LANG"
fi

# Check options
# Suppress getopt's own error messages to show our own
if ! OPTS=$(getopt --options "hlL:" --longoptions "help,list,logo:" --name "$0" -- "$@" 2>/dev/null); then
	printf "\033[1A\033[K" # Clear the line where the user typed the command
	printf "$LNG_ERR_OPT"
	exit 1
fi

eval set -- "$OPTS"

while true; do
	case "$1" in
	-h | --help)
		printf "$LNG_HELP"
		exit 0
		;;
	-l | --list)
		# List available logos from the img/logos directory
		LOGOS=()
		while IFS= read -r -d '' logo_path; do
			logo_name=$(basename "$logo_path" .png)
			LOGOS+=("$logo_name")
		done < <(find "$SCRIPT_DIR/img/logos" -maxdepth 1 -type f -name '*.png' -print0)

		printf "$LNG_LOGO_TITLE"

		COLUMN_WIDTH=16
		NUM_COLUMNS=5

		for ((i = 0; i < ${#LOGOS[@]}; i++)); do
			# Start of a new row
			if ((i % NUM_COLUMNS == 0)); then
				printf "\e[1;31m║\e[1;36m"
			fi

			# Print logo name with padding
			printf "  %-*s" "$((COLUMN_WIDTH - 2))" "${LOGOS[i]}"

			# End of a row or end of the list
			if (((i + 1) % NUM_COLUMNS == 0)) || ((i + 1 == ${#LOGOS[@]})); then
				# If it's an incomplete row, add padding to align the right border
				if (((i + 1) % NUM_COLUMNS != 0)); then
					remaining_cols=$((NUM_COLUMNS - (i + 1) % NUM_COLUMNS))
					printf "%*s" $((remaining_cols * COLUMN_WIDTH)) ""
				fi
				printf "\e[1;31m║\e[0m\n"
			fi
		done
		printf "\e[1;31m%s\e[0m\n" "$(MARGIN ╚ ┘)"
		exit 0
		;;
	-L | --logo)
		# Check if the logo exists
		if [[ ! -f "$SCRIPT_DIR/img/logos/${2}.png" ]]; then
			printf "$LNG_ERR_LOGO"
			exit 1
		else
			THEME_LOGO="$2"
			printf "\033[1A\033[K║ [\e[1;36m%s\e[1;31m] %s║\n\e[1;31m%s\n" "$THEME_LOGO" "$(SPACE "$OUT_LEN"-$((${#THEME_LOGO} + 4)))" "$(MARGIN ╚ ┘)"
		fi
		shift 2
		;;
	--)
		shift
		break
		;;
	*)
		printf "$LNG_ERR_OPT"
		exit 1
		;;
	esac
done

# Check root
printf "$LNG_ROOT_CHECK"
if [ "$EUID" -ne 0 ]; then
	printf "$LNG_ROOT_FAIL"
	exit 1
fi
printf "$LNG_ROOT_OK"

# Create THEME_DIR if it doesn't exist
printf "$LNG_DIR_CHECK"
if [ ! -d "$THEME_DIR" ]; then
	mkdir -p "$THEME_DIR"
	printf "$LNG_DIR_FAIL"
else
	printf "$LNG_DIR_OK"
fi

# Copy theme
printf "$LNG_CP_CHECK"
if cp -r "$SCRIPT_DIR/$THEME_NAME" "$THEME_DIR" >/dev/null 2>&1; then
	printf "$LNG_CP_OK"
else
	printf "$LNG_CP_FAIL"
	exit 1
fi

# Copy logo.png to theme directory
printf "$LNG_LOGO_CHECK"
if cp -f "$SCRIPT_DIR/img/logos/${THEME_LOGO}.png" "${THEME_DIR}/${THEME_NAME}/logo.png" >/dev/null 2>&1; then
	printf "$LNG_LOGO_OK"
else
	printf "$LNG_LOGO_FAIL"
	exit 1
fi

# Modify GRUB
GRUB_THEME_PATH="GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\""
printf "$LNG_EDIT_CHECK"
if grep -qE "^#?GRUB_THEME=" "$GRUB_CFG"; then
	sed -i -E "s|^#?GRUB_THEME=.*|$GRUB_THEME_PATH|" "$GRUB_CFG"
else
	# Added extra line before the GRUB_THEME line
	echo "" >>"$GRUB_CFG"
	echo "$GRUB_THEME_PATH" >>"$GRUB_CFG"
fi
printf "$LNG_EDIT_OK"

# Updating GRUB
printf "$LNG_UP_CHECK"
if [ -n "$UPDATE_GRUB_CMD" ]; then
	# The command needs to be evaluated as it may contain arguments
	if ! eval "$UPDATE_GRUB_CMD" >/dev/null 2>&1; then
		printf "$LNG_UP_FAIL"
		exit 1
	fi
	printf "$LNG_UP_OK"
else
	printf "$LNG_NO_GRUB"
	exit 1
fi

printf "$LNG_FINISH"
