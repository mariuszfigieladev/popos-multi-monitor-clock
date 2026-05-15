# Pop!_OS Multi-Monitor Desktop Clock

A lightweight, permanent desktop clock widget that renders in the top-right corner of every connected monitor on Pop!_OS 22.04 LTS (GNOME). Powered by Conky.

## Features
- Displays real-time clock (HH:MM:SS) and full date.
- Locked to the desktop background layer (non-clickable, cannot be accidentally closed).
- Uses distinct Conky instances mapped to independent displays (`xinerama_head`).
- Automates startup natively via XDG autostart.

## Installation

Clone the repository and run the installation script:

```bash
git clone [https://github.com/](https://github.com/)<your-username>/popos-multi-monitor-clock.git
cd popos-multi-monitor-clock
chmod +x install.sh
./install.sh