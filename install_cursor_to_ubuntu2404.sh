#!/bin/bash
set -euo pipefail

# Step 1: Declare installation paths and variables
CURSOR_DIR="$HOME/Applications/cursor"
APPIMAGE_DIR="$CURSOR_DIR/images"
EXTRACTED_DIR="$CURSOR_DIR/squashfs-root"
BIN_PATH="$EXTRACTED_DIR/usr/share/cursor/cursor"

EXTRACTED_ICON_DIR="$EXTRACTED_DIR/usr/share/icons/hicolor/32x32/apps"

DESKTOP_DIR="$HOME/.local/share/applications"
DESKTOP_FILE_PATH="$DESKTOP_DIR/cursor.desktop"
SCRIPT_PATH="$HOME/.local/bin/cursor"
ICON_PATH="$HOME/.local/share/icons/cursor.png"
LOG_FILE_PATH="$HOME/.local/share/cursor/cursor.log"

# DOWNLOAD LINKS
# https://github.com/oslook/cursor-ai-downloads?tab=readme-ov-file#all-version-download-links

#DOWNLOAD_URL="https://downloads.cursor.com/production/client/linux/x64/appimage/Cursor-0.47.8-82ef0f61c01d079d1b7e5ab04d88499d5af500e3.deb.glibc2.25-x86_64.AppImage"
DOWNLOAD_URL="https://downloads.cursor.com/production/client/linux/x64/appimage/Cursor-1.1.5-x86_64.AppImage"
APPIMAGE_PREFIX="Cursor-"
APPIMAGE_SUFFIX="-x86_64.AppImage"
MAX_KEEP_INSTALLED_VERSIONS=3

# Step 2: Create required directories
mkdir -p "$APPIMAGE_DIR" \
  "$DESKTOP_DIR" \
  "$(dirname "$SCRIPT_PATH")" \
  "$(dirname "$ICON_PATH")" \
  "$(dirname "$LOG_FILE_PATH")"

cd "$CURSOR_DIR"

# Step 3: Download latest version if not already installed

# 3.1: Check current installation
CURRENT_APPIMAGE_PATH=$(find "$APPIMAGE_DIR" -name "$APPIMAGE_PREFIX*$APPIMAGE_SUFFIX" -printf '%f\n' \
  | sort -r \
  | head -n 1)
CURRENT_VERSION=$(basename "$CURRENT_APPIMAGE_PATH" | sed -E "s/^$APPIMAGE_PREFIX//; s/-[a-f0-9]+$APPIMAGE_SUFFIX$//")

# 3.2: 直接URLからファイル名を抽出
LATEST_APPIMAGE=$(basename "$DOWNLOAD_URL")
LATEST_VERSION=$(echo "$LATEST_APPIMAGE" | sed -E "s/^$APPIMAGE_PREFIX//; s/-[a-f0-9]+$APPIMAGE_SUFFIX$//")

echo "Current: $CURRENT_VERSION"
echo "Latest : $LATEST_VERSION"

# 3.3: Download new version if not installed
#if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
#  echo "Downloading $LATEST_APPIMAGE..."
#  trap "rm -f ""$APPIMAGE_DIR"/"$LATEST_APPIMAGE""; echo -e '\nDownload cancelled. Cleaning up...'; exit 1" SIGINT
#  curl -L "$DOWNLOAD_URL" --output "$APPIMAGE_DIR/$LATEST_APPIMAGE"
#  chmod +x "$APPIMAGE_DIR/$LATEST_APPIMAGE"
#
#  # Remove old AppImages, keeping only a constant number of versions
#  find "$APPIMAGE_DIR" -name "$APPIMAGE_PREFIX*$APPIMAGE_SUFFIX" \
#    | sort -r \
#    | tail -n +$((MAX_KEEP_INSTALLED_VERSIONS + 1)) \
#    | xargs rm -f
#else
#  echo "Already downloaded the latest version ($LATEST_VERSION)"
  
#  # インストール済みかどうかを確認
#  if [ -d "$EXTRACTED_DIR" ] && [ -x "$BIN_PATH" ] && [ -f "$DESKTOP_FILE_PATH" ]; then
#    echo "Cursor $LATEST_VERSION は既にインストールされています。終了します。"
#    exit 0
#  fi
#fi

# Step 4: Extract application binary
rm -rf "$EXTRACTED_DIR"
"$APPIMAGE_DIR/$LATEST_APPIMAGE" --appimage-extract
chmod +x "$BIN_PATH"

# Step 5: Configure application launcher
cat <<EOF > "$SCRIPT_PATH"
#!/bin/bash

# Show version number when --version or -v flag is used
if [ "\$1" = "--version" ] || [ "\$1" = "-v" ]; then
  echo "Cursor version: $LATEST_VERSION"
  exit 0
fi  

"$BIN_PATH" --no-sandbox "\$@" \
| grep -v '@todesktop/runtime: skipping autoUpdater initialization because application is not in AppImage.' \
> "$LOG_FILE_PATH" 2>&1
EOF
chmod +x "$SCRIPT_PATH"

# Step 6: Install application icon
#cp "$EXTRACTED_DIR/cursor.png" "$ICON_PATH"
cp "$EXTRACTED_ICON_DIR/cursor.png" "$ICON_PATH"

# Step 7: Create desktop integration
if [ ! -f "$DESKTOP_FILE_PATH" ] \
 || [ "$(grep -oP '(?<=^Exec=).*' "$DESKTOP_FILE_PATH")" != "$SCRIPT_PATH" ] \
 || [ "$(grep -oP '(?<=^Icon=).*' "$DESKTOP_FILE_PATH")" != "$ICON_PATH" ]; then
  cat <<EOF > "$DESKTOP_FILE_PATH"
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
  chmod +x "$DESKTOP_FILE_PATH"
  echo "Desktop shortcut created successfully"
fi

# Step 8: Update system's desktop database
update-desktop-database "$DESKTOP_DIR"
