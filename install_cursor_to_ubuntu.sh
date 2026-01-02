#!/bin/bash
set -euo pipefail

# =============================================================================
# Cursor Setup Wizard - TUI Version
# =============================================================================

# Color definitions
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly NC='\033[0m' # No Color

# Unicode symbols

readonly ARROW="→"
readonly SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

# Installation paths and variables
readonly CURSOR_DIR="$HOME/Applications/cursor"
readonly APPIMAGE_DIR="$CURSOR_DIR/images"
readonly EXTRACTED_DIR="$CURSOR_DIR/squashfs-root"
readonly BIN_PATH="$EXTRACTED_DIR/usr/share/cursor/cursor"
readonly EXTRACTED_ICON_DIR="$EXTRACTED_DIR/usr/share/icons/hicolor/32x32/apps"
readonly DESKTOP_DIR="$HOME/.local/share/applications"
readonly DESKTOP_FILE_PATH="$DESKTOP_DIR/cursor.desktop"
readonly SCRIPT_PATH="$HOME/.local/bin/cursor"
readonly ICON_PATH="$HOME/.local/share/icons/cursor.png"
readonly LOG_FILE_PATH="$HOME/.local/share/cursor/cursor.log"
readonly CONFIG_FILE="$HOME/.config/cursor-setup/config"

# Download configuration
readonly APPIMAGE_PREFIX="Cursor-"
readonly APPIMAGE_SUFFIX="-x86_64.AppImage"
readonly MAX_KEEP_INSTALLED_VERSIONS=3

# Version information
CURRENT_VERSION=""
LATEST_VERSION=""
DOWNLOAD_URL=""

# =============================================================================
# Utility Functions
# =============================================================================

# Check if gum is installed and install if necessary
check_gum() {
    if ! command -v gum &> /dev/null; then
        echo -e "${YELLOW}gum is not installed. Installing gum...${NC}"
        
        # Install gum
        if command -v apt &> /dev/null; then
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
            echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
            sudo apt update && sudo apt install -y gum
        else
            echo -e "${RED}✗ apt package manager not found. Please install gum manually.${NC}"
            exit 1
        fi
    fi
}

# Display header with ASCII art
show_header() {
    clear
    gum style \
        --foreground 212 \
        --border-foreground 212 \
        --border double \
        --align center \
        --width 60 \
        --margin "1 2" \
        --padding "2 4" \
        "🧙 Cursor Setup Wizard" \
        "" \
        "Automated installation and configuration" \
        "for Cursor on Ubuntu-based systems"
}



# =============================================================================
# Core Functions
# =============================================================================

# Get latest download URL from GitHub
get_latest_download_url() {
    gum spin --spinner dot --title "最新のダウンロードURLを取得中..." -- bash -c "
        readme_content=\$(curl -s 'https://raw.githubusercontent.com/oslook/cursor-ai-downloads/main/README.md')
        download_url=\$(
            echo \"\$readme_content\" \
            | grep -oE 'https://downloads\.cursor\.com/production/[^\"]*linux/x64/[^\"]*\.AppImage' \
            | awk -F/ '{
                file=\$NF;
                if (match(file, /Cursor-([0-9]+\.[0-9]+\.[0-9]+)-.*\.AppImage/, m)) {
                    print m[1] \"\t\" \$0;
                }
            }' \
            | sort -V \
            | tail -n 1 \
            | cut -f2- \
            | sed 's/^[0-9]*://'
        )

        if [ -z \"\$download_url\" ]; then
            echo 'https://downloads.cursor.com/production/ef5eeb47a684b4c217dfaf0463aa7ea952f8ab95/linux/x64/Cursor-1.1.5-x86_64.AppImage'
        else
            echo \"\$download_url\"
        fi
    "
}

# Create required directories
create_directories() {
    gum spin --spinner dot --title "Step 1: ディレクトリを作成中..." -- bash -c "
        mkdir -p '$APPIMAGE_DIR' '$DESKTOP_DIR' '$(dirname "$SCRIPT_PATH")' '$(dirname "$ICON_PATH")' '$(dirname "$LOG_FILE_PATH")' '$(dirname "$CONFIG_FILE")'
    " && echo "✓ ディレクトリの作成が完了しました"
}

# Check current and latest versions
check_versions() {
    echo "Step 2: バージョンチェック中..."
    
    # Get current version
    local current_appimage_path
    current_appimage_path=$(find "$APPIMAGE_DIR" -name "$APPIMAGE_PREFIX*$APPIMAGE_SUFFIX" -printf '%f\n' 2>/dev/null | sort -r | head -n 1)
    
    if [ -n "$current_appimage_path" ]; then
        CURRENT_VERSION=$(basename "$current_appimage_path" | sed -E "s/^$APPIMAGE_PREFIX//; s/-[a-f0-9]+$APPIMAGE_SUFFIX$//")
    else
        CURRENT_VERSION="未インストール"
    fi
    
    # Get latest version
    DOWNLOAD_URL=$(get_latest_download_url)
    local latest_appimage
    latest_appimage=$(basename "$DOWNLOAD_URL")
    LATEST_VERSION=$(echo "$latest_appimage" | sed -E "s/^$APPIMAGE_PREFIX//; s/-[a-f0-9]+$APPIMAGE_SUFFIX$//")
    
    echo "✓ 現在: ${CURRENT_VERSION} | 最新: ${LATEST_VERSION}"
    
    if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ] && [ "$CURRENT_VERSION" != "未インストール" ]; then
        # Check if already fully installed
        if [ -d "$EXTRACTED_DIR" ] && [ -x "$BIN_PATH" ] && [ -f "$DESKTOP_FILE_PATH" ]; then
            echo "ℹ Cursor $LATEST_VERSION は既に完全にインストールされています"
            return 1
        fi
    fi
    
    return 0
}

