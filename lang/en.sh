# ENG OUT MESSAGES
# help
LNG_HELP="\033[1A\033[K║ INSTALLATION SCRIPT$(SPACE "$OUT_LEN"-20)║\n║$(SPACE "$OUT_LEN")║\n║\e[1;31m Usage:$(SPACE "$OUT_LEN"-7)║\n║\e[1;36m   sudo \$SHELL $0 <operation> [...]\e[0m$(SPACE "$OUT_LEN"-45)\e[1;31m║\n║$(SPACE "$OUT_LEN")║\n║\e[1;31m Operations:$(SPACE "$OUT_LEN"-12)║\n║\e[1;36m   -h, --help: Show this help message$(SPACE "$OUT_LEN"-37)\e[1;31m║\n║\e[1;36m   -l, --list: List available logos$(SPACE "$OUT_LEN"-35)\e[1;31m║\n║\e[1;36m   -L, --logo <logo>: Specify a logo to use$(SPACE "$OUT_LEN"-43)\e[1;31m║\n║\e[1;36m   By default, the 'samurai' logo will be used if none is specified$(SPACE "$OUT_LEN"-67)\e[1;31m║\n$(MARGIN ╚ ┘)\n"
export LNG_HELP

# generic error
LNG_ERR_OPT="\033[1A\033[K\e[1;31m║\e[1;36m Invalid option. Use -h or --help for usage information.\e[0m$(SPACE "$OUT_LEN"-56)\e[1;31m║\n$(MARGIN ╚ ┘)\n"
export LNG_ERR_OPT

# list logos
LNG_LOGO_TITLE="\033[1A\033[K║ AVAILABLE LOGOS$(SPACE "$OUT_LEN"-16)║\n"
export LNG_LOGO_TITLE
LNG_ERR_LOGO="\033[1A\033[K\e[1;31m║\e[1;36m Logo not found. You can list available logos with \e[1;31m-l\e[1;36m or \e[1;31m--list\e[1;36m.\e[0m$(SPACE "$OUT_LEN"-64)\e[1;31m║\n$(MARGIN ╚ ┘)\n"
export LNG_ERR_LOGO

# copy logo
LNG_LOGO_CHECK="\033[1A\033[K║ COPYING LOGO...$(SPACE "$OUT_LEN"-16)║\n$(MARGIN ╚ ┘)\n"
export LNG_LOGO_CHECK
LNG_LOGO_FAIL="\033[2A\033[K║ AN ERROR OCCURRED WHILE COPYING THE LOGO$(SPACE "$OUT_LEN"-40)║\n$(MARGIN ╚ ┘)\n"
export LNG_LOGO_FAIL
LNG_LOGO_OK="\033[2A\033[K║ LOGO COPIED$(SPACE "$OUT_LEN"-12)║\n$(MARGIN ╚ ┘)\n"
export LNG_LOGO_OK

# check running as root
LNG_ROOT_CHECK="\033[1A\033[K║ CHECKING ROOT...$(SPACE "$OUT_LEN"-17)║\n$(MARGIN ╚ ┘)\n"
export LNG_ROOT_CHECK
LNG_ROOT_FAIL="\033[2A\033[K║ ACCESS DENIED$(SPACE "$OUT_LEN"-14)║\n║     \e[1;36mRun this script as root [sudo].\e[1;31m$(SPACE "$OUT_LEN"-36)║\n$(MARGIN ╚ ┘)\e[0m\n"
export LNG_ROOT_FAIL
LNG_ROOT_OK="\033[2A\033[K║ ROOT OK$(SPACE "$OUT_LEN"-8)║\n$(MARGIN ╚ ┘)\n"
export LNG_ROOT_OK

