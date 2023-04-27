#!/bin/bash

# Set up the game
town_names=("Goodsprings" "Primm" "Novac" "New Vegas")
town_locations=("Goodsprings Cemetery" "Primm" "Dino Dee-lite motel" "The Strip")
hostile_names=("Raider" "Feral Ghoul" "Super Mutant" "Deathclaw")
friendly_names=("Prospector" "Trader" "Wastelander" "NCR Ranger")
quests=("Find water chip" "Retrieve lost item" "Deliver package" "Clear out raiders" "Rescue captive")

current_town=${town_names[$((RANDOM%4))]}
health=100
damage=20
bottle_caps=0
inventory=()

# Introduction
echo "Welcome to Fallout Bash!"
echo "You find yourself in a post-apocalyptic wasteland."
echo "Your goal is to survive and thrive in this harsh world."
echo "Type 'help' for a list of commands."

# Game loop
while true; do
    read -p "> " command

    case $command in
        help)
            echo "Commands:"
            echo "  help - display this help message"
            echo "  move [north|south|east|west] - move to a new location"
            echo "  look - describe the current town and randomly encounter an NPC"
            echo "  talk - randomly encounter a quest-giving NPC"
            echo "  battle - randomly encounter a hostile NPC"
            echo "  trade - randomly encounter a friendly NPC who can trade with you"
            echo "  inventory - list your current inventory"
            echo "  stats - show your current health, damage, and bottle caps"
            echo "  quit - quit the game"
            ;;
        move)
            read -p "Which direction? " direction
            if [[ $direction == "north" || $direction == "south" || $direction == "east" || $direction == "west" ]]; then
                echo "You travel $direction."
                current_town=${town_names[$((RANDOM%4))]}
                health=$((health - 10))
                if [[ $health -le 0 ]]; then
                    echo "You died! Game over."
                    exit 0
                fi
            else
                echo "Invalid direction. Type 'help' for a list of commands"
            fi
            ;;
        look)
            # Describe the current town
            for i in ${!town_names[@]}; do
                if [[ $town_locations[$i] == $current_town ]]; then
                    echo "You are in ${town_names[$i]}."
                    if [[ $((RANDOM%2)) -eq 0 ]]; then
                        # Randomly encounter NPC
                        if [[ $((RANDOM%2)) -eq 0 ]]; then
                            # Hostile NPC
                            npc_name=${hostile_names[$((RANDOM%4))]}
                            echo "You see a $npc_name! They attack you!"
                            health=$((health - damage))
                            if [[ $health -le 0 ]]; then
                                echo "You died! Game over."
                                exit 0
                            fi
                        else
                            # Friendly NPC
                            npc_name=${friendly_names[$((RANDOM%4))]}
                            echo "You see a $npc_name. They offer to help you."
                            read -p "Do you accept their help? (y/n): " accept_help
                            if [[ $accept_help == "y" ]]; then
                                # Give a random item or bottle caps
                                item=$((RANDOM%4))
                                case $item in
                        0)
                            inventory+=("Pistol")
                            echo "The $npc_name gives you a Pistol!"
                            ;;
                        1)
                            inventory+=("Medkit")
                            echo "The $npc_name gives you a Medkit!"
                            ;;
                        2)
                            inventory+=("Food")
                            echo "The $npc_name gives you some Food!"
                            ;;
                        3)
                            caps=$((RANDOM%10+1))
                            inventory+=("Bottle caps")
                            bottle_caps=$((bottle_caps + caps))
                            echo "The $npc_name gives you $caps Bottle caps!"
                            ;;
                    esac
                fi
            fi
            ;;
        quit)
            echo "Goodbye! Thanks for playing!"
            exit 0
            ;;
        *)
            echo "Invalid command. Type 'help' for a list of commands"
            ;;
    esac
done

