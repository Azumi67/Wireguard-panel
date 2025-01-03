#!/bin/bash

# Color Definitions
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NC="\033[0m"

# Update and install Git
echo -e "${BLUE}Updating & installing Git...${NC}"
sudo apt update && sudo apt install -y git

# Define target directory and repo URL
TARGET_DIR="/usr/local/bin/Wireguard-panel"
REPO_URL="https://github.com/Azumi67/Wireguard-panel.git"

# Remove existing setup directory if it exists
if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}Setup directory $TARGET_DIR already exists. Removing it for a fresh copy.${NC}"
    sudo rm -rf "$TARGET_DIR"
fi

# Clone the Wireguard-panel repository
echo -e "${BLUE}Cloning Wireguard-panel repo into $TARGET_DIR...${NC}"
sudo git clone "$REPO_URL" "$TARGET_DIR"

# Path to the setup.sh script
SETUP_SCRIPT="$TARGET_DIR/src/setup.sh"
if [ -f "$SETUP_SCRIPT" ]; then
    # Make setup.sh executable and run it
    echo -e "${GREEN}Making setup.sh executable...${NC}"
    sudo chmod +x "$SETUP_SCRIPT"

    echo -e "${GREEN}Running setup.sh...${NC}"
    cd "$TARGET_DIR/src" || exit 1
    sudo ./setup.sh
else
    # Handle case where setup.sh is not found
    echo -e "${RED}setup.sh not found in $TARGET_DIR/src, run the script again${NC}"
    exit 1
fi

echo -e "${GREEN}Setup complete.${NC}"

# Create the 'wire' command to run the script from anywhere
WIRE_SCRIPT="/usr/local/bin/wire"
if [ -d "/usr/local/bin/wire" ]; then
rm -r /usr/local/bin/wire
fi
    echo -e "${GREEN}Creating 'wire' to run from anywhere...${NC}"

    # Write the wire script
    echo -e "#!/bin/bash" | sudo tee "$WIRE_SCRIPT" > /dev/null
    echo -e "cd $TARGET_DIR/src && sudo ./setup.sh" | sudo tee -a "$WIRE_SCRIPT" > /dev/null

    # Make the 'wire' script executable
    sudo chmod +x "$WIRE_SCRIPT"

echo -e "${GREEN}You can now run the setup from anywhere by typing 'wire'.${NC}"
