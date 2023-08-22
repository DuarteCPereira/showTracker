#!/bin/bash

# Function to read and update Dragon Ball episode number
update_episode_number() {
    file_path="dragon_ball_episode.txt"

    if [ ! -f "$file_path" ]; then
        echo "dragon ball - ep1" > "$file_path"
    fi

    current_episode=$(cat "$file_path" | grep -oE 'ep[0-9]+' | grep -oE '[0-9]+')

    case "$1" in
        "add")
            new_episode=$((current_episode + 1))
            sed -i "s/ep$current_episode/ep$new_episode/" "$file_path"
            echo "Updated to Dragon Ball - ep$new_episode"
            ;;
        "less")
            if [ "$current_episode" -gt 1 ]; then
                new_episode=$((current_episode - 1))
                sed -i "s/ep$current_episode/ep$new_episode/" "$file_path"
                echo "Updated to Dragon Ball - ep$new_episode"
            else
                echo "Episode cannot be less than 1."
            fi
            ;;
        "setEpisode")
            if [ -z "$2" ]; then
                echo "Please provide the episode number to set."
            else
                if [[ "$2" =~ ^[0-9]+$ ]]; then
                    sed -i "s/ep$current_episode/ep$2/" "$file_path"
                    echo "Updated to Dragon Ball - ep$2"
                else
                    echo "Invalid episode number provided."
                fi
            fi
            ;;
        "help")
            echo "Available commands:"
            echo "  - ./dragon_ball.sh : Display the current episode."
            echo "  - ./dragon_ball.sh add : Increment the episode number."
            echo "  - ./dragon_ball.sh less : Decrement the episode number (if greater than 1)."
            echo "  - ./dragon_ball.sh setEpisode <episode_number> : Manually set the episode number."
            ;;
        *)
            echo "Dragon Ball - ep$current_episode"
            ;;
    esac
}

# Call the function with the provided argument(s)
update_episode_number "$@"
