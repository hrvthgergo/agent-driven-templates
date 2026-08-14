# Code Graph Structural Node Template

This template defines the standard markdown format for registering structural nodes in `agent-workspace/src/<layer>/code_graph/graph.md`.

---

## Structural Element Registry

### Node: `[Node Name / Symbol]`
- **Layer**: `[codebase-ui | codebase-engine | codebase-data | codebase-ops]`
- **File Location**: `[relative/path/to/source_file.ext]`
- **Node Type**: `[Module | Class | Struct | Interface | Function | Protocol | Middleware]`
- **Language**: `[Python | Go | JavaScript | TypeScript]`
- **Exported / Public**: `[Yes | No]`

#### Connections & Relationships
- `IMPORTS`: `[Module / Package imported]`
- `IMPLEMENTS`: `[Interface / Protocol satisfied]`
- `CALLS`: `[Function / Method invoked]`
- `EXTENDS`: `[Base Class inherited]`
- `USES_DATA`: `[Dataclass / Struct / Model consumed]`
