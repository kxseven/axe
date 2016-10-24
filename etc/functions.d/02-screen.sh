# Simple function to print a horizontal rule
_print_hr() {

    local COLUMNS=$(tput cols)

    echo ""
    echo -e "$(counter=0; while [ $counter -lt $COLUMNS ]; do echo -n "="; let counter=counter+1; done)"
    echo ""

}


# Simple function to print a Top level header
_print_head_l1() {

    local COLUMNS=$(tput cols)
    local whitespace="$(counter=0; while [ $counter -lt $COLUMNS ]; do echo -n " "; let counter=counter+1; done)"
    local hr_line="$(counter=0; while [ $counter -lt $COLUMNS ]; do echo -n "="; let counter=counter+1; done)"

    concat_line=$(printf "= %s %s" "$1" "$whitespace")
    let COLUMNS=COLUMNS-2
    fixed_size_format="%-${COLUMNS}.${COLUMNS}s ="
    fixed_size_line=$(printf "$fixed_size_format" "$concat_line")

    echo ""
    echo "$hr_line"
    echo -e "$fixed_size_line"
    echo "$hr_line"
    echo ""

}


# Simple function to print a 2nd level header
_print_head_l2() {

    local COLUMNS=$(tput cols)
    local hr_line="$(counter=0; while [ $counter -lt $COLUMNS ]; do echo -n "="; let counter=counter+1; done)"

    concat_line=$(printf "= %s %s" "$1" "$hr_line")
    fixed_size_format="%-${COLUMNS}.${COLUMNS}s"
    fixed_size_line=$(printf "$fixed_size_format" "$concat_line")

    echo ""
    echo -e "$fixed_size_line"
    echo ""

}

# Simple badge creator
_badge() {
    local badge_name=$1
    local badge_text=$2
    local badge_text_fg_color="${3:-$__fg_white}"
    local badge_text_bg_color="${4:-$__bg_dark_gray}"
    local badge_name_fg_color="${5:-$__fg_black}"
    local badge_name_bg_color="${6:-$__bg_light_gray}"

    echo -e "${badge_name_fg_color}${badge_name_bg_color} ${badge_name} ${badge_text_fg_color}${badge_text_bg_color} ${badge_text} ${__no_color}"
}
