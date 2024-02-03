#!/bin/sh

# Quit all running waybar instances
killall waybar
sleep 0.2

# Load the configuration
waybar -c $HOME/.config/waybar/config -s $HOME/.config/waybar/style.css &
