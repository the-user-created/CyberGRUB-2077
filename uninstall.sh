#!/bin/bash

# Get the script's directory to allow running it from anywhere
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

THEME_NAME="CyberGRUB-2077"
GRUB_CFG="/etc/default/grub"
SYS_LANG="$SCRIPT_DIR/lang/${LANG:0:2}.sh"

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

# --- Uninstallation Logic ---

# Open the main uninstallation log box
open_log_box

# Step 1: Check root
log_entry "$LNG_ROOT_CHECK_STEP"
if [ "$EUID" -ne 0 ]; then
	update_last_log_entry "$LNG_ROOT_FAIL_L1"
	log_entry "$LNG_ROOT_FAIL_L2"
	close_log_box
	exit 1
fi
update_last_log_entry "$LNG_ROOT_OK"

# Get distro and paths
if [ -f /etc/os-release ]; then
	. /etc/os-release
	DISTRO=$ID
fi
if [[ "$DISTRO" == "fedora" || "$DISTRO" == "centos" || "$DISTRO" == "rhel" || "$DISTRO" == "rocky" || "$DISTRO" == "almalinux" ]]; then
	THEME_DIR="/boot/grub2/themes"
	GRUB_CFG_PATH="/boot/grub2/grub.cfg"
else
	THEME_DIR="/boot/grub/themes"
	GRUB_CFG_PATH="/boot/grub/grub.cfg"
fi
if command -v update-grub &>/dev/null; then
	UPDATE_GRUB_CMD="update-grub"
elif command -v grub2-mkconfig &>/dev/null; then
	UPDATE_GRUB_CMD="grub2-mkconfig -o $GRUB_CFG_PATH"
elif command -v grub-mkconfig &>/dev/null; then
	UPDATE_GRUB_CMD="grub-mkconfig -o $GRUB_CFG_PATH"
else
	UPDATE_GRUB_CMD=""
fi

THEME_PATH="${THEME_DIR}/${THEME_NAME}"

# Step 2: Remove theme directory
log_entry "$LNG_UN_THEME_DIR_STEP"
if [ -d "$THEME_PATH" ]; then
	if rm -rf "$THEME_PATH"; then
		update_last_log_entry "$LNG_UN_THEME_DIR_OK"
	else
		update_last_log_entry "$LNG_UN_THEME_DIR_FAIL"
		close_log_box
		exit 1
	fi
else
	update_last_log_entry "$LNG_UN_THEME_DIR_NOT_FOUND"
fi

# Step 3: Modify GRUB config to comment out the theme
log_entry "$LNG_UN_EDIT_GRUB_STEP"
# This sed command finds the specific line for our theme and comments it out.
# It's safer than a generic search for GRUB_THEME.
GRUB_THEME_LINE_PATTERN="^GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\""
if grep -q "$GRUB_THEME_LINE_PATTERN" "$GRUB_CFG"; then
	if sed -i -E "s|$GRUB_THEME_LINE_PATTERN|#&|" "$GRUB_CFG"; then
		update_last_log_entry "$LNG_UN_EDIT_GRUB_OK"
	else
		update_last_log_entry "$LNG_UN_EDIT_GRUB_FAIL"
		close_log_box
		exit 1
	fi
else
	# If our specific line isn't there, we just confirm it's okay.
	update_last_log_entry "$LNG_UN_EDIT_GRUB_OK"
fi

# Step 4: Updating GRUB
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

# Final message
log_entry
log_entry "$LNG_UN_FINISH_L1"
log_entry "$LNG_UN_FINISH_L2"

# Close the main log box
close_log_box
