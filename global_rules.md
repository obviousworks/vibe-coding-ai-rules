# Global AI Coding Rules for Windsurf

These rules establish universal standards and preferences that apply across all projects developed with Windsurf AI assistance.

## Core Principles

* **Simplicity First (SF):** Always choose the simplest viable solution. Complex patterns or architectures require explicit justification.
* **Readability Priority (RP):** Code must be immediately understandable by both humans and AI during future modifications.
* **Dependency Minimalism (DM):** No new libraries or frameworks without explicit request or compelling justification.
* **Industry Standards Adherence (ISA):** Follow established conventions for the relevant language and tech stack.
* **Strategic Documentation (SD):** Comment only complex logic or critical functions. Avoid documenting the obvious.
Write new docs in english. If you find docs in other languages, rewrite them into english.
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
* **Preserve Existing Code (PEC):** Windsurf must not overwrite or break functional code unless explicitly instructed otherwise. Propose changes conservatively to maintain codebase integrity [AC, CA]

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

## Continous documentation during development process (CDiP)

* **Keep all  *.md files up-to-date, which where used to keep track of progress, todos and help ing infos** (e.g. TASK_LIST.md, README.md, LEARNING_FROM_JAVA.md, VAU_IMPLEMENTATION_PLAN.md, etc.)
- generate memories for each new created or new requested md file, which shall help the AI or the developer to keep track of the project context and progress.
- update the md files, when new tasks are added, completed or when new todos are added or completed.
- but do not touch *.md files in doc folder!  

## Feature-Based Development Workflow

1. **Create Feature Branch:**
   - For each new feature or task, create a dedicated feature branch from master.
   - Use descriptive branch names with conventional format: `feature/feature-name` or `task/task-name` [CD].

2. **Development Process:**
   - Complete all development work in the feature branch [AC].
   - Ensure all tests pass successfully before considering the task complete [CTC].
   - Follow clean architecture principles and coding standards [CA].

3. **Task Completion in Feature Branch:**
   - Mark tasks as completed in `TASK_LIST.md` within the feature branch [CDiP].
   - Commit these changes to the feature branch [CD].
   - This should be done before creating the pull request.

4. **Pull Request Process:**
   - Create a pull request to the master branch when feature is complete [AC].
   - Include the updated `TASK_LIST.md` in the pull request [CDiP].
   - Wait for reviewer acknowledgment before proceeding.

5. **Merge Process:**
   - After approval, merge the feature branch into master.
   - Delete the feature branch after successful merge [AC].

6. **Task Tracking:**
   - The updated `TASK_LIST.md` is already part of the merged changes [CDiP].
   - No additional updates to `TASK_LIST.md` should be needed after the PR is approved.

**This workflow ensures that:**
   - Each feature can be rolled back independently if needed [AC].
   - Code quality is maintained through the review process [CA].
   - The master branch always contains a working version of the application [PEC].
   - Progress is clearly tracked and documented [CDiP].
   - Task completion is part of the feature work and included in the review process [CD].
