# Global Coding Standards

This is your global AGENTS.md configuration. It applies to all projects and provides clean code principles, SOLID design patterns, and best practices.

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
- No flag arguments (split into separate functions)
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
- Keep related code close together

### Error Handling
- Prefer exceptions over error codes
- Create custom exception types
- Never swallow exceptions silently
- Fail fast with validation

### Code Formatting
- Max file size: 200-500 lines
- Max line length: 100-120 characters
- Max nesting: 2-3 levels
- Blank lines to separate concepts

### Comments
- Code should be self-documenting
- Comment WHY, not WHAT
- No commented-out code
- Keep comments updated

## Design Patterns

Use appropriate patterns:
- **Factory**: Complex object creation
- **Builder**: Many optional parameters
- **Repository**: Data access abstraction
- **Strategy**: Swappable algorithms
- **Observer**: Event-driven updates

## Rules Reference

See `rules/` folder for detailed rules:
- naming-conventions.md
- function-design.md
- solid-principles.md
- design-patterns.md
- project-structure.md
- code-formatting.md
- error-handling.md
- comments-documentation.md

## Skills Reference

See `skills/` folder for workflow skills:
- test-driven-development.md
- systematic-debugging.md
- brainstorming.md
- code-review.md
- And many more...

## Before Committing
- Run linter and tests
- No console.log/print statements in production
- No commented-out code
- Follow the project's commit message format
