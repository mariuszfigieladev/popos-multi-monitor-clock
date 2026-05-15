#!/bin/bash

# Allow the display manager to fully map all monitor geometries
sleep 15

# Dynamic fallback to primary local display socket if environment is bare
if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

# Terminate any existing conky instances
killall conky 2>/dev/null

# Directory for runtime configurations
runtime_dir="/tmp/conky_clocks"
mkdir -p "$runtime_dir"
rm -f "$runtime_dir"/*

# Detect the number of connected monitors via xrandr
monitor_count=$(xrandr --listmonitors | grep -c '^[ ]*[0-9]\+:')

# Loop through each monitor index and generate configuration maps
for ((i=0; i<monitor_count; i++)); do
    config_file="$runtime_dir/clock_monitor_$i.conf"
    
    cp "$HOME/.config/conky/clock_template.conf" "$config_file"
    
    # Inject the accurate xinerama display target into the runtime configuration block
    sed -i "s/gap_y = .*/gap_y = 60,\n    xinerama_head = $i,/g" "$config_file"
    
    # Execute conky instance bound to specific monitor viewport
    conky --config="$config_file" &
done

exit 0