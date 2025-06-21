# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains a bash script installer for Cursor AI editor on Ubuntu 22.04. The main script `install_cursor_to_ubuntu2404.sh` handles downloading, extracting, and configuring Cursor as a desktop application.

## Key Components

- **install_cursor_to_ubuntu2404.sh**: Main installation script that:
  - Downloads Cursor AppImage from official source
  - Extracts the AppImage to `~/Applications/cursor/`
  - Creates desktop integration files
  - Sets up a command-line launcher script in `~/.local/bin/cursor`
  - Manages version control (keeps up to 3 versions)

## Installation Process

The script performs these steps:
1. Creates directory structure in `~/Applications/cursor/` and `~/.local/`
2. Downloads latest Cursor AppImage (currently v1.1.5)
3. Extracts AppImage contents using `--appimage-extract`
4. Creates launcher script with version support and log filtering
5. Installs desktop file for system integration
6. Updates desktop database

## Configuration

- **Download URL**: Hardcoded to specific Cursor version (line 22)
- **Installation paths**: All under user home directory (`~/Applications/cursor/`, `~/.local/`)
- **Version management**: Keeps maximum 3 installed versions
- **Logging**: Filtered output goes to `~/.local/share/cursor/cursor.log`

## Running the Script

```bash
chmod +x install_cursor_to_ubuntu2404.sh
./install_cursor_to_ubuntu2404.sh
```

## Notes

- Script uses `set -euo pipefail` for error handling
- Download section is currently commented out (lines 52-71)
- Icon extraction uses specific path within AppImage structure
- Desktop integration includes MIME type handlers and categories