#!/bin/bash

# AI Coding Starter Kit Installer
# Installs rules and skills for Cursor, Codex CLI, and/or Claude Code

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Flags
INSTALL_CURSOR=false
INSTALL_CODEX=false
INSTALL_CLAUDE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --cursor|-c)
            INSTALL_CURSOR=true
            shift
            ;;
        --codex|-x)
            INSTALL_CODEX=true
            shift
            ;;
        --claude|-l)
            INSTALL_CLAUDE=true
            shift
            ;;
        --all|-a)
            INSTALL_CURSOR=true
            INSTALL_CODEX=true
            INSTALL_CLAUDE=true
            shift
            ;;
        --help|-h)
            echo "Usage: ./install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -c, --cursor    Install Cursor rules and skills"
            echo "  -x, --codex     Install Codex/Copilot configuration"
            echo "  -l, --claude    Install Claude Code configuration"
            echo "  -a, --all       Install for all tools"
            echo "  -h, --help      Show this help message"
            echo ""
            echo "If no options provided, interactive menu is shown."
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# If no flags, show interactive menu
if ! $INSTALL_CURSOR && ! $INSTALL_CODEX && ! $INSTALL_CLAUDE; then
    echo -e "\n${CYAN}=== AI Coding Starter Kit Installer ===${NC}"
    echo ""
    echo "Select tools to install for:"
    echo "  1. Cursor only"
    echo "  2. Codex/Copilot only"
    echo "  3. Claude Code only"
    echo "  4. All tools"
    echo "  5. Cancel"
    echo ""
    read -p "Enter choice (1-5): " choice
    
    case $choice in
        1) INSTALL_CURSOR=true ;;
        2) INSTALL_CODEX=true ;;
        3) INSTALL_CLAUDE=true ;;
        4) INSTALL_CURSOR=true; INSTALL_CODEX=true; INSTALL_CLAUDE=true ;;
        5) echo "Installation cancelled."; exit 0 ;;
        *) echo "Invalid choice. Exiting."; exit 1 ;;
    esac
fi

INSTALLED=()

# Install Cursor
if $INSTALL_CURSOR; then
    echo -e "\n${YELLOW}Installing Cursor configuration...${NC}"
    
    CURSOR_RULES_DIR="$HOME/.cursor/rules"
    CURSOR_SKILLS_DIR="$HOME/.cursor/skills-cursor"
    
    # Create directories
    mkdir -p "$CURSOR_RULES_DIR"
    mkdir -p "$CURSOR_SKILLS_DIR"
    
    # Copy rules
    cp -f "$SCRIPT_DIR/cursor/rules/"* "$CURSOR_RULES_DIR/"
    echo -e "  ${GREEN}Rules copied to $CURSOR_RULES_DIR${NC}"
    
    # Copy skills (with subdirectories)
    cp -rf "$SCRIPT_DIR/cursor/skills/"* "$CURSOR_SKILLS_DIR/"
    echo -e "  ${GREEN}Skills copied to $CURSOR_SKILLS_DIR${NC}"
    
    INSTALLED+=("Cursor")
fi

# Install Codex
if $INSTALL_CODEX; then
    echo -e "\n${YELLOW}Installing Codex/Copilot configuration...${NC}"
    
    CODEX_DIR="$HOME/.codex"
    
    # Create directories
    mkdir -p "$CODEX_DIR/rules"
    mkdir -p "$CODEX_DIR/skills"
    
    # Copy AGENTS.md
    cp -f "$SCRIPT_DIR/codex/AGENTS.md" "$CODEX_DIR/"
    echo -e "  ${GREEN}AGENTS.md copied to $CODEX_DIR${NC}"
    
    # Copy rules and skills
    cp -f "$SCRIPT_DIR/codex/rules/"* "$CODEX_DIR/rules/"
    cp -f "$SCRIPT_DIR/codex/skills/"* "$CODEX_DIR/skills/"
    echo -e "  ${GREEN}Rules and skills copied to $CODEX_DIR${NC}"
    
    INSTALLED+=("Codex")
fi

# Install Claude
if $INSTALL_CLAUDE; then
    echo -e "\n${YELLOW}Installing Claude Code configuration...${NC}"
    
    CLAUDE_DIR="$HOME/.claude"
    
    # Create directories
    mkdir -p "$CLAUDE_DIR/rules"
    mkdir -p "$CLAUDE_DIR/skills"
    
    # Copy CLAUDE.md
    cp -f "$SCRIPT_DIR/claude/CLAUDE.md" "$CLAUDE_DIR/"
    echo -e "  ${GREEN}CLAUDE.md copied to $CLAUDE_DIR${NC}"
    
    # Copy rules and skills
    cp -f "$SCRIPT_DIR/claude/rules/"* "$CLAUDE_DIR/rules/"
    cp -f "$SCRIPT_DIR/claude/skills/"* "$CLAUDE_DIR/skills/"
    echo -e "  ${GREEN}Rules and skills copied to $CLAUDE_DIR${NC}"
    
    INSTALLED+=("Claude")
fi

echo -e "\n${CYAN}=== Installation Complete ===${NC}"
echo -e "${GREEN}Installed for: ${INSTALLED[*]}${NC}"
echo ""
echo "Please restart your IDE(s) for changes to take effect."
echo "To uninstall, run: ./uninstall.sh"
echo ""
