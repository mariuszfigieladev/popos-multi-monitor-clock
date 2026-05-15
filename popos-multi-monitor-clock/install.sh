#!/bin/bash

set -e

echo "Installing dependencies and modern fonts..."
sudo apt update && sudo apt install conky-all gnome-tweaks fonts-inter x11-xserver-utils -y

echo "Creating configuration directories..."
mkdir -p "$HOME/.config/conky"
mkdir -p "$HOME/.config/autostart"

echo "Deploying configuration files..."
cp config/clock_template.conf "$HOME/.config/conky/"
cp config/launch_clocks.sh "$HOME/.config/conky/"

chmod +x "$HOME/.config/conky/launch_clocks.sh"

echo "Setting up standardized XDG autostart entry..."
cat <<INNER_EOF > "$HOME/.config/autostart/conky_clocks.desktop"
[Desktop Entry]
Type=Application
Exec=bash -c "$HOME/.config/conky/launch_clocks.sh"
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Multi-Monitor Clocks
Comment=Permanent desktop clock widget for each display
INNER_EOF

echo "Setup complete. The clocks will launch automatically on next login."
echo "To test immediately, run: ~/.config/conky/launch_clocks.sh"