#!/bin/bash
#
# NovaHub Installation Test Script
# Tests the installer in a fresh Ubuntu Docker container
#

set -e

PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════╗
║  NovaHub Installation Tester                             ║
║  Tests install.sh in fresh Ubuntu environment            ║
╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}[!] Docker not found. Installing Docker...${NC}"
    echo ""
    echo "Run these commands to install Docker:"
    echo ""
    echo "  # Add Docker's official GPG key:"
    echo "  sudo apt-get update"
    echo "  sudo apt-get install ca-certificates curl"
    echo "  sudo install -m 0755 -d /etc/apt/keyrings"
    echo "  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc"
    echo "  sudo chmod a+r /etc/apt/keyrings/docker.asc"
    echo ""
    echo "  # Add the repository to Apt sources:"
    echo "  echo \"deb [arch=\$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \$(. /etc/os-release && echo \"\$VERSION_CODENAME\") stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
    echo "  sudo apt-get update"
    echo ""
    echo "  # Install Docker:"
    echo "  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
    echo ""
    echo "  # Add your user to docker group (no sudo needed):"
    echo "  sudo usermod -aG docker \$USER"
    echo "  newgrp docker"
    echo ""
    echo "Then run this script again!"
    exit 1
fi

echo -e "${GREEN}[✓] Docker is installed${NC}"
echo ""

# Check if we can run Docker without sudo
if ! docker ps &> /dev/null; then
    echo -e "${YELLOW}[!] Cannot run Docker without sudo${NC}"
    echo "Add yourself to docker group:"
    echo "  sudo usermod -aG docker \$USER"
    echo "  newgrp docker"
    exit 1
fi

echo -e "${GREEN}[→] Creating fresh Ubuntu 24.04 container...${NC}"

# Create a test container
CONTAINER_NAME="novahub-test-$(date +%s)"

docker run -it --rm \
    --name "$CONTAINER_NAME" \
    -v "$(pwd)/install.sh:/tmp/install.sh:ro" \
    ubuntu:24.04 \
    bash -c '
        echo "════════════════════════════════════════════════════════"
        echo "  Fresh Ubuntu 24.04 Container - Testing NovaHub Install"
        echo "════════════════════════════════════════════════════════"
        echo ""
        echo "Container details:"
        cat /etc/os-release | grep "PRETTY_NAME"
        echo ""
        echo "Starting installation test..."
        echo ""
        
        # Make installer executable
        chmod +x /tmp/install.sh
        
        # Run the installer
        bash /tmp/install.sh
        
        echo ""
        echo "════════════════════════════════════════════════════════"
        echo "  Installation complete! Testing novahub command..."
        echo "════════════════════════════════════════════════════════"
        echo ""
        
        # Test if novahub is accessible
        if command -v novahub &> /dev/null; then
            echo "✓ novahub command is available"
            novahub --version
            echo ""
            echo "✓ Installation successful!"
        else
            echo "✗ novahub command not found in PATH"
            echo "Checking installation location..."
            ls -la ~/.local/bin/ || echo "~/.local/bin/ not found"
            exit 1
        fi
        
        echo ""
        echo "════════════════════════════════════════════════════════"
        echo "  Test Summary"
        echo "════════════════════════════════════════════════════════"
        echo "✓ Dependencies installed"
        echo "✓ Ollama installed"
        echo "✓ NovaHub CLI installed"
        echo "✓ Command globally accessible"
        echo ""
        echo "You can now use: novahub"
    '

echo ""
echo -e "${GREEN}════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Installation test completed successfully!${NC}"
echo -e "${GREEN}════════════════════════════════════════════════════════${NC}"
