# Global AI Coding Rules for Windsurf

These rules establish universal standards and preferences that apply across all projects developed with Windsurf AI assistance. Copy this into Windsurf → Settings → AI Settings → Global Rules (max ~6000 chars).

## Core Principles

* **Problem Clarity First (PCF):** Always clarify the intent and problem before generating code. No code without a clear problem statement.
* **Simplicity First (SF):** Always choose the simplest viable solution. Complex patterns require explicit justification.
* **Readability Priority (RP):** Code must be immediately understandable by both humans and AI.
* **Dependency Minimalism (DM):** No new libraries without explicit request or compelling justification.
* **Industry Standards Adherence (ISA):** Follow established conventions for the relevant language and tech stack.
* **Strategic Documentation (SD):** Comment only complex logic or critical functions. Avoid documenting the obvious. {{DOCUMENTATION_LANGUAGE_PREFERENCE}}
* **Test-Driven Thinking (TDT):** Design all code to be easily testable from inception.

## Workflow Standards

* **Atomic Changes (AC):** Make small, self-contained modifications to improve traceability and rollback capability.
* **Commit Discipline (CD):** Use conventional commit format:
  ```
  type(scope): concise description
  ```
  Types: feat, fix, docs, style, refactor, perf, test, chore
* **Transparent Reasoning (TR):** When generating code, explicitly reference which global rules influenced decisions.
* **Context Window Management (CWM):** Be mindful of AI context limitations. Suggest new sessions when necessary.
* **Preserve Existing Code (PEC):** Do not overwrite or break functional code unless explicitly instructed. Propose changes conservatively.
* **Self-Review Before Commit (SRC):** After generating code, actively argue against your own solution. Check for redundancy, unnecessary complexity, or simpler alternatives.

## Code Quality Guarantees

* **DRY Principle (DRY):** No duplicate code. Reuse or extend existing functionality.
* **Clean Architecture (CA):** Generate cleanly formatted, logically structured code with consistent patterns.
* **Robust Error Handling (REH):** Integrate appropriate error handling for edge cases and external interactions.
* **Code Smell Detection (CSD):** Proactively identify and suggest refactoring for:
  * Functions exceeding {{MAX_FUNCTION_LINES}} lines
  * Files exceeding {{MAX_FILE_LINES}} lines
  * Nested conditionals beyond {{MAX_NESTING_DEPTH}} levels

## Security & Performance

* **Input Validation (IV):** All external data must be validated before processing.
* **Resource Management (RM):** Close connections and free resources appropriately.
* **Constants Over Magic Values (CMV):** No magic strings or numbers. Use named constants.
* **Security-First Thinking (SFT):** Implement proper authentication, authorization, and data protection.
* **Performance Awareness (PA):** Consider computational complexity and resource usage.

## AI Communication

* **Rule Application Tracking (RAT):** Tag rule applications with abbreviation in brackets (e.g., [SF], [DRY]).
* **Explanation Depth Control (EDC):** Scale explanation detail based on complexity.
* **Alternative Suggestions (AS):** When relevant, offer alternative approaches with pros/cons.

## Documentation & Tracking

{{DOCUMENTATION_TRACKING_RULES}}

## Development Workflow

{{DEVELOPMENT_WORKFLOW}}
