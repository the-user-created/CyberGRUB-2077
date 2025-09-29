#!/bin/bash

# Get the script's directory to allow running it from anywhere
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

THEME_NAME="CyberGRUB-2077"
GRUB_CFG="/etc/default/grub"
SYS_LANG="$SCRIPT_DIR/lang/${LANG:0:2}.sh"
THEME_LOGO="samurai"

# Source the printing utilities
source "$SCRIPT_DIR/scripts/outs.sh"

# Set lang outs
if [ ! -f "$SYS_LANG" ]; then
	source "$SCRIPT_DIR/lang/en.sh"
else
	# shellcheck source=./lang/en.sh
	source "$SYS_LANG"
fi

print_title

# --- Argument Parsing ---
if ! OPTS=$(getopt --options "hlL:" --longoptions "help,list,logo:" --name "$0" -- "$@" 2>/dev/null); then
	print_box_top
	print_line "$LNG_ERR_OPT_L1" "$LNG_ERR_OPT_L2"
	print_box_bottom
	exit 1
fi

eval set -- "$OPTS"

while true; do
	case "$1" in
	-h | --help)
		print_help # Use the function from lang file
		exit 0
		;;
	-l | --list)
		LOGOS=()
		while IFS= read -r -d '' logo_path; do
			logo_name=$(basename "$logo_path" .png)
			LOGOS+=("$logo_name")
		done < <(find "$SCRIPT_DIR/img/logos" -maxdepth 1 -type f -name '*.png' -print0 | sort -z)

        print_box_top
        print_line "$LNG_LOGO_TITLE"
        print_line
		COLUMN_WIDTH=18
		NUM_COLUMNS=4
        current_line=""
		for ((i = 0; i < ${#LOGOS[@]}; i++)); do
            current_line+=$(printf "%-*s" "$COLUMN_WIDTH" "${LOGOS[i]}")
			if (((i + 1) % NUM_COLUMNS == 0)) || ((i + 1 == ${#LOGOS[@]})); then
                print_line "$current_line"
                current_line=""
			fi
		done
		print_box_bottom
		exit 0
		;;
	-L | --logo)
		if [[ ! -f "$SCRIPT_DIR/img/logos/${2}.png" ]]; then
			print_box_top
			print_line "$LNG_ERR_LOGO_L1" "$LNG_ERR_LOGO_L2"
			print_box_bottom
			exit 1
		else
			THEME_LOGO="$2"
		fi
		shift 2
		;;
	--)
		shift
		break
		;;
	*)
		print_box_top
		print_line "$LNG_ERR_OPT_L1" "$LNG_ERR_OPT_L2"
		print_box_bottom
		exit 1
		;;
	esac
done

# --- Installation Logic ---

# Open the main installation log box
open_log_box

# Step 0: Announce selected logo
log_entry "$(printf "$LNG_LOGO_SELECT_OK" "$THEME_LOGO")"

# Step 1: Check root
log_entry "$LNG_ROOT_CHECK_STEP"
if [ "$EUID" -ne 0 ]; then
	update_last_log_entry "$LNG_ROOT_FAIL_L1"
    log_entry "$LNG_ROOT_FAIL_L2" # Add the second error line
    close_log_box
	exit 1
fi
update_last_log_entry "$LNG_ROOT_OK"

# Get distro and paths
if [ -f /etc/os-release ]; then . /etc/os-release; DISTRO=$ID; fi
if [[ "$DISTRO" == "fedora" || "$DISTRO" == "centos" || "$DISTRO" == "rhel" || "$DISTRO" == "rocky" || "$DISTRO" == "almalinux" ]]; then
	THEME_DIR="/boot/grub2/themes"; GRUB_CFG_PATH="/boot/grub2/grub.cfg"
else
	THEME_DIR="/boot/grub/themes"; GRUB_CFG_PATH="/boot/grub/grub.cfg"
fi
if command -v update-grub &>/dev/null; then UPDATE_GRUB_CMD="update-grub"
elif command -v grub2-mkconfig &>/dev/null; then UPDATE_GRUB_CMD="grub2-mkconfig -o $GRUB_CFG_PATH"
elif command -v grub-mkconfig &>/dev/null; then UPDATE_GRUB_CMD="grub-mkconfig -o $GRUB_CFG_PATH"
else UPDATE_GRUB_CMD=""
fi

# Step 2: Create THEME_DIR if it doesn't exist
log_entry "$LNG_DIR_CHECK_STEP"
if [ ! -d "$THEME_DIR" ]; then
	mkdir -p "$THEME_DIR"
	update_last_log_entry "$LNG_DIR_CREATED_OK"
else
	update_last_log_entry "$LNG_DIR_EXISTS_OK"
fi

# Step 3: Copy theme
log_entry "$LNG_CP_THEME_STEP"
if cp -r "$SCRIPT_DIR/$THEME_NAME" "$THEME_DIR" >/dev/null 2>&1; then
	update_last_log_entry "$LNG_CP_THEME_OK"
else
	update_last_log_entry "$LNG_CP_THEME_FAIL"
    close_log_box
	exit 1
fi

# Step 4: Copy logo.png to theme directory
log_entry "$LNG_CP_LOGO_STEP"
if cp -f "$SCRIPT_DIR/img/logos/${THEME_LOGO}.png" "${THEME_DIR}/${THEME_NAME}/logo.png" >/dev/null 2>&1; then
	update_last_log_entry "$LNG_CP_LOGO_OK"
else
	update_last_log_entry "$LNG_CP_LOGO_FAIL"
    close_log_box
	exit 1
fi

# Step 5: Modify GRUB config
log_entry "$LNG_EDIT_GRUB_STEP"
GRUB_THEME_PATH="GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\""
if grep -qE "^#?GRUB_THEME=" "$GRUB_CFG"; then
	sed -i -E "s|^#?GRUB_THEME=.*|$GRUB_THEME_PATH|" "$GRUB_CFG"
else
	echo "" >>"$GRUB_CFG"
	echo "$GRUB_THEME_PATH" >>"$GRUB_CFG"
fi
update_last_log_entry "$LNG_EDIT_GRUB_OK"

# Step 6: Updating GRUB
log_entry "$LNG_UP_GRUB_STEP"
if [ -n "$UPDATE_GRUB_CMD" ]; then
	if ! eval "$UPDATE_GRUB_CMD" >/dev/null 2>&1; then
		update_last_log_entry "$LNG_UP_GRUB_FAIL"
        close_log_box
		exit 1
	fi
	update_last_log_entry "$LNG_UP_GRUB_OK"
else
	update_last_log_entry "$LNG_NO_GRUB_CMD"
    close_log_box
	exit 1
fi

# Final message, inside the same box
log_entry
log_entry "$LNG_FINISH_L1"
log_entry "$LNG_FINISH_L2"

# Close the main installation log box
close_log_box
