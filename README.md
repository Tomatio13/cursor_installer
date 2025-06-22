<h1 align="center">🧙 Cursor Setup Wizard - TUI Edition</h1>

<p align="center">
    <img src="https://img.shields.io/badge/Ubuntu-22.04+-orange?style=for-the-badge&logo=ubuntu" alt="Ubuntu 22.04+"/>
    <img src="https://img.shields.io/badge/Bash-Script-green?style=for-the-badge&logo=gnu-bash" alt="Bash Script"/>
    <img src="https://img.shields.io/badge/TUI-Interactive-purple?style=for-the-badge" alt="TUI"/>
    <img src="https://img.shields.io/badge/AppImage-Installer-blue?style=for-the-badge" alt="AppImage"/>
</p>

<p align="center">
    <a href="README_JP.md"><img src="https://img.shields.io/badge/ドキュメント-日本語-white.svg" alt="JA doc"/></a>
    <a href="README.md"><img src="https://img.shields.io/badge/english-document-white.svg" alt="EN doc"></a>
</p>

<p align="center">
    <strong>🎯 Beautiful TUI (Terminal User Interface) for effortless Cursor AI installation</strong><br>
    Interactive installation wizard for Ubuntu-based systems
</p>

<div align="center">
    <img src="image/install_movie.gif" alt="Cursor Setup Wizard Demo" width="800"/>
    <br>
    <em>🎬 TUI Wizard Demo</em>
</div>

## ✨ New Features - TUI Interface

🎨 **Beautiful Interactive Interface**
- 📋 Intuitive menu system
- ⚡ Step-by-step progress display
- 🎯 Real-time progress indicators
- 🎪 Colorful messages and icons
- 🔄 Spinner animations for processing status

## 🚀 Quick Start

### One-liner Installation
```bash
bash <(curl -s https://raw.githubusercontent.com/your-repo/cursor_installer/main/quick_install.sh)
```

### Manual Download & Run
```bash
# Download the script
curl -O https://raw.githubusercontent.com/your-repo/cursor_installer/main/install_cursor_to_ubuntu.sh

# Make it executable
chmod +x install_cursor_to_ubuntu.sh

# Launch the TUI wizard
./install_cursor_to_ubuntu.sh
```

## 🎛️ Main Menu

The TUI wizard offers the following options:

| Option | Description |
|--------|-------------|
| 🚀 **Full Installation (Recommended)** | Auto-download latest version & complete setup |
| 🔧 **Reconfigure Existing Installation** | Rebuild configuration files and launchers |
| ⚙️ **Add CLI Command** | Add/update `cursor` command only |
| ℹ️ **Check Version Information** | Compare current vs latest versions |
| 🚪 **Exit** | Exit the wizard |

## 📊 Installation Process

The TUI wizard executes the following 8 steps:

```
Step 1: Create Directories 📁
Step 2: Version Check 🔍
Step 3: Download Cursor ⬇️
Step 4: Extract Application 📦
Step 5: Configure Launcher ⚡
Step 6: Install Icon 🎨
Step 7: Desktop Integration 🖥️
Step 8: System Update 🔄
```

Each step displays real-time progress with spinner animations.

## ✨ Key Features

### 🎯 Automation Features
- **🔄 Auto-fetch Latest Version** - Automatically detects latest AppImage from GitHub
- **📥 Smart Download** - Checks existing versions and downloads only when needed
- **🗂️ Version Management** - Automatically maintains up to 3 versions
- **🧹 Auto Cleanup** - Automatically removes old versions

### 🎨 User Experience
- **🎪 Colorful Display** - Color-coded success/error/info messages
- **⚡ Progress Display** - Real-time progress indicators for each process
- **🔄 Interactive Menus** - Beautiful TUI powered by gum library
- **📝 Detailed Logging** - Comprehensive logging of all operations

### 🛠️ Technical Features
- **🔧 Auto Dependency Resolution** - Automatically installs gum library
- **🛡️ Error Handling** - Comprehensive error handling and fallback mechanisms
- **⚙️ Configuration Management** - Saves installation info to config files
- **🔒 Security** - User-local installation (no sudo required)

## 📁 Installation Contents

### 📂 File Structure
```
~/Applications/cursor/           # Main application directory
├── images/                      # AppImage files storage
├── squashfs-root/              # Extracted application
└── ...

~/.local/bin/cursor             # Command-line launcher script
~/.local/share/applications/cursor.desktop  # Desktop launcher
~/.local/share/icons/cursor.png # Application icon
~/.local/share/cursor/cursor.log # Application log
~/.config/cursor-setup/config   # Installation configuration
```

## 🎯 Usage

After installation, you can launch Cursor using:

### 🖱️ GUI Launch
- Search for "Cursor" in the application menu
- Click the desktop launcher

### ⌨️ Command Line Launch
```bash
# Normal launch
cursor

# Check version
cursor --version

# Launch with specific file
cursor /path/to/your/project
```

## 📋 System Requirements

### 🐧 Supported OS
- **Ubuntu 22.04+**
- **Pop!_OS 22.04+**
- **Linux Mint 21+**
- **Other Ubuntu-based distributions**

### 🛠️ Required Tools
- **curl** - For downloading
- **bash 4.0+** - For script execution
- **Internet connection** - For downloads and gum installation

### 📦 Auto-installed Dependencies
- **gum** - TUI library (automatically installed)

## ⚙️ Advanced Usage

### 🔧 Configuration File
Installation information is saved to `~/.config/cursor-setup/config`:
```bash
# Cursor Setup Wizard Configuration
LAST_INSTALLED_VERSION=1.1.5
INSTALLATION_DATE=2024-01-15 14:30:22
DOWNLOAD_URL=https://downloads.cursor.com/production/.../Cursor-1.1.5-x86_64.AppImage
```

### 🗂️ Log Files
Application execution logs are recorded in `~/.local/share/cursor/cursor.log`.

### 🔄 Reinstallation
If an existing installation is detected, the wizard will automatically present appropriate options.

## 🔍 Troubleshooting

### ❓ Common Issues

**Q: "gum not found" error**
A: The script will automatically install gum. Sudo privileges are required.

**Q: Cursor won't start**
A: Try the "Reconfigure Existing Installation" option.

**Q: Old versions remain**
A: The script automatically cleans up old versions (keeps up to 3).

**Q: Desktop icon doesn't appear**
A: Desktop database updates may take time. Try logging out/in.

## 🤝 Contributing

Contributions to this project are welcome!

### 🛠️ Development Environment
```bash
# Clone the repository
git clone https://github.com/your-repo/cursor_installer.git
cd cursor_installer

# Test run the script
./install_cursor_to_ubuntu.sh
```

### 📝 Bug Reports & Feature Requests
Please feel free to report via the Issues tab.

## 📄 License

This project is released under the MIT License.

## 🙏 Acknowledgments

- [Cursor AI](https://cursor.sh/) - For providing the amazing AI editor
- [oslook/cursor-ai-downloads](https://github.com/oslook/cursor-ai-downloads) - For download link information
- [Charm](https://charm.sh/) - For the beautiful TUI library "gum"
- [jorcelinojunior/cursor-setup-wizard](https://github.com/jorcelinojunior/cursor-setup-wizard) - For TUI design inspiration

---

<p align="center">
    <strong>🧙 Build your comfortable AI development environment with Cursor Setup Wizard!</strong>
</p>