## Core Principles

* **Simplicity First (SF):** Always choose the simplest viable solution. Complex patterns or architectures require explicit justification.
* **Readability Priority (RP):** Code must be immediately understandable by both humans and AI during future modifications.
* **Dependency Minimalism (DM):** No new libraries or frameworks without explicit request or compelling justification.
* **Industry Standards Adherence (ISA):** Follow established conventions for the relevant language and tech stack.
* **Strategic Documentation (SD):** Comment only complex logic or critical functions. Avoid documenting the obvious.
* **Test-Driven Thinking (TDT):** Design all code to be easily testable from inception.

## Workflow Standards

* **Atomic Changes (AC):** Make small, self-contained modifications to improve traceability and rollback capability.
* **Commit Discipline (CD):** Recommend regular commits with semantic messages using conventional commit format:
  ```
  type(scope): concise description
  
  [optional body with details]
  
  [optional footer with breaking changes/issue references]
  ```
  Types: feat, fix, docs, style, refactor, perf, test, chore
* **Transparent Reasoning (TR):** When generating code, explicitly reference which global rules influenced decisions.
* **Context Window Management (CWM):** Be mindful of AI context limitations. Suggest new sessions when necessary.

## Code Quality Guarantees

* **DRY Principle (DRY):** No duplicate code. Reuse or extend existing functionality.
* **Clean Architecture (CA):** Generate cleanly formatted, logically structured code with consistent patterns.
* **Robust Error Handling (REH):** Integrate appropriate error handling for all edge cases and external interactions.
* **Code Smell Detection (CSD):** Proactively identify and suggest refactoring for:
  * Functions exceeding 30 lines
  * Files exceeding 300 lines
  * Nested conditionals beyond 2 levels
  * Classes with more than 5 public methods

## Security & Performance Considerations

* **Input Validation (IV):** All external data must be validated before processing.
* **Resource Management (RM):** Close connections and free resources appropriately.
* **Constants Over Magic Values (CMV):** No magic strings or numbers. Use named constants.
* **Security-First Thinking (SFT):** Implement proper authentication, authorization, and data protection.
* **Performance Awareness (PA):** Consider computational complexity and resource usage.

## AI Communication Guidelines

* **Rule Application Tracking (RAT):** When applying rules, tag with the abbreviation in brackets (e.g., [SF], [DRY]).
* **Explanation Depth Control (EDC):** Scale explanation detail based on complexity, from brief to comprehensive.
* **Alternative Suggestions (AS):** When relevant, offer alternative approaches with pros/cons.
* **Knowledge Boundary Transparency (KBT):** Clearly communicate when a request exceeds AI capabilities or project context.
