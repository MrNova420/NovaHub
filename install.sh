#!/bin/bash
#
# ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗ ██╗  ██╗██╗   ██╗██████╗ 
# ████╗  ██║██╔═══██╗██║   ██║██╔══██╗██║  ██║██║   ██║██╔══██╗
# ██╔██╗ ██║██║   ██║██║   ██║███████║███████║██║   ██║██████╔╝
# ██║╚██╗██║██║   ██║╚██╗ ██╔╝██╔══██║██╔══██║╚██╗ ██╔╝██╔══██╗
# ██║ ╚████║╚██████╔╝ ╚████╔╝ ██║  ██║██║  ██║ ╚████╔╝ ██████╔╝
# ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═════╝ 
#
# NovaHub Installer with Local AI Support
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
INSTALL_OLLAMA=true

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
         with Built-in Local AI Support!
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

# Install Ollama for local AI
install_ollama() {
    if command -v ollama &> /dev/null; then
        log_success "Ollama is already installed ($(ollama --version 2>&1 | head -1))"
        return
    fi
    
    log_step "Installing Ollama (Local AI Runtime)..."
    log_info "This enables NovaHub to work without external API keys!"
    
    curl -fsSL https://ollama.com/install.sh | sh
    
    log_success "Ollama installed successfully"
}

# Setup Ollama models
setup_ollama_models() {
    if ! command -v ollama &> /dev/null; then
        log_warning "Ollama not found, skipping model setup"
        return
    fi
    
    log_step "Setting up local AI models..."
    log_info "This may take a few minutes on first run..."
    
    # Start Ollama service
    if ! pgrep -x "ollama" > /dev/null; then
        log_info "Starting Ollama service..."
        ollama serve > /dev/null 2>&1 &
        sleep 3
    fi
    
    # Pull default model
    log_step "Downloading Qwen2.5 Coder 7B (default model)..."
    log_info "Size: ~4.7GB - Great for coding tasks!"
    
    if ollama list | grep -q "qwen2.5-coder:7b"; then
        log_success "Model already downloaded"
    else
        ollama pull qwen2.5-coder:7b
        log_success "Model downloaded successfully"
    fi
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

# Create config directory and default config
setup_config() {
    log_step "Setting up configuration..."
    
    # Create config directory if it doesn't exist
    if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p "$CONFIG_DIR"
        log_info "Created config directory"
    fi
    
    # Copy/update config file if source exists and (target doesn't exist OR is outdated)
    if [ -f "$INSTALL_DIR/.novahub/novahub.jsonc" ]; then
        if [ ! -f "$CONFIG_DIR/novahub.jsonc" ]; then
            cp "$INSTALL_DIR/.novahub/novahub.jsonc" "$CONFIG_DIR/"
            log_success "Created default config with Ollama support"
        else
            log_info "Config file already exists at $CONFIG_DIR/novahub.jsonc"
        fi
    else
        log_warning "Default config not found in repo"
    fi
}

# Print success message
print_success() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                        ║${NC}"
    echo -e "${GREEN}║     ✓ NovaHub installed successfully!                 ║${NC}"
    echo -e "${GREEN}║       with Local AI Support!                          ║${NC}"
    echo -e "${GREEN}║                                                        ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}📦 What was installed:${NC}"
    echo -e "  ${GREEN}✓${NC} NovaHub CLI"
    echo -e "  ${GREEN}✓${NC} Bun Runtime"
    if command -v ollama &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} Ollama (Local AI)"
        if ollama list | grep -q "qwen2.5-coder:7b"; then
            echo -e "  ${GREEN}✓${NC} Qwen2.5 Coder 7B Model"
        fi
    fi
    echo ""
    echo -e "${CYAN}🚀 To get started:${NC}"
    echo ""
    echo -e "  ${YELLOW}1.${NC} Reload your shell:"
    echo -e "     ${PURPLE}source ~/.bashrc${NC}  (or ~/.zshrc)"
    echo ""
    echo -e "  ${YELLOW}2.${NC} Run NovaHub (works offline!):"
    echo -e "     ${PURPLE}novahub${NC}"
    echo ""
    echo -e "  ${YELLOW}3.${NC} The AI is ready to use:"
    echo -e "     ${GREEN}✓ No API keys needed!${NC}"
    echo -e "     ${GREEN}✓ Runs completely local!${NC}"
    echo -e "     ${GREEN}✓ Your code stays private!${NC}"
    echo ""
    echo -e "${CYAN}📚 Useful commands:${NC}"
    echo -e "  ${PURPLE}novahub${NC}              - Start TUI"
    echo -e "  ${PURPLE}novahub run \"query\"${NC}  - Quick query"
    echo -e "  ${PURPLE}novahub web${NC}          - Web interface"
    echo -e "  ${PURPLE}novahub --version${NC}    - Show version"
    echo ""
    echo -e "${CYAN}🤖 Manage AI models:${NC}"
    echo -e "  ${PURPLE}ollama list${NC}          - List installed models"
    echo -e "  ${PURPLE}ollama pull <model>${NC}  - Download more models"
    echo -e "  ${PURPLE}ollama run <model>${NC}   - Test a model"
    echo ""
    echo -e "${CYAN}Documentation:${NC} $INSTALL_DIR/DOCUMENTATION.md"
    echo -e "${CYAN}Config:${NC} $CONFIG_DIR/novahub.jsonc"
    echo ""
    echo -e "Created by ${PURPLE}MrNova420${NC} | ${PURPLE}WeNova Interactive${NC}"
    echo -e "Powered by ${CYAN}Ollama${NC} for local AI"
    echo ""
}

# Main installation flow
main() {
    print_banner
    
    log_info "Starting NovaHub installation with Local AI support..."
    echo ""
    
    check_requirements
    install_bun
    install_ollama
    setup_ollama_models
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
            return 1
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
    
    # Clone repo - skip rebuild if user says no
    if ! clone_repo; then
        log_info "Skipping rebuild, updating command and config only..."
        setup_command
        setup_path
        setup_config
        echo ""
        print_success
        return 0
    fi
    
    # Full installation
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