# Show version information only (for menu display)
show_version_info() {
    show_header
    
    # Get current version
    local current_appimage_path
    current_appimage_path=$(find "$APPIMAGE_DIR" -name "$APPIMAGE_PREFIX*$APPIMAGE_SUFFIX" -printf '%f\n' 2>/dev/null | sort -r | head -n 1)
    
    if [ -n "$current_appimage_path" ]; then
        CURRENT_VERSION=$(basename "$current_appimage_path" | sed -E "s/^$APPIMAGE_PREFIX//; s/-[a-f0-9]+$APPIMAGE_SUFFIX$//")
    else
        CURRENT_VERSION="未インストール"
    fi
    
    # Get latest version
    DOWNLOAD_URL=$(get_latest_download_url)
    local latest_appimage
    latest_appimage=$(basename "$DOWNLOAD_URL")
    LATEST_VERSION=$(echo "$latest_appimage" | sed -E "s/^$APPIMAGE_PREFIX//; s/-[a-f0-9]+$APPIMAGE_SUFFIX$//")
    
    # Display version information with status
    local status_message=""
    local status_color=33
    
    if [ "$CURRENT_VERSION" = "未インストール" ]; then
        status_message="Cursorはインストールされていません"
        status_color=196
    elif [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
        # Check if fully installed
        if [ -d "$EXTRACTED_DIR" ] && [ -x "$BIN_PATH" ] && [ -f "$DESKTOP_FILE_PATH" ]; then
            status_message="最新バージョンが完全にインストールされています ✓"
            status_color=46
        else
            status_message="最新バージョンがダウンロード済みですが、設定が不完全です"
            status_color=33
        fi
    else
        status_message="新しいバージョンが利用可能です"
        status_color=33
    fi
    
    gum style \
        --foreground 33 \
        --border-foreground 33 \
        --border normal \
        --align left \
        --width 60 \
        --margin "1 0" \
        --padding "1 2" \
        "📊 バージョン情報" \
        "" \
        "現在のバージョン: ${CURRENT_VERSION}" \
        "最新バージョン: ${LATEST_VERSION}" \
        ""
    
    gum style \
        --foreground $status_color \
        --border-foreground $status_color \
        --border normal \
        --align center \
        --width 60 \
        --margin "1 0" \
        --padding "1 2" \
        "$status_message"
}

# Download latest version
download_cursor() {
    if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ] && [ "$CURRENT_VERSION" != "未インストール" ]; then
        echo "ℹ 最新バージョンは既にダウンロード済みです"
        return 0
    fi
    
    local latest_appimage
    latest_appimage=$(basename "$DOWNLOAD_URL")
    
    # Download with progress
    gum spin --spinner dot --title "Step 3: Cursor ${LATEST_VERSION} をダウンロード中..." -- bash -c "
        cd '$CURSOR_DIR'
        curl -L '$DOWNLOAD_URL' --output '$APPIMAGE_DIR/$latest_appimage' --silent
        chmod +x '$APPIMAGE_DIR/$latest_appimage'
    " && echo "✓ ダウンロードが完了しました"
    
    # Clean up old versions
    gum spin --spinner dot --title "古いバージョンをクリーンアップ中..." -- bash -c "
        find '$APPIMAGE_DIR' -name '$APPIMAGE_PREFIX*$APPIMAGE_SUFFIX' | sort -r | tail -n +$((MAX_KEEP_INSTALLED_VERSIONS + 1)) | xargs rm -f
    " && echo "✓ クリーンアップが完了しました"
}

# Extract application
extract_application() {
    local latest_appimage
    latest_appimage=$(basename "$DOWNLOAD_URL")
    
    gum spin --spinner dot --title "Step 4: AppImageを展開中..." -- bash -c "
        cd '$CURSOR_DIR'
        rm -rf '$EXTRACTED_DIR'
        '$APPIMAGE_DIR/$latest_appimage' --appimage-extract > /dev/null 2>&1
        chmod +x '$BIN_PATH'
    " && echo "✓ アプリケーションの展開が完了しました"
}