# check if /boot/grub/themes exist
LNG_DIR_CHECK="\033[1A\033[K║ CHECKING BOOT THEME DIRECTORY...$(SPACE "$OUT_LEN"-33)║\n$(MARGIN ╚ ┘)\n"
export LNG_DIR_CHECK
LNG_DIR_FAIL="\033[2A\033[K║ BOOT THEME DIRECTORY CREATED$(SPACE "$OUT_LEN"-29)║\n$(MARGIN ╚ ┘)\n"
export LNG_DIR_FAIL
LNG_DIR_OK="\033[2A\033[K║ BOOT THEME DIRECTORY OK$(SPACE "$OUT_LEN"-24)║\n$(MARGIN ╚ ┘)\n"
export LNG_DIR_OK

# clone repo
LNG_GIT_CHECK="\033[1A\033[K║ UPDATING THEME FROM GITHUB...$(SPACE "$OUT_LEN"-30)║\n$(MARGIN ╚ ┘)\n"
export LNG_GIT_CHECK
LNG_GIT_FAIL="\033[2A\033[K║ FAILED TO UPDATE. GIT NEEDED, CHECK IF IT IS INSTALLED$(SPACE "$OUT_LEN"-55)║\n$(MARGIN ╚ ┘)\n"
export LNG_GIT_FAIL
LNG_GIT_OK="\033[4A\033[K║ THEME UPDATED$(SPACE "$OUT_LEN"-14)║\n$(MARGIN ╚ ┘)\n"
export LNG_GIT_OK

# copy theme to /boot/grub/themes
LNG_CP_CHECK="\033[1A\033[K║ COPYING NEW THEME...$(SPACE "$OUT_LEN"-21)║\n$(MARGIN ╚ ┘)\n"
export LNG_CP_CHECK
LNG_CP_FAIL="\033[2A\033[K║ AN ERROR OCCURRED WHILE COPYING THE THEME$(SPACE "$OUT_LEN"-41)║\n$(MARGIN ╚ ┘)\n"
export LNG_CP_FAIL
LNG_CP_OK="\033[2A\033[K║ NEW THEME COPIED$(SPACE "$OUT_LEN"-17)║\n$(MARGIN ╚ ┘)\n"
export LNG_CP_OK
# edit grub
LNG_EDIT_CHECK="\033[1A\033[K║ EDITING GRUB CONFIG...$(SPACE "$OUT_LEN"-23)║\n$(MARGIN ╚ ┘)\n"
export LNG_EDIT_CHECK
LNG_EDIT_OK="\033[2A\033[K║ GRUB CONFIG MODIFIED$(SPACE "$OUT_LEN"-21)║\n$(MARGIN ╚ ┘)\n"
export LNG_EDIT_OK
# update grub
LNG_UP_CHECK="\033[1A\033[K║ UPDATING THEME...$(SPACE "$OUT_LEN"-18)║\n$(MARGIN ╚ ┘)\n"
export LNG_UP_CHECK
LNG_UP_FAIL="\033[2A\033[K║ FAILED TO UPDATE THEME$(SPACE "$OUT_LEN"-23)║\n$(MARGIN ╚ ┘)\n"
export LNG_UP_FAIL
LNG_UP_OK="\033[2A\033[K║ GRUB THEME UPDATED$(SPACE "$OUT_LEN"-19)║\n$(MARGIN ╚ ┘)\n"
export LNG_UP_OK
# grub error
LNG_NO_GRUB="\033[2A\033[K║ FAILED TO UPDATE THEME, PLEASE ENSURE GRUB IS INSTALLED CORRECTLY$(SPACE "$OUT_LEN"-66)║\n$(MARGIN ╚ ┘)\n"
export LNG_NO_GRUB
# finish
LNG_FINISH="\033[1A\033[K║ THE THEME HAS BEEN INSTALLED SUCCESSFULLY$(SPACE "$OUT_LEN"-42)║\n║     \e[1;36mYou will now see it at the next reboot.\e[1;31m$(SPACE "$OUT_LEN"-44)║\n$(MARGIN ╚ ┘)\e[0m\n"
export LNG_FINISH
