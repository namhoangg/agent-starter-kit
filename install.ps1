<#
.SYNOPSIS
    Install AI Coding Starter Kit for Cursor, Codex CLI, and/or Claude Code.

.DESCRIPTION
    This script installs rules and skills globally for your selected AI coding tools.
    Files are copied to user-level directories so they apply to all projects.

.PARAMETER Cursor
    Install Cursor rules and skills to ~/.cursor/

.PARAMETER Codex
    Install Codex/Copilot configuration to ~/.codex/

.PARAMETER Claude
    Install Claude Code configuration to ~/.claude/

.PARAMETER All
    Install for all tools (Cursor, Codex, and Claude)

.EXAMPLE
    .\install.ps1 -All
    .\install.ps1 -Cursor -Codex
    .\install.ps1 -Cursor
#>

param(
    [switch]$Cursor,
    [switch]$Codex,
    [switch]$Claude,
    [switch]$All
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# If no flags provided, show menu
if (-not ($Cursor -or $Codex -or $Claude -or $All)) {
    Write-Host "`n=== AI Coding Starter Kit Installer ===" -ForegroundColor Cyan
    Write-Host "`nSelect tools to install for:"
    Write-Host "  1. Cursor only"
    Write-Host "  2. Codex/Copilot only"
    Write-Host "  3. Claude Code only"
    Write-Host "  4. All tools"
    Write-Host "  5. Cancel"
    
    $choice = Read-Host "`nEnter choice (1-5)"
    
    switch ($choice) {
        "1" { $Cursor = $true }
        "2" { $Codex = $true }
        "3" { $Claude = $true }
        "4" { $All = $true }
        "5" { Write-Host "Installation cancelled."; exit 0 }
        default { Write-Host "Invalid choice. Exiting."; exit 1 }
    }
}

if ($All) {
    $Cursor = $true
    $Codex = $true
    $Claude = $true
}

$installed = @()

# Install Cursor
if ($Cursor) {
    Write-Host "`nInstalling Cursor configuration..." -ForegroundColor Yellow
    
    $cursorRulesDir = "$env:USERPROFILE\.cursor\rules"
    $cursorSkillsDir = "$env:USERPROFILE\.cursor\skills-cursor"
    
    # Create directories
    New-Item -ItemType Directory -Force -Path $cursorRulesDir | Out-Null
    New-Item -ItemType Directory -Force -Path $cursorSkillsDir | Out-Null
    
    # Copy rules
    Copy-Item -Path "$ScriptDir\cursor\rules\*" -Destination $cursorRulesDir -Force
    Write-Host "  Rules copied to $cursorRulesDir" -ForegroundColor Green
    
    # Copy skills (with subdirectories)
    Copy-Item -Path "$ScriptDir\cursor\skills\*" -Destination $cursorSkillsDir -Recurse -Force
    Write-Host "  Skills copied to $cursorSkillsDir" -ForegroundColor Green
    
    $installed += "Cursor"
}

# Install Codex
if ($Codex) {
    Write-Host "`nInstalling Codex/Copilot configuration..." -ForegroundColor Yellow
    
    $codexDir = "$env:USERPROFILE\.codex"
    
    # Create directory
    New-Item -ItemType Directory -Force -Path $codexDir | Out-Null
    New-Item -ItemType Directory -Force -Path "$codexDir\rules" | Out-Null
    New-Item -ItemType Directory -Force -Path "$codexDir\skills" | Out-Null
    
    # Copy AGENTS.md
    Copy-Item -Path "$ScriptDir\codex\AGENTS.md" -Destination $codexDir -Force
    Write-Host "  AGENTS.md copied to $codexDir" -ForegroundColor Green
    
    # Copy rules and skills
    Copy-Item -Path "$ScriptDir\codex\rules\*" -Destination "$codexDir\rules" -Force
    Copy-Item -Path "$ScriptDir\codex\skills\*" -Destination "$codexDir\skills" -Force
    Write-Host "  Rules and skills copied to $codexDir" -ForegroundColor Green
    
    $installed += "Codex"
}

# Install Claude
if ($Claude) {
    Write-Host "`nInstalling Claude Code configuration..." -ForegroundColor Yellow
    
    $claudeDir = "$env:USERPROFILE\.claude"
    
    # Create directory
    New-Item -ItemType Directory -Force -Path $claudeDir | Out-Null
    New-Item -ItemType Directory -Force -Path "$claudeDir\rules" | Out-Null
    New-Item -ItemType Directory -Force -Path "$claudeDir\skills" | Out-Null
    
    # Copy CLAUDE.md
    Copy-Item -Path "$ScriptDir\claude\CLAUDE.md" -Destination $claudeDir -Force
    Write-Host "  CLAUDE.md copied to $claudeDir" -ForegroundColor Green
    
    # Copy rules and skills
    Copy-Item -Path "$ScriptDir\claude\rules\*" -Destination "$claudeDir\rules" -Force
    Copy-Item -Path "$ScriptDir\claude\skills\*" -Destination "$claudeDir\skills" -Force
    Write-Host "  Rules and skills copied to $claudeDir" -ForegroundColor Green
    
    $installed += "Claude"
}

Write-Host "`n=== Installation Complete ===" -ForegroundColor Cyan
Write-Host "Installed for: $($installed -join ', ')" -ForegroundColor Green
Write-Host "`nPlease restart your IDE(s) for changes to take effect."
Write-Host "To uninstall, run: .\uninstall.ps1`n"
