#!/bin/bash

# Total inner width of the box. The full line width will be this + 4 (for "║ " and " ║").
readonly OUT_WIDTH=80
readonly BORDER_COLOR="\e[1;31m"
readonly TEXT_COLOR="\e[1;36m"
readonly RESET_COLOR="\e[0m"

# Calculates the visible length of a string by stripping ANSI escape codes.
get_visible_len() {
    local text="$1"
    local stripped_text
    stripped_text=$(echo -n -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    echo -n "${#stripped_text}"
}

# Prints the top border of the box.
print_box_top() {
    local line=""
    for ((i = 0; i < OUT_WIDTH + 2; i++)); do line+="═"; done
    printf "%b╔%s╗%b\n" "$BORDER_COLOR" "$line" "$RESET_COLOR"
}

# Prints the bottom border of the box.
print_box_bottom() {
    local line=""
    for ((i = 0; i < OUT_WIDTH + 2; i++)); do line+="═"; done
    printf "%b╚%s╝%b\n" "$BORDER_COLOR" "$line" "$RESET_COLOR"
}

# Prints one or more lines of text, padded within the box.
print_line() {
    if [ $# -eq 0 ]; then
        printf "%b║ %*s ║%b\n" "$BORDER_COLOR" "$OUT_WIDTH" "" "$RESET_COLOR"
        return
    fi

    for text in "$@"; do
        local visible_len
        visible_len=$(get_visible_len "$text")
        local padding=$((OUT_WIDTH - visible_len))
        [ $padding -lt 0 ] && padding=0

        local colorized_text="${TEXT_COLOR}${text}"
        printf "%b║ %b%*s %b║%b\n" "$BORDER_COLOR" "$colorized_text" "$padding" "" "$BORDER_COLOR" "$RESET_COLOR"
    done
}

# Prints the script title box.
print_title() {
    print_box_top
    print_line "\e[3;31mCyberGRUB 2077"
    print_box_bottom
}

# Opens the log box by printing the top border.
open_log_box() {
    print_box_top
}

# Closes the log box by printing the bottom border.
close_log_box() {
    print_box_bottom
}

# Prints one or more lines of text as new entries in the open log box.
log_entry() {
    print_line "$@"
}

# Updates the VERY LAST line printed in the log box.
# Used to change "Checking..." to "OK".
# NOTE: This only works for single-line updates.
update_last_log_entry() {
    # Move cursor up one line, clear the line, then print the new content.
    printf "\033[1A\033[K"
    print_line "$@"
}

export -f get_visible_len print_box_top print_box_bottom print_line print_title
export -f open_log_box close_log_box log_entry update_last_log_entry
