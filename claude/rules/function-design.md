# Function Design

## Size Matters

- Functions should be **small** (ideally under 20 lines, max 60)
- Maximum indent level: **2 levels**
- If a function is growing, it's doing too much

## Single Responsibility

A function should **do one thing, do it well, do it only**.

```
❌ BAD: Multiple responsibilities
function processUser(user) {
  validateUser(user);
  saveToDatabase(user);
  sendEmail(user);
  logActivity(user);
}

✅ GOOD: Single responsibility
function validateUser(user) { ... }
function saveUser(user) { ... }
function notifyUser(user) { ... }
function logUserActivity(user) { ... }
```

## Descriptive Names

Long, descriptive names are better than short, cryptic ones.

```
❌ BAD: testableHtml(), proc(), handle()
✅ GOOD: renderSetupTeardownIncluder(), processPayment(), handleUserLogin()
```

## Function Arguments

**Fewer is better**:
- **Best**: 0 arguments (niladic)
- **Good**: 1 argument (monadic)
- **Acceptable**: 2 arguments (dyadic)
- **Avoid**: 3+ arguments (triadic+)

## Argument Patterns

### 1. Ask a Question (returns boolean)
```
boolean fileExists("config.json")
boolean isValidEmail(email)
```

### 2. Transform Input → Return Result
```
InputStream fileOpen("data.txt")
User parseUser(jsonString)
```

### 3. Event (changes state, no return)
```
void passwordAttemptFailed(int attempts)
void userLoggedIn(userId)
```

## No Flag Arguments

Boolean flags indicate the function does multiple things.

```
❌ BAD
render(true)  // What does true mean?
createUser(user, true, false)

✅ GOOD
renderForPrint()
renderForScreen()
createActiveUser(user)
createInactiveUser(user)
```

## Argument Objects

Group related arguments into objects.

```
❌ BAD
Circle makeCircle(double x, double y, double radius)
void createUser(string firstName, string lastName, string email, string phone)

✅ GOOD
Circle makeCircle(Point center, double radius)
void createUser(UserCreationRequest request)
```

## No Side Effects

Functions should not cause hidden changes.

```
❌ BAD: Hidden side effect
boolean checkPassword(user, password) {
  if (cryptographer.decrypt(password) == user.password) {
    Session.initialize();  // Hidden side effect!
    return true;
  }
  return false;
}

✅ GOOD: Explicit and separate
boolean validatePassword(user, password) { ... }
void initializeSession(user) { ... }
```

## No Output Arguments

Don't use arguments to return values.

```
❌ BAD
void includeSetupPageInto(StringBuffer pageText)
void appendFooter(Report report)

✅ GOOD
StringBuffer includeSetupPage(StringBuffer pageText)
report.appendFooter()
```

## Command-Query Separation

A function should either **do something** OR **return something**, never both.

```
❌ BAD: Does both
boolean set(attribute, value)  // Sets AND returns success

✅ GOOD: Separate concerns
void setAttribute(attribute, value)
boolean attributeExists(attribute)
```

## DRY - Don't Repeat Yourself

Duplicate code is a bug waiting to happen.

```
❌ BAD: Duplicated validation logic in multiple places

✅ GOOD: Extract to single function
function validateEmail(email) { ... }
// Used everywhere email validation is needed
```

