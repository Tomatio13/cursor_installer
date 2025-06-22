#!/bin/bash
# Cursor Setup Wizard - Quick Install Script
# Usage: bash <(curl -s https://raw.githubusercontent.com/your-repo/cursor_installer/main/quick_install.sh)

set -euo pipefail

# Color definitions
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

echo -e "${GREEN}🧙 Cursor Setup Wizard - Quick Install${NC}"
echo -e "${YELLOW}Downloading and running the TUI installer...${NC}"

# Download and run the main installer
if curl -fsSL https://raw.githubusercontent.com/your-repo/cursor_installer/main/install_cursor_to_ubuntu.sh | bash; then
    echo -e "${GREEN}✓ Installation completed successfully!${NC}"
else
    echo -e "${RED}✗ Installation failed. Please check the error messages above.${NC}"
    exit 1
fi 