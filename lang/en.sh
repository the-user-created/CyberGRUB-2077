#!/bin/bash

# This script must be sourced by the main install script which sources outs.sh first.

# --- Help Message Function ---
print_help() {
	print_box_top
	print_line "INSTALLATION SCRIPT"
	print_line # Blank line
	print_line "\e[1;31mUsage:"
	print_line "  sudo \$SHELL $0 <operation> [...]"
	print_line
	print_line "\e[1;31mOperations:"
	print_line "  -h, --help: Show this help message"
	print_line "  -l, --list: List available logos"
	print_line "  -L, --logo <logo>: Specify a logo to use"
	print_line "  By default, the 'samurai' logo will be used if none is specified"
	print_box_bottom
}
export -f print_help

# --- Error Messages ---
LNG_ERR_OPT_L1="Invalid option."
LNG_ERR_OPT_L2="Use -h or --help for usage information."
export LNG_ERR_OPT_L1 LNG_ERR_OPT_L2

LNG_ERR_LOGO_L1="Logo not found."
LNG_ERR_LOGO_L2="You can list available logos with \e[1;31m-l\e[1;36m or \e[1;31m--list\e[1;36m."
export LNG_ERR_LOGO_L1 LNG_ERR_LOGO_L2

# --- Logo List ---
LNG_LOGO_TITLE="AVAILABLE LOGOS"
export LNG_LOGO_TITLE

# --- Installation Steps ---
LNG_LOGO_SELECT_STEP="SELECTING LOGO..."
export LNG_LOGO_SELECT_STEP
LNG_LOGO_SELECT_OK="Using logo: %s" # %s will be replaced with the logo name
export LNG_LOGO_SELECT_OK

LNG_ROOT_CHECK_STEP="CHECKING ROOT..."
export LNG_ROOT_CHECK_STEP
LNG_ROOT_FAIL_L1="ACCESS DENIED"
LNG_ROOT_FAIL_L2="Run this script as root [sudo]."
export LNG_ROOT_FAIL_L1 LNG_ROOT_FAIL_L2
LNG_ROOT_OK="ROOT OK"
export LNG_ROOT_OK

LNG_DIR_CHECK_STEP="CHECKING BOOT THEME DIRECTORY..."
export LNG_DIR_CHECK_STEP
LNG_DIR_CREATED_OK="BOOT THEME DIRECTORY CREATED"
export LNG_DIR_CREATED_OK
LNG_DIR_EXISTS_OK="BOOT THEME DIRECTORY OK"
export LNG_DIR_EXISTS_OK

LNG_CP_THEME_STEP="COPYING NEW THEME..."
export LNG_CP_THEME_STEP
LNG_CP_THEME_FAIL="AN ERROR OCCURRED WHILE COPYING THE THEME"
export LNG_CP_THEME_FAIL
LNG_CP_THEME_OK="NEW THEME COPIED"
export LNG_CP_THEME_OK

LNG_CP_LOGO_STEP="COPYING LOGO..."
export LNG_CP_LOGO_STEP
LNG_CP_LOGO_FAIL="AN ERROR OCCURRED WHILE COPYING THE LOGO"
export LNG_CP_LOGO_FAIL
LNG_CP_LOGO_OK="LOGO COPIED"
export LNG_CP_LOGO_OK

LNG_EDIT_GRUB_STEP="EDITING GRUB CONFIG..."
export LNG_EDIT_GRUB_STEP
LNG_EDIT_GRUB_OK="GRUB CONFIG MODIFIED"
export LNG_EDIT_GRUB_OK

LNG_UP_GRUB_STEP="UPDATING GRUB..."
export LNG_UP_GRUB_STEP
LNG_UP_GRUB_FAIL="FAILED TO UPDATE GRUB"
export LNG_UP_GRUB_FAIL
LNG_UP_GRUB_OK="GRUB THEME UPDATED"
export LNG_UP_GRUB_OK
LNG_NO_GRUB_CMD="GRUB update command not found. Please ensure GRUB is installed correctly."
export LNG_NO_GRUB_CMD

# --- Final Message ---
LNG_FINISH_L1="THE THEME HAS BEEN INSTALLED SUCCESSFULLY"
LNG_FINISH_L2="You will now see it at the next reboot."
export LNG_FINISH_L1 LNG_FINISH_L2

# --- Uninstall Script ---
LNG_UN_THEME_DIR_STEP="REMOVING THEME DIRECTORY..."
export LNG_UN_THEME_DIR_STEP
LNG_UN_THEME_DIR_OK="THEME DIRECTORY REMOVED"
export LNG_UN_THEME_DIR_OK
LNG_UN_THEME_DIR_FAIL="FAILED TO REMOVE THEME DIRECTORY"
export LNG_UN_THEME_DIR_FAIL
LNG_UN_THEME_DIR_NOT_FOUND="THEME DIRECTORY NOT FOUND, SKIPPING"
export LNG_UN_THEME_DIR_NOT_FOUND

LNG_UN_EDIT_GRUB_STEP="RESTORING GRUB CONFIG..."
export LNG_UN_EDIT_GRUB_STEP
LNG_UN_EDIT_GRUB_OK="GRUB CONFIG RESTORED"
export LNG_UN_EDIT_GRUB_OK
LNG_UN_EDIT_GRUB_FAIL="FAILED TO RESTORE GRUB CONFIG"
export LNG_UN_EDIT_GRUB_FAIL

LNG_UN_FINISH_L1="THE THEME HAS BEEN UNINSTALLED SUCCESSFULLY"
export LNG_UN_FINISH_L1
LNG_UN_FINISH_L2="System will use default GRUB look on next reboot."
export LNG_UN_FINISH_L2
