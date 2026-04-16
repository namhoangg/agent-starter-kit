<#
.SYNOPSIS
    Uninstall AI Coding Starter Kit configurations.

.DESCRIPTION
    This script removes rules and skills installed by the starter kit.
    It can optionally backup files before removal.

.PARAMETER Cursor
    Remove Cursor configuration

.PARAMETER Codex
    Remove Codex/Copilot configuration

.PARAMETER Claude
    Remove Claude Code configuration

.PARAMETER All
    Remove all configurations

.PARAMETER Backup
    Create backup before removing (recommended)

.EXAMPLE
    .\uninstall.ps1 -All
    .\uninstall.ps1 -Cursor -Backup
#>

param(
    [switch]$Cursor,
    [switch]$Codex,
    [switch]$Claude,
    [switch]$All,
    [switch]$Backup
)

# If no flags provided, show menu
if (-not ($Cursor -or $Codex -or $Claude -or $All)) {
    Write-Host "`n=== AI Coding Starter Kit Uninstaller ===" -ForegroundColor Cyan
    Write-Host "`nSelect tools to uninstall:"
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
        "5" { Write-Host "Uninstall cancelled."; exit 0 }
        default { Write-Host "Invalid choice. Exiting."; exit 1 }
    }
    
    $backupChoice = Read-Host "Create backup before removing? (y/n)"
    if ($backupChoice -eq 'y' -or $backupChoice -eq 'Y') {
        $Backup = $true
    }
}

if ($All) {
    $Cursor = $true
    $Codex = $true
    $Claude = $true
}

$removed = @()
$backupDir = "$env:USERPROFILE\.ai-starter-kit-backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"

if ($Backup) {
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
    Write-Host "`nBackup directory: $backupDir" -ForegroundColor Yellow
}

# Uninstall Cursor
if ($Cursor) {
    Write-Host "`nRemoving Cursor configuration..." -ForegroundColor Yellow
    
    $cursorRulesDir = "$env:USERPROFILE\.cursor\rules"
    $cursorSkillsDir = "$env:USERPROFILE\.cursor\skills-cursor"
    
    if ($Backup) {
        if (Test-Path $cursorRulesDir) {
            Copy-Item -Path $cursorRulesDir -Destination "$backupDir\cursor-rules" -Recurse -Force
        }
        if (Test-Path $cursorSkillsDir) {
            Copy-Item -Path $cursorSkillsDir -Destination "$backupDir\cursor-skills" -Recurse -Force
        }
    }
    
    # Remove files (but keep directories)
    if (Test-Path $cursorRulesDir) {
        Remove-Item -Path "$cursorRulesDir\*" -Force -Recurse
        Write-Host "  Removed rules from $cursorRulesDir" -ForegroundColor Green
    }
    if (Test-Path $cursorSkillsDir) {
        Remove-Item -Path "$cursorSkillsDir\*" -Force -Recurse
        Write-Host "  Removed skills from $cursorSkillsDir" -ForegroundColor Green
    }
    
    $removed += "Cursor"
}

# Uninstall Codex
if ($Codex) {
    Write-Host "`nRemoving Codex/Copilot configuration..." -ForegroundColor Yellow
    
    $codexDir = "$env:USERPROFILE\.codex"
    
    if ($Backup -and (Test-Path $codexDir)) {
        Copy-Item -Path $codexDir -Destination "$backupDir\codex" -Recurse -Force
    }
    
    if (Test-Path $codexDir) {
        Remove-Item -Path "$codexDir\*" -Force -Recurse
        Write-Host "  Removed configuration from $codexDir" -ForegroundColor Green
    }
    
    $removed += "Codex"
}

# Uninstall Claude
if ($Claude) {
    Write-Host "`nRemoving Claude Code configuration..." -ForegroundColor Yellow
    
    $claudeDir = "$env:USERPROFILE\.claude"
    
    if ($Backup -and (Test-Path $claudeDir)) {
        Copy-Item -Path $claudeDir -Destination "$backupDir\claude" -Recurse -Force
    }
    
    if (Test-Path $claudeDir) {
        Remove-Item -Path "$claudeDir\*" -Force -Recurse
        Write-Host "  Removed configuration from $claudeDir" -ForegroundColor Green
    }
    
    $removed += "Claude"
}

Write-Host "`n=== Uninstall Complete ===" -ForegroundColor Cyan
Write-Host "Removed for: $($removed -join ', ')" -ForegroundColor Green

if ($Backup) {
    Write-Host "`nBackup saved to: $backupDir" -ForegroundColor Yellow
}

Write-Host "`nPlease restart your IDE(s) for changes to take effect.`n"
