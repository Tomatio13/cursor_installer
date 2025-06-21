<h1 align="center">🖥️ Cursor AI Editor Installer for Ubuntu</h1>

<p align="center">
    <img src="https://img.shields.io/badge/Ubuntu-22.04+-orange?style=for-the-badge&logo=ubuntu" alt="Ubuntu 22.04+"/>
    <img src="https://img.shields.io/badge/Bash-Script-green?style=for-the-badge&logo=gnu-bash" alt="Bash Script"/>
    <img src="https://img.shields.io/badge/AppImage-Installer-blue?style=for-the-badge" alt="AppImage"/>
</p>

<p align="center">
    <a href="README_JP.md"><img src="https://img.shields.io/badge/ドキュメント-日本語-white.svg" alt="JA doc"/></a>
    <a href="README.md"><img src="https://img.shields.io/badge/english-document-white.svg" alt="EN doc"></a>
</p>

<p align="center">
    A bash script to automatically install Cursor AI editor on Ubuntu systems.
</p>

## ✨ What it does

This installer script:
- **🔄 Automatically fetches the latest** Cursor AI editor AppImage from GitHub
- **📥 Downloads and extracts** the AppImage to your home directory
- **🖥️ Creates desktop integration** (application menu entry)
- **⚡ Sets up a command-line launcher**
- **📦 Manages multiple versions** (keeps up to 3 versions)
- **🆕 Always installs the most current version** available

## 🚀 Installation

1. **Make the script executable:**
```bash
chmod +x install_cursor_to_ubuntu.sh
```

2. **Run the installer:**
```bash
./install_cursor_to_ubuntu.sh
```

## 📁 What gets installed

- **📂 Application files**: `~/Applications/cursor/`
- **🖥️ Desktop launcher**: `~/.local/share/applications/cursor.desktop`
- **⚡ Command-line script**: `~/.local/bin/cursor`
- **🎨 Application icon**: `~/.local/share/icons/cursor.png`
- **📝 Log file**: `~/.local/share/cursor/cursor.log`

## 🎯 Usage

After installation, you can:
- **🖱️ Launch from application menu** (search for "Cursor")
- **⌨️ Run from command line**: `cursor`
- **ℹ️ Check version**: `cursor --version`

## 📋 Requirements

- **🐧 Ubuntu 22.04+** (or compatible Linux distribution)
- **🌐 curl** (for downloading and fetching latest version info)
- **📡 Internet connection**

## ⚙️ How it works

The script dynamically:
1. **📡 Fetches** the latest download information from [oslook/cursor-ai-downloads](https://github.com/oslook/cursor-ai-downloads) GitHub repository
2. **🔍 Extracts** the most current Linux x64 AppImage download URL
3. **📥 Downloads and installs** the latest version automatically
4. **🔄 Falls back** to a known working version if GitHub is unavailable

## 📝 Notes

- **🆕 Always installs the latest available version** (no longer hardcoded)
- **👤 Installation is user-local** (no sudo required)
- **🔄 Automatically handles** desktop database updates
- **🔇 Filters out** unnecessary AppImage runtime messages
- **🛡️ Includes error handling** and fallback mechanisms