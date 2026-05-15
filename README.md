# Pop!_OS Multi-Monitor Desktop Clock 🕒💻

Hi there! This project was born out of a very simple, everyday need: I wanted a sleek, minimalist clock displayed in the top-right corner of **each of my three monitors** running Pop!_OS. 

Standard system solutions either clone the clock only on the primary display or completely break down when the workspace architecture gets a bit more complex. This set of scripts configures `Conky` powered by the `Cairo` graphics engine and an event-driven daemon, providing a stable, bug-free, and visually pleasing desktop widget.

---

## 🚀 Features
* **Out-of-the-Box Multi-Monitor Support**: Automatically detects the number of active displays using `xrandr` and attaches an independent widget instance to each one.
* **Modern Minimalist Design**: The clock isn't just plain text. It sits inside a beautiful, semi-transparent dark gray capsule with smooth, rounded corners (rendered natively via `Cairo/Lua`). It also utilizes the clean *Inter* font family (Light weight for the time, Regular weight for the date).
* **Full Automation & Hot-Plug Resilience**: The widget launches automatically on startup. If you unplug and plug back a monitor while working, the built-in monitoring daemon will detect the display layout change and instantly reposition the clocks where they belong.

---

## 🛠 Target Environment
This project was developed and tested on **Pop!_OS 22.04 LTS** (GNOME / Mutter desktop environment running on the X11 display server). It should work flawlessly on any Ubuntu 22.04-based distribution with an active X11 session.

---

## ⚠️ Challenges Overcome (Troubleshooting Guide)

During development, I ran into a few interesting engineering quirks that you might also encounter—especially if you are running a laptop (like a ThinkPad) hooked up to a **docking station (like a Dell WD series)**:

1. **Disappearing Widgets on Screen Reconfiguration**: Standard Conky builds tend to lose their absolute positioning or crash when a video cable is unplugged. I solved this by writing a custom monitoring daemon based on `xev -root` that listens live for `RRScreenChangeNotify` events and completely reinstantiates the widgets in a split second when the layout shifts.
2. **Displays Inactive on Cold Boot (Asynchronous Linux Startup)**: My ThinkPad docked to a Dell station used to completely ignore external monitors during boot, forcing me to physically replug the USB-C cable after hitting the desktop. If you experience this:
    * **In BIOS/UEFI**, head over to `Config -> Display` and change the `Boot Display Device` from *ThinkPad LCD* to **Display on dock** (or *External Monitor*). Also, switch the graphics profile to **Discrete Graphics** so that your dedicated GPU (like an NVIDIA Quadro) immediately powers up the docking ports.
    * **USB Autosuspend**: Linux might put the dock into a deep sleep state before login. Disabling runtime power management for USB via a udev rule in `/etc/udev/rules.d/50-usb-autosuspend.rules` with the content: `ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"` helps keep it awake.
    * **GDM3 Login Screen**: Copy your user monitor layout configuration over to the system directory so that the login manager maps the displays correctly right away: `sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/` and `sudo chown gdm:gdm /var/lib/gdm3/.config/monitors.xml`.

---

## 📦 Installation

Installation is fully automated and handles all dependencies (`conky-all`, `fonts-inter`, `x11-xserver-utils`), populates the configurations, and sets up a secure autostart hook.

1. Clone this repository into your local projects directory:
   ```bash
   git clone https://github.com/mariuszfigieladev/popos-multi-monitor-clock.git
   ```
2. Go to directory:

    ```bash
    cd popos-multi-monitor-clock
    ```
3. Grant execution permissions:

    ```bash
    chmod +x install.sh
    ```
4. Run the installer:

    ```bash
    ./install.sh
    ```
5. A**utomatically**: The installer generates an XDG Autostart entry under ```~/.config/autostart/conky_clocks.desktop```. Every time you log into your system, it will wait a brief moment for the desktop environment to map the displays, then deploy the clocks.

6. **Manually (For testing)**: If you want to force-launch or reload the widgets right away from the terminal, simply run:

    ```bash
    ~/.config/conky/launch_clocks.sh
   ```

## Enjoy your clean desktop layout! The clocks should now gracefully align to the top-right corner of all your screens. Feel free to bump the version, fork, and tweak it to fit your own setup! 🚀