# Configure launcher script
configure_launcher() {
    gum spin --spinner dot --title "Step 5: ランチャースクリプトを作成中..." -- bash -c "
        cat > '$SCRIPT_PATH' << 'EOF'
#!/bin/bash

# Show version number when --version or -v flag is used
if [ \"\$1\" = \"--version\" ] || [ \"\$1\" = \"-v\" ]; then
  echo \"Cursor version: $LATEST_VERSION\"
  exit 0
fi  

\"$BIN_PATH\" --no-sandbox \"\$@\" \\
| grep -v '@todesktop/runtime: skipping autoUpdater initialization because application is not in AppImage.' \\
> \"$LOG_FILE_PATH\" 2>&1
EOF
        chmod +x '$SCRIPT_PATH'
    " && echo "✓ ランチャーの設定が完了しました"
}

# Install application icon
install_icon() {
    gum spin --spinner dot --title "Step 6: アイコンをコピー中..." -- bash -c "
        cp '$EXTRACTED_ICON_DIR/cursor.png' '$ICON_PATH'
    " && echo "✓ アイコンのインストールが完了しました"
}

# Create desktop integration
create_desktop_integration() {
    gum spin --spinner dot --title "Step 7: デスクトップファイルを作成中..." -- bash -c "
        cat > '$DESKTOP_FILE_PATH' << EOF
[Desktop Entry]
Name=Cursor
Exec=$SCRIPT_PATH
Terminal=false
Type=Application
Icon=$ICON_PATH
StartupWMClass=Cursor
Comment=AI-powered code editor
MimeType=x-scheme-handler/cursor;
Categories=Utility;Development
EOF
        chmod +x '$DESKTOP_FILE_PATH'
    " && echo "✓ デスクトップ統合が完了しました"
}

# Update desktop database
update_desktop_database() {
    gum spin --spinner dot --title "Step 8: デスクトップデータベースを更新中..." -- bash -c "
        update-desktop-database '$DESKTOP_DIR'
    " && echo "✓ システム更新が完了しました"
}

# Save configuration
save_configuration() {
    gum spin --spinner dot --title "設定を保存中..." -- bash -c "
        cat > '$CONFIG_FILE' << EOF
# Cursor Setup Wizard Configuration
LAST_INSTALLED_VERSION=$LATEST_VERSION
INSTALLATION_DATE=$(date '+%Y-%m-%d %H:%M:%S')
DOWNLOAD_URL=$DOWNLOAD_URL
EOF
    " && echo "✓ 設定を保存しました"
}

# =============================================================================
# Main Installation Process
# =============================================================================

# Full installation process
run_full_installation() {
    show_header
    
    if ! check_versions; then
        gum confirm "既にインストール済みです。続行しますか？" || return 0
    fi
    
    create_directories
    download_cursor
    extract_application
    configure_launcher
    install_icon
    create_desktop_integration
    update_desktop_database
    save_configuration
    
    # Final success message
    echo ""
    gum style \
        --foreground 46 \
        --border-foreground 46 \
        --border double \
        --align center \
        --width 60 \
        --margin "2 0" \
        --padding "2 4" \
        "🎉 インストール完了！" \
        "" \
        "Cursor ${LATEST_VERSION} が正常にインストールされました" \
        "" \
        "ターミナルから 'cursor' コマンドで起動できます" \
        "デスクトップからも起動可能です"
}

# Reconfigure existing installation
reconfigure_installation() {
    show_header
    echo "既存のインストールを再設定しています..."
    
    configure_launcher
    install_icon
    create_desktop_integration
    update_desktop_database
    
    echo "🎉 再設定が完了しました"
}

# Add CLI command only
add_cli_command() {
    show_header
    echo "CLIコマンドを追加しています..."
    
    if [ ! -x "$BIN_PATH" ]; then
        echo "❌ Cursorがインストールされていません。まず完全インストールを実行してください。"
        return 1
    fi
    
    configure_launcher
    echo "🎉 CLIコマンドの追加が完了しました"
}

# =============================================================================
# Main Menu
# =============================================================================

show_main_menu() {
    show_header
    
    local choice
    choice=$(gum choose \
        --header "実行する操作を選択してください:" \
        --height 10 \
        "🚀 完全インストール (推奨)" \
        "🔧 既存インストールの再設定" \
        "⚙️  CLIコマンドの追加" \
        "ℹ️  バージョン情報の確認" \
        "🚪 終了")
    
    case $choice in
        "🚀 完全インストール (推奨)")
            run_full_installation
            ;;
        "🔧 既存インストールの再設定")
            reconfigure_installation
            ;;
        "⚙️  CLIコマンドの追加")
            add_cli_command
            ;;
        "ℹ️  バージョン情報の確認")
            show_version_info
            ;;
        "🚪 終了")
            gum style \
                --foreground 33 \
                --align center \
                --margin "1 0" \
                "👋 Cursor Setup Wizard を終了します"
            exit 0
            ;;
    esac
    
    # Ask if user wants to continue
    echo
    if gum confirm "メインメニューに戻りますか？"; then
        show_main_menu
    else
        gum style \
            --foreground 33 \
            --align center \
            --margin "1 0" \
            "👋 Cursor Setup Wizard を終了します"
    fi
}

# =============================================================================
# Main Execution
# =============================================================================

main() {
    # Check if gum is installed
    check_gum
    
    # Show main menu
    show_main_menu
}

# Run main function
main "$@"
