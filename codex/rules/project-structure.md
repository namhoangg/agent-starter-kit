# Project Structure

## Folder Naming

Use **singular** names for folders that represent concepts/categories.

```
✅ GOOD (singular)
src/
├── Controller/
├── Service/
├── Repository/
├── Entity/
├── Middleware/
├── Util/
├── Config/
├── Migration/
└── Test/

❌ BAD (plural)
src/
├── Controllers/
├── Services/
├── Repositories/
├── Entities/
```

## File Naming Conventions

File names should be **descriptive** and include their role/type.

### By Language

**JavaScript/TypeScript:**
```
UserController.ts      (PascalCase for classes)
user.controller.ts     (dot notation alternative)
userService.ts
auth.middleware.ts
```

**Python:**
```
user_controller.py     (snake_case)
auth_service.py
base_repository.py
```

**Go:**
```
user_controller.go     (snake_case)
auth_service.go
user_repository.go
```

**Java/C#:**
```
UserController.java    (PascalCase)
AuthService.cs
UserRepository.java
```

## Common Suffixes

| Suffix | Purpose | Example |
|--------|---------|---------|
| `Controller` | HTTP request handlers | `UserController.ts` |
| `Service` | Business logic | `PaymentService.ts` |
| `Repository` | Data access layer | `UserRepository.ts` |
| `Entity` / `Model` | Data structures | `UserEntity.ts` |
| `Middleware` | Request/response interceptors | `AuthMiddleware.ts` |
| `Util` / `Helper` | Utility functions | `DateUtil.ts` |
| `Factory` | Object creation | `UserFactory.ts` |
| `Validator` | Validation logic | `EmailValidator.ts` |
| `Handler` | Event/message handlers | `OrderHandler.ts` |
| `Adapter` | Interface adaptation | `PaymentAdapter.ts` |

## Recommended Project Structure

```
project-root/
├── src/
│   ├── Controller/           # HTTP/API endpoints
│   │   ├── UserController.ts
│   │   └── OrderController.ts
│   ├── Service/              # Business logic
│   │   ├── UserService.ts
│   │   └── OrderService.ts
│   ├── Repository/           # Data access
│   │   ├── UserRepository.ts
│   │   └── OrderRepository.ts
│   ├── Entity/               # Domain models
│   │   ├── User.ts
│   │   └── Order.ts
│   ├── DTO/                  # Data transfer objects
│   │   ├── CreateUserDto.ts
│   │   └── UpdateOrderDto.ts
│   ├── Middleware/           # Request interceptors
│   │   ├── AuthMiddleware.ts
│   │   └── LoggingMiddleware.ts
│   ├── Util/                 # Utilities
│   │   ├── DateUtil.ts
│   │   └── StringUtil.ts
│   ├── Config/               # Configuration
│   │   ├── database.config.ts
│   │   └── app.config.ts
│   ├── Exception/            # Custom errors
│   │   ├── ValidationException.ts
│   │   └── NotFoundException.ts
│   └── Interface/            # Interfaces/Contracts
│       ├── IUserRepository.ts
│       └── IPaymentGateway.ts
├── test/                     # Test files
│   ├── Unit/
│   └── Integration/
├── doc/                      # Documentation
└── script/                   # Build/deploy scripts
```

## Module Organization

Group related code together when it makes sense:

```
src/
├── User/                     # Feature-based
│   ├── UserController.ts
│   ├── UserService.ts
│   ├── UserRepository.ts
│   └── User.ts
├── Order/
│   ├── OrderController.ts
│   ├── OrderService.ts
│   └── Order.ts
└── Shared/
    ├── Middleware/
    └── Util/
```

## File Colocation

Keep related files close:

```
✅ GOOD: Test next to implementation
src/Service/
├── UserService.ts
├── UserService.test.ts
└── UserService.mock.ts

✅ GOOD: Component with styles (frontend)
src/Component/Button/
├── Button.tsx
├── Button.css
└── Button.test.tsx
```

## Index Files

Use index files for clean imports:

```typescript
// src/Service/index.ts
export { UserService } from './UserService';
export { OrderService } from './OrderService';

// Usage
import { UserService, OrderService } from './Service';
```

