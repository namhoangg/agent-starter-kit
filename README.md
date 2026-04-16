# AI Coding Starter Kit

A comprehensive starter kit that installs clean code rules, SOLID principles, design patterns, and workflow skills globally for **Cursor**, **OpenAI Codex CLI**, and **Claude Code**.

## What's Included

### Clean Code Rules (10 rules)
| Rule | Description |
|------|-------------|
| naming-conventions | Variables, functions, classes naming standards |
| function-design | Function size, arguments, single responsibility |
| solid-principles | SRP, OCP, LSP, ISP, DIP with examples |
| design-patterns | Factory, Builder, Repository, Strategy, etc. |
| project-structure | Singular folders, descriptive file names |
| code-formatting | File size, indentation, spacing |
| error-handling | Exceptions, custom errors, fail-fast |
| comments-documentation | When to comment, API documentation |
| no-inline-imports | Keep imports at top of file |
| typescript-exhaustive-switch | Exhaustive switch handling for enums |

### Additional Rules (37 rules from Redis)
Redis best practices for data structures, caching, vector search, security, and more.

### Workflow Skills (55 skills)

**From Superpowers:**
- test-driven-development
- systematic-debugging
- brainstorming
- writing-plans
- code-review workflows
- subagent-driven-development
- and more...

**From Cursor Team Kit:**
- fix-ci
- fix-merge-conflicts
- deslop (remove AI-generated slop)
- new-branch-and-pr
- review-and-ship
- and more...

**From Vercel:**
- nextjs (App Router)
- react-best-practices
- shadcn/ui
- ai-sdk
- deployments-cicd
- vercel-functions
- and more...

**From BrowserStack:**
- run-web-tests-on-browserstack
- run-mobile-tests-on-browserstack
- scan-and-fix-accessibility

## Quick Start

### Windows (PowerShell)

```powershell
# Clone the repository
git clone https://github.com/YOUR_USERNAME/ai-coding-starter-kit.git
cd ai-coding-starter-kit

# Install for all tools
.\install.ps1 -All

# Or select specific tools
.\install.ps1 -Cursor
.\install.ps1 -Codex
.\install.ps1 -Claude
.\install.ps1 -Cursor -Codex
```

### macOS / Linux (Bash)

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/ai-coding-starter-kit.git
cd ai-coding-starter-kit

# Make scripts executable
chmod +x install.sh uninstall.sh

# Install for all tools
./install.sh --all

# Or select specific tools
./install.sh --cursor
./install.sh --codex
./install.sh --claude
./install.sh -c -x  # Cursor and Codex
```

## Installation Locations

| Tool | Location |
|------|----------|
| Cursor | `~/.cursor/rules/` and `~/.cursor/skills-cursor/` |
| Codex CLI | `~/.codex/` |
| Claude Code | `~/.claude/` |

## How It Works

### Cursor
- Rules are `.mdc` files with YAML frontmatter
- Skills are `SKILL.md` files in subdirectories
- Supports glob patterns for file-specific rules

### Codex CLI / GitHub Copilot
- Uses `AGENTS.md` as the main configuration file
- Rules and skills are plain `.md` files
- Reads from `~/.codex/AGENTS.md` globally

### Claude Code
- Uses `CLAUDE.md` as the main configuration file
- Supports `@import` syntax for modular configuration
- Rules and skills are plain `.md` files

## Repository Structure

```
ai-coding-starter-kit/
├── cursor/                  # Cursor format
│   ├── rules/              # .mdc files with YAML frontmatter
│   └── skills/             # SKILL.md in subdirectories
├── codex/                   # Codex/Copilot format
│   ├── AGENTS.md           # Main config
│   ├── rules/              # Plain .md files
│   └── skills/             # Plain .md files
├── claude/                  # Claude Code format
│   ├── CLAUDE.md           # Main config with @import
│   ├── rules/              # Plain .md files
│   └── skills/             # Plain .md files
├── install.ps1             # Windows installer
├── install.sh              # macOS/Linux installer
├── uninstall.ps1           # Windows uninstaller
├── uninstall.sh            # macOS/Linux uninstaller
├── README.md
└── LICENSE
```

## Uninstalling

### Windows
```powershell
.\uninstall.ps1 -All
.\uninstall.ps1 -All -Backup  # Create backup first
```

### macOS / Linux
```bash
./uninstall.sh --all
./uninstall.sh --all --backup  # Create backup first
```

## Customization

### Adding Your Own Rules

**For Cursor:** Add `.mdc` files to `cursor/rules/`
```yaml
---
description: My custom rule
alwaysApply: true
---

# My Custom Rule

Your rule content...
```

**For Codex/Claude:** Add `.md` files to `codex/rules/` and `claude/rules/`

### Removing Rules

Simply delete the rule file from the respective folder and re-run the install script.

## Updating

To update to the latest version:

```bash
git pull
./install.sh --all  # or .\install.ps1 -All
```

## Contributing

1. Fork this repository
2. Add or modify rules/skills
3. Test with all three tools
4. Submit a pull request

## License

MIT License - Feel free to use, modify, and distribute.

## Acknowledgments

- Clean Code principles from Robert C. Martin
- Skills from Cursor plugins: superpowers, cursor-team-kit, vercel, browserstack, redis-development
