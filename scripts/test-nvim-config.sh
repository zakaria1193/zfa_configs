#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running in CI
IN_CI="${CI:-false}"

# Set up temporary Neovim config directory
NVIM_TEST_DIR=$(mktemp -d)
log_info "Using temporary directory: $NVIM_TEST_DIR"

cleanup() {
    log_info "Cleaning up..."
    rm -rf "$NVIM_TEST_DIR"
}
trap cleanup EXIT

# Copy config to temporary directory
log_info "Copying Neovim config to temporary directory..."
mkdir -p "$NVIM_TEST_DIR/.config/nvim"
cp -r vimlua/zfa_nvim/* "$NVIM_TEST_DIR/.config/nvim/"

# Set XDG_CONFIG_HOME to use our temporary config
export XDG_CONFIG_HOME="$NVIM_TEST_DIR/.config"
export XDG_DATA_HOME="$NVIM_TEST_DIR/.local/share"
export XDG_STATE_HOME="$NVIM_TEST_DIR/.local/state"
export XDG_CACHE_HOME="$NVIM_TEST_DIR/.cache"

# Install lazy.nvim
log_info "Installing lazy.nvim..."
LAZY_PATH="$XDG_DATA_HOME/nvim/lazy/lazy.nvim"
mkdir -p "$(dirname "$LAZY_PATH")"
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$LAZY_PATH"

# Test lazy.nvim installation and plugin sync
log_info "Testing lazy.nvim plugin installation..."
nvim --headless "+Lazy! sync" "+qa" || {
    log_error "Failed to install plugins"
    exit 1
}

# Test loading each module
log_info "Testing module loading..."
MODULES=(
    options
    diagnostics
    keymaps
    plugins
    colorscheme
    cmp
    lsp
    telescope
    treesitter
    folding
    gitsigns
    nvim-tree
    lualine
    project
    indentline
    alpha
    autocommands
    gpt
    colorizer
    vim-gutentags
    hardtime
    neovide
)

for module in "${MODULES[@]}"; do
    log_info "Testing module: $module"
    nvim --headless "+lua require('user.$module')" "+qa" || {
        log_error "Failed to load module: $module"
        exit 1
    }
done

# Run health checks
log_info "Running health checks..."
nvim --headless "+checkhealth" "+qa" || {
    log_warn "Health checks reported some issues"
}

# Test basic operations
log_info "Testing basic operations..."

# Test file operations
echo "print('hello')" > "$NVIM_TEST_DIR/test.lua"
nvim --headless "$NVIM_TEST_DIR/test.lua" "+wq" || {
    log_error "Failed to open and save file"
    exit 1
}

# Test LSP functionality
log_info "Testing LSP functionality..."
nvim --headless "+LspInfo" "+qa" || {
    log_warn "LSP info check failed"
}

# Test Telescope
log_info "Testing Telescope..."
nvim --headless "+Telescope find_files" "+qa" || {
    log_warn "Telescope test failed"
}

# Test Tree-sitter
log_info "Testing Tree-sitter..."
nvim --headless "+TSInstallInfo" "+qa" || {
    log_warn "Tree-sitter info check failed"
}

log_info "All tests completed successfully! 🎉" 