# Global Coding Standards

This is your global CLAUDE.md configuration for Claude Code. It provides clean code principles, SOLID design patterns, and best practices.

## Core Rules

@import rules/naming-conventions.md
@import rules/function-design.md
@import rules/solid-principles.md
@import rules/design-patterns.md
@import rules/project-structure.md
@import rules/code-formatting.md
@import rules/error-handling.md
@import rules/comments-documentation.md

## Quick Reference

### Naming Conventions
- Use descriptive, self-documenting names
- Classes: nouns (`User`, `OrderService`)
- Methods: verbs (`createUser`, `processOrder`)
- No type encodings (`strName` → `name`)
- Consistent terminology across codebase

### Function Design
- Keep functions small (max 60 lines)
- Max 2-3 arguments preferred
- Single responsibility (do one thing well)
- No flag arguments
- No side effects

### SOLID Principles
- **S**ingle Responsibility: One reason to change per class
- **O**pen/Closed: Extend without modifying
- **L**iskov Substitution: Subtypes must be substitutable
- **I**nterface Segregation: Small, focused interfaces
- **D**ependency Inversion: Depend on abstractions

### Project Structure
- Singular folder names: `Entity/`, `Service/`, `Controller/`
- Descriptive file names: `UserController.ts`, `auth_service.py`

### Error Handling
- Prefer exceptions over error codes
- Create custom exception types
- Never swallow exceptions silently
- Fail fast with validation

## Claude-Specific Instructions

- Use structured thinking for complex problems
- Break down large tasks into smaller steps
- Prefer TypeScript over JavaScript when possible
- Follow existing project conventions
- Ask clarifying questions when requirements are ambiguous

## Workflow Skills

The following skills are available in the `skills/` folder:

### Development Workflows
- test-driven-development.md - TDD best practices
- systematic-debugging.md - Debugging methodology
- brainstorming.md - Design exploration

### Code Quality
- requesting-code-review.md - Code review process
- receiving-code-review.md - Handling feedback
- deslop.md - Remove AI-generated code slop

### CI/CD & Deployment
- fix-ci.md - Fix CI failures
- loop-on-ci.md - Monitor CI runs
- deployments-cicd.md - Deployment strategies

### React/Next.js (Vercel)
- nextjs.md - Next.js App Router
- react-best-practices.md - React patterns
- shadcn.md - shadcn/ui components

## Before Committing
- Run linter and tests
- No console.log/print statements in production
- No commented-out code
- Follow the project's commit message format
