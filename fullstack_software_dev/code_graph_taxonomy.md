# Specification: Language-Specific Code Graph Node & Connection Taxonomy

This specification defines the universal node types, connection relationships, and language-specific structural taxonomies for building and maintaining **Code Graphs** across the development lifecycle (initially generated during `/process` and continuously updated during `/implement`).

---

## 1. Core Architecture & Multi-Lifecycle Role

The Code Graph is a general-purpose, evolving representation of a codebase's structural topology. It bridges historical code understanding with active code generation:

*   **Lifecycle Phase 1 (`/process`)**: Analyzes legacy codebases and extracts structural nodes and connections to generate initial `agent-workspace/src/<layer>/code_graph/` subfolders (`graph.md`, `process_flow.md`, `data_flow.md`, `risk_analysis.md`).
*   **Lifecycle Phase 2 (`/implement`)**: Provides optional, on-demand code graph synchronization (`/implement --code-graph` or `/implement --full-sync`) as new features, classes, functions, or interfaces are implemented. By making code graph updates optional during routine code scaffolding, the framework prevents token bloat and reduces computational overhead.

---

## 2. Language-Specific Node & Connection Taxonomies

Because each programming language possesses distinct architectural building blocks, Code Graphs enforce language-specific node types and relationship classifications for Python, Go (Golang), and JavaScript.

---

### A. Python Taxonomy

#### Node Types (Python Structural Elements)
| Node Type | Code Element Representation | Example Signature |
| :--- | :--- | :--- |
| `Module` | `.py` file or package directory with `__init__.py` | `engine/services/auth.py` |
| `Class` | Object-oriented class definition | `class UserService:` |
| `Dataclass` / `PydanticModel` | Data container / schema model | `@dataclass class UserDTO:` / `class UserModel(BaseModel):` |
| `Protocol` / `AbstractBaseClass` | Interface or abstract contract | `class Repository(Protocol):` / `class BaseEngine(ABC):` |
| `Function` / `Method` | Standalone function, method, or async coroutine | `def process_data(self):` / `async def fetch_user():` |
| `Decorator` | Function/class wrapping annotation | `@router.get("/users")` / `@cache_response` |
| `Exception` | Custom exception class | `class UserNotFoundError(Exception):` |
| `GlobalVar` / `Constant` | Top-level module variable or constant | `MAX_RETRIES = 5` / `db_pool = EnginePool()` |

#### Connection Types (Python Relationships)
*   `IMPORTS`: Module A imports symbol from Module B (`from .utils import format_date`).
*   `INHERITS`: Class A inherits from Class B (`class AdminUser(User)`).
*   `IMPLEMENTS`: Class satisfies a `Protocol` or `ABC` (`class PostgresRepo(Repository)`).
*   `DECORATES`: Decorator wraps a function or class (`@app.get` decorates `get_users`).
*   `CALLS`: Function/Method A invokes Function/Method B (`service.execute()` calls `db.query()`).
*   `INSTANTIATES`: Function/Method creates a Class instance (`repo = UserRepository()`).
*   `RAISES` / `CATCHES`: Method raises or catches a custom Exception (`raise ItemNotFoundError()`).
*   `MUTATES` / `READS`: Method reads or modifies a `GlobalVar`/`Constant`.

---

### B. Go (Golang) Taxonomy

#### Node Types (Go Structural Elements)
| Node Type | Code Element Representation | Example Signature |
| :--- | :--- | :--- |
| `Package` | Go package scope (`package main`, `package service`) | `package service` |
| `File` | `.go` source file within package | `engine/service/user.go` |
| `Struct` | Data structure definition | `type User struct { ID string }` |
| `Interface` | Behavior interface contract | `type UserRepository interface { GetUser() }` |
| `Function` / `Method` | Standalone function or receiver method | `func NewEngine()` / `func (s *Service) Process()` |
| `Goroutine` / `Channel` | Asynchronous worker / typed communication channel | `go workerLoop()` / `chan JobData` |
| `TypeAlias` / `CustomType` | Custom type definition | `type UserID string` / `type Status int` |
| `PackageVar` / `Const` | Package-level variable or constant | `var ErrNotFound = errors.New(...)` / `const MaxBatch = 100` |

#### Connection Types (Go Relationships)
*   `IMPORTS`: Package A imports Package B (`import "github.com/user/app/pkg/db"`).
*   `IMPLEMENTS`: Struct implicitly satisfies an Interface (`*PostgresRepo` satisfies `UserRepository`).
*   `EMBEDS`: Struct embeds another Struct or Interface (`type Admin struct { User }`).
*   `CALLS`: Function/Method A invokes Function/Method B (`NewServer()` calls `InitConfig()`).
*   `CONSTRUCTS`: Factory function returns a Struct pointer (`func NewUser()` returns `*User`).
*   `RECEIVES_ON` / `SENDS_TO`: Function reads from or writes to a `Channel` (`ch <- data`).
*   `RETURNS_ERROR`: Function returns a Go `error` interface.

---

### C. JavaScript (Node.js / ES6+) Taxonomy

#### Node Types (JavaScript Structural Elements)
| Node Type | Code Element Representation | Example Signature |
| :--- | :--- | :--- |
| `Module` | ES module (`.mjs`, `.js`) or CommonJS file | `src/controllers/userController.js` |
| `Class` | ES6 class definition | `class AuthController extends BaseController` |
| `Function` / `ArrowFunction` | Function declaration, expression, or arrow func | `async function fetchUsers()` / `const calculateTotal = () =>` |
| `Export` / `DefaultExport` | Exported module symbol or default export | `export const userService` / `export default app` |
| `Middleware` | Express/Koa request handling middleware | `const authMiddleware = (req, res, next) =>` |
| `Event` / `EventEmitter` | Event emitter instance or event channel | `const bus = new EventEmitter()` / `'user:registered'` |
| `Promise` / `AsyncOp` | Asynchronous operation node | `new Promise((resolve, reject) => ...)` |
| `ObjectLiteral` / `ConfigConst` | Configuration object or exported constant | `const config = { port: 8080 }` |

#### Connection Types (JavaScript Relationships)
*   `IMPORTS` / `REQUIRES`: Module imports symbol (`import { auth } from './auth'`, `const fs = require('fs')`).
*   `EXPORTS`: Module exposes symbol (`export default router`).
*   `EXTENDS`: Class inherits from base Class (`class CustomError extends Error`).
*   `CALLS`: Function A calls Function B (`fetchUsers()` calls `apiClient.get()`).
*   `HANDLES_EVENT` / `EMITS_EVENT`: Listener subscribes to or triggers an event (`bus.on('login')`, `bus.emit('login')`).
*   `USES_MIDDLEWARE`: Application mounts middleware (`app.use(authMiddleware)`).
*   `PROMISIFIES` / `AWAITS`: Async function awaits a Promise (`await database.connect()`).

---

## 3. Formatting & File Organization (`antigravity-workspace/src/<layer>/code_graph/`)

Every workspace layer maintains its Code Graph inside `antigravity-workspace/src/<layer>/code_graph/` structured into 4 files:

```text
antigravity-workspace/src/<layer>/code_graph/
├── graph.md          # Block 1: Unordered Mermaid graph (node types & connection relationships)
├── process_flow.md   # Block 2A: Process entry points & control flow initiation
├── data_flow.md      # Block 2B: Data sources (user, configs, APIs, DB, hardcoded)
└── risk_analysis.md  # Block 2C: Coupling metrics (fan-in/fan-out) & test coverage maps
```
