#!/bin/bash

# AI Coding Starter Kit Uninstaller
# Removes configurations for Cursor, Codex CLI, and/or Claude Code

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Flags
REMOVE_CURSOR=false
REMOVE_CODEX=false
REMOVE_CLAUDE=false
CREATE_BACKUP=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --cursor|-c)
            REMOVE_CURSOR=true
            shift
            ;;
        --codex|-x)
            REMOVE_CODEX=true
            shift
            ;;
        --claude|-l)
            REMOVE_CLAUDE=true
            shift
            ;;
        --all|-a)
            REMOVE_CURSOR=true
            REMOVE_CODEX=true
            REMOVE_CLAUDE=true
            shift
            ;;
        --backup|-b)
            CREATE_BACKUP=true
            shift
            ;;
        --help|-h)
            echo "Usage: ./uninstall.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -c, --cursor    Remove Cursor configuration"
            echo "  -x, --codex     Remove Codex/Copilot configuration"
            echo "  -l, --claude    Remove Claude Code configuration"
            echo "  -a, --all       Remove all configurations"
            echo "  -b, --backup    Create backup before removing"
            echo "  -h, --help      Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# If no flags, show interactive menu
if ! $REMOVE_CURSOR && ! $REMOVE_CODEX && ! $REMOVE_CLAUDE; then
    echo -e "\n${CYAN}=== AI Coding Starter Kit Uninstaller ===${NC}"
    echo ""
    echo "Select tools to uninstall:"
    echo "  1. Cursor only"
    echo "  2. Codex/Copilot only"
    echo "  3. Claude Code only"
    echo "  4. All tools"
    echo "  5. Cancel"
    echo ""
    read -p "Enter choice (1-5): " choice
    
    case $choice in
        1) REMOVE_CURSOR=true ;;
        2) REMOVE_CODEX=true ;;
        3) REMOVE_CLAUDE=true ;;
        4) REMOVE_CURSOR=true; REMOVE_CODEX=true; REMOVE_CLAUDE=true ;;
        5) echo "Uninstall cancelled."; exit 0 ;;
        *) echo "Invalid choice. Exiting."; exit 1 ;;
    esac
    
    read -p "Create backup before removing? (y/n): " backup_choice
    if [[ $backup_choice == "y" || $backup_choice == "Y" ]]; then
        CREATE_BACKUP=true
    fi
fi

REMOVED=()
BACKUP_DIR="$HOME/.ai-starter-kit-backup-$(date +%Y%m%d-%H%M%S)"

if $CREATE_BACKUP; then
    mkdir -p "$BACKUP_DIR"
    echo -e "\n${YELLOW}Backup directory: $BACKUP_DIR${NC}"
fi

# Uninstall Cursor
if $REMOVE_CURSOR; then
    echo -e "\n${YELLOW}Removing Cursor configuration...${NC}"
    
    CURSOR_RULES_DIR="$HOME/.cursor/rules"
    CURSOR_SKILLS_DIR="$HOME/.cursor/skills-cursor"
    
    if $CREATE_BACKUP; then
        if [[ -d "$CURSOR_RULES_DIR" ]]; then
            cp -r "$CURSOR_RULES_DIR" "$BACKUP_DIR/cursor-rules"
        fi
        if [[ -d "$CURSOR_SKILLS_DIR" ]]; then
            cp -r "$CURSOR_SKILLS_DIR" "$BACKUP_DIR/cursor-skills"
        fi
    fi
    
    if [[ -d "$CURSOR_RULES_DIR" ]]; then
        rm -rf "$CURSOR_RULES_DIR"/*
        echo -e "  ${GREEN}Removed rules from $CURSOR_RULES_DIR${NC}"
    fi
    if [[ -d "$CURSOR_SKILLS_DIR" ]]; then
        rm -rf "$CURSOR_SKILLS_DIR"/*
        echo -e "  ${GREEN}Removed skills from $CURSOR_SKILLS_DIR${NC}"
    fi
    
    REMOVED+=("Cursor")
fi

# Uninstall Codex
if $REMOVE_CODEX; then
    echo -e "\n${YELLOW}Removing Codex/Copilot configuration...${NC}"
    
    CODEX_DIR="$HOME/.codex"
    
    if $CREATE_BACKUP && [[ -d "$CODEX_DIR" ]]; then
        cp -r "$CODEX_DIR" "$BACKUP_DIR/codex"
    fi
    
    if [[ -d "$CODEX_DIR" ]]; then
        rm -rf "$CODEX_DIR"/*
        echo -e "  ${GREEN}Removed configuration from $CODEX_DIR${NC}"
    fi
    
    REMOVED+=("Codex")
fi

# Uninstall Claude
if $REMOVE_CLAUDE; then
    echo -e "\n${YELLOW}Removing Claude Code configuration...${NC}"
    
    CLAUDE_DIR="$HOME/.claude"
    
    if $CREATE_BACKUP && [[ -d "$CLAUDE_DIR" ]]; then
        cp -r "$CLAUDE_DIR" "$BACKUP_DIR/claude"
    fi
    
    if [[ -d "$CLAUDE_DIR" ]]; then
        rm -rf "$CLAUDE_DIR"/*
        echo -e "  ${GREEN}Removed configuration from $CLAUDE_DIR${NC}"
    fi
    
    REMOVED+=("Claude")
fi

echo -e "\n${CYAN}=== Uninstall Complete ===${NC}"
echo -e "${GREEN}Removed for: ${REMOVED[*]}${NC}"

if $CREATE_BACKUP; then
    echo -e "\n${YELLOW}Backup saved to: $BACKUP_DIR${NC}"
fi

echo ""
echo "Please restart your IDE(s) for changes to take effect."
echo ""
