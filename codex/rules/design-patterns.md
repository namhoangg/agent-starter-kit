# Design Patterns

## Creational Patterns

### Factory Method

Use when: Object creation logic is complex or needs to be centralized.

```typescript
// Instead of: new User(data) everywhere
class UserFactory {
  static createAdmin(data: UserData): User {
    return new User({ ...data, role: 'admin', permissions: ADMIN_PERMISSIONS });
  }
  
  static createGuest(): User {
    return new User({ role: 'guest', permissions: GUEST_PERMISSIONS });
  }
}
```

### Builder

Use when: Object construction requires many optional parameters.

```typescript
// Instead of: new Report(title, null, null, data, null, format, ...)
const report = new ReportBuilder()
  .setTitle("Sales Q4")
  .setData(salesData)
  .setFormat("pdf")
  .build();
```

### Singleton

Use when: Exactly one instance should exist (use sparingly).

```typescript
class DatabaseConnection {
  private static instance: DatabaseConnection;
  
  private constructor() { }
  
  static getInstance(): DatabaseConnection {
    if (!this.instance) {
      this.instance = new DatabaseConnection();
    }
    return this.instance;
  }
}
```

## Structural Patterns

### Adapter

Use when: Converting one interface to another.

```typescript
// Legacy system returns XML, but we need JSON
class XmlToJsonAdapter implements JsonDataSource {
  constructor(private xmlSource: XmlDataSource) { }
  
  getData(): JsonObject {
    const xml = this.xmlSource.getXmlData();
    return this.convertToJson(xml);
  }
}
```

### Decorator

Use when: Adding behavior to objects dynamically.

```typescript
interface Coffee { cost(): number; description(): string; }

class SimpleCoffee implements Coffee { ... }

class MilkDecorator implements Coffee {
  constructor(private coffee: Coffee) { }
  cost() { return this.coffee.cost() + 0.5; }
  description() { return this.coffee.description() + ", milk"; }
}
```

### Repository

Use when: Abstracting data access logic.

```typescript
interface UserRepository {
  findById(id: string): User | null;
  findByEmail(email: string): User | null;
  save(user: User): void;
  delete(id: string): void;
}

class PostgresUserRepository implements UserRepository { ... }
class InMemoryUserRepository implements UserRepository { ... }  // For testing
```

## Behavioral Patterns

### Strategy

Use when: Swapping algorithms at runtime.

```typescript
interface PricingStrategy {
  calculate(basePrice: number): number;
}

class RegularPricing implements PricingStrategy { ... }
class PremiumDiscount implements PricingStrategy { ... }
class HolidaySale implements PricingStrategy { ... }

class ShoppingCart {
  constructor(private pricing: PricingStrategy) { }
  
  getTotal(): number {
    return this.pricing.calculate(this.subtotal);
  }
}
```

### Observer

Use when: Objects need to react to state changes in another object.

```typescript
interface Observer {
  update(data: any): void;
}

class EventEmitter {
  private observers: Observer[] = [];
  
  subscribe(observer: Observer) { this.observers.push(observer); }
  notify(data: any) { this.observers.forEach(o => o.update(data)); }
}
```

### Command

Use when: Encapsulating operations as objects (undo/redo, queuing).

```typescript
interface Command {
  execute(): void;
  undo(): void;
}

class CreateUserCommand implements Command {
  execute() { /* create user */ }
  undo() { /* delete user */ }
}
```

## When to Apply

| Situation | Consider |
|-----------|----------|
| Complex object creation | Factory, Builder |
| Need to swap implementations | Strategy, Adapter |
| Adding features to existing classes | Decorator |
| Data access abstraction | Repository |
| Decoupling event handling | Observer |
| Undo/redo functionality | Command |

## Anti-Patterns to Avoid

- **God Object**: Class that knows/does too much
- **Spaghetti Code**: No clear structure or separation
- **Copy-Paste Programming**: Duplicating instead of abstracting
- **Magic Numbers/Strings**: Hardcoded values without explanation
- **Premature Optimization**: Optimizing before measuring

