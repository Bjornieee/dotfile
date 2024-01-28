#!/bin/bash

# Config
monitor="DP-1"
config_dir="$HOME/.config/hypr"
wallpaper_dir="$HOME/.config/hypr/wallpaper"

# Get list of wallpaper file paths
file_listing=("$wallpaper_dir"/*)

function launch_hyprpaper {

    while true; do
        hyprpaper
        sleep 1
    done

}

function hyprpaper_preload {

    # Randomize path listing
    file_listing_random=($(shuf -e "${file_listing[@]}"))

    # Write to hyprpaper.conf
    for wallpaper_path in "${file_listing_random[@]}"; do

        preload_string+="preload = $wallpaper_path\n"
        wallpaper_string+="wallpaper = $monitor, $wallpaper_path\n"

    done

    echo -en "$preload_string""$wallpaper_string" > "$config_dir/hyprpaper.conf"

}

function hyprpaper_set {

    # Set lock
    lockdir=/tmp/go.sh.lock

    if mkdir -- "$lockdir"; then

        # Get one random file path
        file_random=("${file_listing[RANDOM % ${#file_listing[@]}]}")

        # Set wallpaper with hyprctl
        hyprctl hyprpaper wallpaper "$monitor,${file_random[0]}"

        # Remove lockdir when the script finishes, or when it receives a signal
        trap 'rm -rf -- "$lockdir"' 0

    else

        printf >&2 'cannot acquire lock, giving up on %s\n' "$lockdir"

        exit 0

    fi

}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --hyprpaper_preload)
            hyprpaper_preload
            shift
            ;;
        --hyprpaper_set)
            hyprpaper_set
            shift
            ;;
        --rainbow_borders)
            rainbow_borders
            shift
            ;;
        --launch_hyprpaper)
            launch_hyprpaper
            shift
            ;;
        *)
            echo "Error: Unknown option: $key"
            exit 1
            ;;
    esac
done
