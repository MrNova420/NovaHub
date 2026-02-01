#!/bin/bash
#
# ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗ ██╗  ██╗██╗   ██╗██████╗ 
# ████╗  ██║██╔═══██╗██║   ██║██╔══██╗██║  ██║██║   ██║██╔══██╗
# ██╔██╗ ██║██║   ██║██║   ██║███████║███████║██║   ██║██████╔╝
# ██║╚██╗██║██║   ██║╚██╗ ██╔╝██╔══██║██╔══██║╚██╗ ██╔╝██╔══██╗
# ██║ ╚████║╚██████╔╝ ╚████╔╝ ██║  ██║██║  ██║ ╚████╔╝ ██████╔╝
# ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═════╝ 
#
# NovaHub Installer
# Your Central Development Hub
#
# Created by: MrNova420 | WeNova Interactive
# Based on OpenCode (MIT License)
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/MrNova420/NovaHub.git"
INSTALL_DIR="$HOME/NovaHub"
BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.novahub"

# Banner
print_banner() {
    echo -e "${PURPLE}"
    cat << "EOF"
 ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗ ██╗  ██╗██╗   ██╗██████╗ 
 ████╗  ██║██╔═══██╗██║   ██║██╔══██╗██║  ██║██║   ██║██╔══██╗
 ██╔██╗ ██║██║   ██║██║   ██║███████║███████║██║   ██║██████╔╝
 ██║╚██╗██║██║   ██║╚██╗ ██╔╝██╔══██║██╔══██║╚██╗ ██╔╝██╔══██╗
 ██║ ╚████║╚██████╔╝ ╚████╔╝ ██║  ██║██║  ██║ ╚████╔╝ ██████╔╝
 ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═════╝ 
                                                                 
             Your Central Development Hub
         by MrNova420 | WeNova Interactive
EOF
    echo -e "${NC}"
}

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

log_error() {
    echo -e "${RED}[✗]${NC} $1"
}

log_step() {
    echo -e "${CYAN}[→]${NC} $1"
}

# Check system requirements
check_requirements() {
    log_step "Checking system requirements..."
    
    # Check OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        log_success "OS: Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        log_success "OS: macOS"
    else
        log_error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
    
    # Check git
    if ! command -v git &> /dev/null; then
        log_error "git is not installed. Please install git first."
        exit 1
    fi
    log_success "git is installed"
    
    # Check curl
    if ! command -v curl &> /dev/null; then
        log_error "curl is not installed. Please install curl first."
        exit 1
    fi
    log_success "curl is installed"
}

# Install Bun
install_bun() {
    if command -v bun &> /dev/null; then
        log_success "Bun is already installed ($(bun --version))"
        return
    fi
    
    log_step "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
    
    # Add to PATH for this session
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    
    log_success "Bun installed successfully"
}

# Clone repository
clone_repo() {
    if [ -d "$INSTALL_DIR" ]; then
        log_warning "NovaHub directory already exists at $INSTALL_DIR"
        read -p "Do you want to remove it and reinstall? (y/N) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log_step "Removing existing installation..."
            rm -rf "$INSTALL_DIR"
        else
            log_info "Using existing installation"
            return
        fi
    fi
    
    log_step "Cloning NovaHub repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    log_success "Repository cloned"
}

# Install dependencies
install_dependencies() {
    log_step "Installing dependencies..."
    cd "$INSTALL_DIR"
    
    # Ensure bun is in PATH
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    
    bun install
    log_success "Dependencies installed"
}

# Build NovaHub
build_novahub() {
    log_step "Building NovaHub (this may take a few minutes)..."
    cd "$INSTALL_DIR/packages/novahub"
    
    # Ensure bun is in PATH
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    
    bun run script/build.ts
    log_success "Build complete"
}

# Setup global command
setup_command() {
    log_step "Setting up global command..."
    
    # Create bin directory if it doesn't exist
    mkdir -p "$BIN_DIR"
    
    # Detect platform
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        PLATFORM="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        PLATFORM="darwin"
    fi
    
    # Detect architecture
    ARCH=$(uname -m)
    if [[ "$ARCH" == "x86_64" ]]; then
        ARCH="x64"
    elif [[ "$ARCH" == "aarch64" ]] || [[ "$ARCH" == "arm64" ]]; then
        ARCH="arm64"
    fi
    
    BINARY_PATH="$INSTALL_DIR/packages/novahub/dist/novahub-$PLATFORM-$ARCH/bin/novahub"
    
    # Create wrapper script
    cat > "$BIN_DIR/novahub" << EOF
#!/bin/bash
# NovaHub launcher
export PATH="\$HOME/.bun/bin:\$PATH"
exec "$BINARY_PATH" "\$@"
EOF
    
    chmod +x "$BIN_DIR/novahub"
    log_success "Global command created at $BIN_DIR/novahub"
}

# Setup PATH
setup_path() {
    log_step "Setting up PATH..."
    
    # Detect shell
    SHELL_RC=""
    if [ -n "$BASH_VERSION" ]; then
        SHELL_RC="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
        SHELL_RC="$HOME/.zshrc"
    else
        SHELL_RC="$HOME/.profile"
    fi
    
    # Add to PATH if not already there
    if ! grep -q "$BIN_DIR" "$SHELL_RC" 2>/dev/null; then
        echo "" >> "$SHELL_RC"
        echo "# NovaHub" >> "$SHELL_RC"
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_RC"
        echo "export PATH=\"\$HOME/.bun/bin:\$PATH\"" >> "$SHELL_RC"
        log_success "Added to $SHELL_RC"
    else
        log_info "PATH already configured in $SHELL_RC"
    fi
}

# Create config directory
setup_config() {
    if [ ! -d "$CONFIG_DIR" ]; then
        log_step "Creating config directory..."
        mkdir -p "$CONFIG_DIR"
        log_success "Config directory created at $CONFIG_DIR"
    fi
}

# Print success message
print_success() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                        ║${NC}"
    echo -e "${GREEN}║     ✓ NovaHub installed successfully!                 ║${NC}"
    echo -e "${GREEN}║                                                        ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}To get started:${NC}"
    echo ""
    echo -e "  ${YELLOW}1.${NC} Reload your shell:"
    echo -e "     ${PURPLE}source ~/.bashrc${NC}  (or ~/.zshrc)"
    echo ""
    echo -e "  ${YELLOW}2.${NC} Run NovaHub:"
    echo -e "     ${PURPLE}novahub${NC}"
    echo ""
    echo -e "  ${YELLOW}3.${NC} Get help:"
    echo -e "     ${PURPLE}novahub --help${NC}"
    echo ""
    echo -e "${CYAN}Useful commands:${NC}"
    echo -e "  ${PURPLE}novahub${NC}              - Start TUI"
    echo -e "  ${PURPLE}novahub web${NC}          - Start web interface"
    echo -e "  ${PURPLE}novahub --version${NC}    - Show version"
    echo -e "  ${PURPLE}novahub auth${NC}         - Manage credentials"
    echo ""
    echo -e "${CYAN}Documentation:${NC} $INSTALL_DIR/README.md"
    echo -e "${CYAN}Config:${NC} $CONFIG_DIR"
    echo ""
    echo -e "Created by ${PURPLE}MrNova420${NC} | ${PURPLE}WeNova Interactive${NC}"
    echo ""
}

# Main installation flow
main() {
    print_banner
    
    log_info "Starting NovaHub installation..."
    echo ""
    
    check_requirements
    install_bun
    clone_repo
    install_dependencies
    build_novahub
    setup_command
    setup_path
    setup_config
    
    echo ""
    print_success
}

# Run installer
main "$@"
