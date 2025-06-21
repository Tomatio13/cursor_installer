# Cursor AI Editor Installer for Ubuntu 22.04

A bash script to automatically install Cursor AI editor on Ubuntu 22.04 systems.

## What it does

This installer script:
- Downloads the latest Cursor AI editor AppImage
- Extracts and installs it to your home directory
- Creates desktop integration (application menu entry)
- Sets up a command-line launcher
- Manages multiple versions (keeps up to 3 versions)

## Installation

1. Make the script executable:
```bash
chmod +x install_cursor_to_ubuntu2404.sh
```

2. Run the installer:
```bash
./install_cursor_to_ubuntu2404.sh
```

## What gets installed

- **Application files**: `~/Applications/cursor/`
- **Desktop launcher**: `~/.local/share/applications/cursor.desktop`
- **Command-line script**: `~/.local/bin/cursor`
- **Application icon**: `~/.local/share/icons/cursor.png`
- **Log file**: `~/.local/share/cursor/cursor.log`

## Usage

After installation, you can:
- Launch from application menu (search for "Cursor")
- Run from command line: `cursor`
- Check version: `cursor --version`

## Requirements

- Ubuntu 22.04 (or compatible)
- curl (for downloading)
- Internet connection

## Notes

- The script installs Cursor v1.1.5 by default
- Installation is user-local (no sudo required)
- Automatically handles desktop database updates
- Filters out unnecessary AppImage runtime messages