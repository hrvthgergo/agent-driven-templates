# Dependency Risk & Coupling Analysis: `<layer_name>` Layer

**Location**: `antigravity-workspace/src/<layer_name>/code_graph/risk_analysis.md`  
**Description**: Block 2 (Perspective C) — Coupling metrics (fan-in / fan-out connection counts), critical code nodes, and test coverage maps.

---

## 1. Node Coupling Metrics (Fan-In / Fan-Out)

| Element Name | Fan-In (Incoming Connections) | Fan-Out (Outgoing Calls) | Criticality Level | Risk Assessment |
| :--- | :--- | :--- | :--- | :--- |
| `DBConnector` | 15 | 2 | **High** | Core dependency across all services. Single point of failure. |
| `UserHandler` | 3 | 8 | **Medium** | Moderate coupling to downstream services. |
| `FormatUtil` | 22 | 0 | **Low** | Pure utility function. Highly reusable. |

---

## 2. Test Coverage & Risk Map

| Element ID | Element Name | Critical Node? | Existing Test File Location | Assertion Coverage Status |
| :--- | :--- | :--- | :--- | :--- |
| `E-001` | `EngineService` | Yes | `[tests/engine_test.go]` | Covered (Unit & Integration) |
| `E-002` | `AuthHandler` | Yes | `[tests/auth_test.go]` | Missing Assertions |
| `E-003` | `ExportService` | No | None | Uncovered |
