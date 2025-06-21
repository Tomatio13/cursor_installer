# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains a bash script installer for Cursor AI editor on Ubuntu systems. The main script `install_cursor_to_ubuntu.sh` handles downloading, extracting, and configuring Cursor as a desktop application.

## Key Components

- **install_cursor_to_ubuntu.sh**: Main installation script that:
  - Dynamically fetches the latest Cursor AppImage download URL from GitHub
  - Downloads and extracts the AppImage to `~/Applications/cursor/`
  - Creates desktop integration files
  - Sets up a command-line launcher script in `~/.local/bin/cursor`
  - Manages version control (keeps up to 3 versions)

## Installation Process

The script performs these steps:
1. Creates directory structure in `~/Applications/cursor/` and `~/.local/`
2. Fetches latest download URL from [oslook/cursor-ai-downloads](https://github.com/oslook/cursor-ai-downloads)
3. Downloads the latest Cursor AppImage dynamically
4. Extracts AppImage contents using `--appimage-extract`
5. Creates launcher script with version support and log filtering
6. Installs desktop file for system integration
7. Updates desktop database

## Configuration

- **Download URL**: Dynamically fetched from GitHub repository
- **Installation paths**: All under user home directory (`~/Applications/cursor/`, `~/.local/`)
- **Version management**: Keeps maximum 3 installed versions
- **Logging**: Filtered output goes to `~/.local/share/cursor/cursor.log`
- **Fallback**: Uses known working version if GitHub is unavailable

## Running the Script

```bash
chmod +x install_cursor_to_ubuntu.sh
./install_cursor_to_ubuntu.sh
```

## Documentation

- **README.md**: English documentation with full installation and usage instructions
- **README_JP.md**: Japanese documentation (日本語ドキュメント)
- Both files include language switching badges and consistent formatting

## Compatibility

- **Primary target**: Ubuntu 22.04+
- **Compatible with**: Most modern Linux distributions that support AppImage
- **Requirements**: curl, desktop environment with .desktop file support

## Notes

- Script uses `set -euo pipefail` for robust error handling
- Dynamic version detection and download from official sources
- Icon extraction uses specific path within AppImage structure
- Desktop integration includes MIME type handlers and categories
- Includes interrupt handling for graceful cancellation during download