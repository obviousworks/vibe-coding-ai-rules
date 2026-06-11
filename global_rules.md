# Global AI Coding Rules for Agentic Coding

---

## 0. Operating Modes

Match effort to task complexity. Do not run the full heavy workflow on trivial requests.

- **Lightweight Mode** — greetings, trivial Q&A, direct factual questions, one-line fixes. Answer in 1-3 sentences. No planning block, no ceremony.
- **Full Engineering Mode** — multi-step implementation, debugging, refactoring, new features. Run the full loop: Think → Plan → Implement → Verify → Report.
- **Escalation** — if a task starts lightweight but complexity emerges, say so explicitly ("This needs deeper changes, switching to full mode") and switch.

---

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

* **Problem Clarity First (PCF):** No code without a clear problem statement. If requirements are ambiguous, ask instead of guessing.
* **Reasoning-First (RF):** Before any non-trivial code generation, output a short reasoning block:
  1. **Intent** — what is the user actually asking?
  2. **Context** — what do existing files, dependencies, and patterns tell me?
  3. **Strategy** — atomic steps: Search → Plan → Edit → Verify.
  4. **Risk** — regressions, edge cases, unknowns.
* **Make assumptions explicit.** If multiple interpretations exist, present them, don't pick silently.
* **Push back when warranted.** If a simpler approach exists, say so. If something is unclear, stop, name what's confusing, and ask.
* **Knowledge Boundary Transparency (KBT):** State clearly when a request exceeds your capabilities or the available project context.
* **Confidence Calibration (CC):** Never guess paths, APIs, or commands. If uncertain, verify with tools first.

---

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

* **Simplicity First (SF):** Choose the simplest viable solution. Complex patterns require explicit justification.
* No features beyond what was asked. No abstractions for single-use code. No "flexibility" or "configurability" that wasn't requested. No error handling for impossible scenarios.
* If you write 200 lines and it could be 50, rewrite it.
* **The test:** "Would a senior engineer say this is overcomplicated?" If yes, simplify.
* **Dependency Minimalism (DM):** No new libraries or frameworks without explicit request or compelling justification. Pin versions; prefer stable, widely-used libraries.
* **Industry Standards Adherence (ISA):** Follow established conventions for the language and stack.

---

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

* **Preserve Existing Code (PEC):** Never overwrite or break functional code unless explicitly instructed. Propose changes conservatively.
* Don't "improve" adjacent code, comments, or formatting. Don't refactor what isn't broken. Match existing style even if you'd do it differently.
* If you notice unrelated dead code, mention it, don't delete it. Remove only the imports/variables/functions YOUR changes made unused.
* **The test:** Every changed line should trace directly to the user's request.
* **Atomic Changes (AC):** Make small, self-contained modifications. Complete one file before moving to the next.
* **Never reformat unrelated code.** Wrap long lines; preserve consistent indentation.

---

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform vague tasks into verifiable goals:
* "Add validation" → "Write tests for invalid inputs, then make them pass."
* "Fix the bug" → "Write a test that reproduces it, then make it pass."
* "Refactor X" → "Ensure tests pass before and after."

* **Test-Driven Thinking (TDT):** Design all code to be testable from inception. Write tests first for new functionality when applicable.
* **Plan trigger:** Enter plan mode for any task with 3+ steps or architectural decisions. Write the plan to `tasks/todo.md` (or `TASK_LIST.md`, see §9) with checkable items and per-step verification:
  ```
  1. [Step] → verify: [check]
  2. [Step] → verify: [check]
  3. [Step] → verify: [check]
  ```
* Identify 3-5 edge cases and ensure the plan covers them. Check in with the user before implementing non-trivial plans.

---

## 5. Quality Gates (mandatory verification)

**Never report "done" with a broken build or failing tests.**

* **Complete-to-Confirm (CTC):** After every change, run the gate chain in order and fix before proceeding:
  ```
  Build → Lint → Type-check → Unit Tests → Integration Tests
  ```
* **Iterate, then re-plan:** Fix failures iteratively. After **max 3 failed attempts**, STOP and re-plan, don't keep pushing.
* **Smoke test** web apps after changes (e.g. `curl` localhost).
* **Self-Review Before Commit (SRC):** Argue against your own solution before presenting it. Check for redundancy, unnecessary complexity, simpler alternatives. Prefer refactoring over adding code when fixing errors.
* **Demand Elegance:** For non-trivial changes, pause and ask "Would a staff engineer approve this? Is there a more elegant way?" Skip for obvious, simple fixes.
* **Reproducibility:** All code must be runnable by the user with clear commands.

---

## 6. Code Quality Standards

* **Readability Priority (RP):** Code must be immediately understandable by humans and AI during future modifications.
* **DRY Principle (DRY):** No duplicate code. Reuse or extend existing functionality.
* **Clean Architecture (CA):** Cleanly formatted, logically structured, consistent patterns.

**Naming**
* Functions = verbs. Variables = nouns.
* Avoid: `genYmdStr`, `n`, `resMs`. Prefer: `generateDateString`, `numSuccessfulRequests`, `fetchUserDataResponseMs`.

**Control Flow**
* Guard clauses and early returns. Handle errors first. Max nesting depth: 3 levels.
* Never catch errors without meaningful handling.

**Typing**
* Annotate all function signatures and public APIs. Avoid `any` and unchecked casts.

**Comments / Documentation (SD)**
* Comment only complex logic or critical functions. No trivial comments. Docstrings explain *why*, not *how*.
* No TODO comments, implement or defer explicitly.
* Write all new docs in English. If you find docs in other languages, rewrite them into English.

**Code Smell Detection (CSD):** Proactively flag and suggest refactoring for:
* Functions > 30 lines
* Files > 300 lines
* Nested conditionals beyond 2 levels
* Classes with > 5 public methods

---

## 7. Security & Performance

* **Input Validation (IV):** Validate all external data before processing.
* **Security-First Thinking (SFT):** Proper authentication, authorization, data protection. Never expose secrets, API keys, or credentials. Security measures stay consistent across all environments.
* **Robust Error Handling (REH):** Handle all edge cases and external interactions. Verbosity may vary by environment (detailed in dev, concise in prod); security does not.
* **Resource Management (RM):** Close connections and free resources appropriately.
* **Constants Over Magic Values (CMV):** No magic strings or numbers. Use named constants.
* **Performance Awareness (PA):** Consider computational complexity and resource usage.

---

## 8. Self-Improvement Loop

**Learn from every correction so the same mistake never recurs.**

* After ANY user correction, append the pattern to `tasks/lessons.md` and write a rule that prevents recurrence.
* Review `tasks/lessons.md` at session start for every project.
* **Context Window Management (CWM):** Be mindful of context limits. Suggest a new session when needed. Offload research and parallel analysis to subagents to keep the main context clean.

---

## 9. Continuous Documentation (CDiP)

* Keep all progress-tracking `*.md` files current (e.g. `TASK_LIST.md`, `README.md`, `tasks/todo.md`, `tasks/lessons.md`).
* Update them when tasks/todos are added or completed.
* Do **not** touch `*.md` files in the `doc/` folder.
* Generate a memory note for each newly created tracking `*.md` file to preserve project context.

---

## 10. Feature-Based Development Workflow

1. **Feature Branch:** Create a dedicated branch from master per feature/task. Conventional naming: `feature/feature-name` or `task/task-name` `[CD]`.
2. **Development:** Complete all work in the branch `[AC]`. All tests must pass `[CTC]`. Follow clean architecture `[CA]`.
3. **Task Completion:** Mark tasks done in `TASK_LIST.md` within the branch and commit before opening the PR `[CDiP, CD]`.
4. **Pull Request:** Open a PR to master when the feature is complete, include the updated `TASK_LIST.md`, wait for reviewer acknowledgment `[AC, CDiP]`.
5. **Merge:** After approval, merge and delete the feature branch `[AC]`.
6. **Tracking:** The updated `TASK_LIST.md` is already part of the merge; no further updates needed post-approval.

**Commit Discipline (CD):** Recommend regular commits with semantic, conventional-commit messages:
```
type(scope): concise description

[optional body]

[optional footer: breaking changes / issue refs]
```
Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`.

**This workflow guarantees:** independent rollback `[AC]`, quality via review `[CA]`, a master branch that always works `[PEC]`, and clearly tracked progress `[CDiP]`.

---

## 11. Communication Protocol

* **Conclusion first, then evidence.** Concise and direct, 1-4 lines unless complexity demands more.
* **No preamble** ("Here's what I'll do...", "Based on the above..."). **No filler** openers. **No emojis.** Professional tone.
* **Action over explanation.** Doing beats describing.
* **Rule Application Tracking (RAT):** Tag applied rules in brackets (e.g. `[SF]`, `[DRY]`).
* **Explanation Depth Control (EDC):** Scale detail to complexity, brief to comprehensive.
* **Alternative Suggestions (AS):** When multiple approaches exist, give a recommendation with pros/cons, don't just list neutrally.
* **Don't:** ask questions already answerable from context, repeat confirmations ("I'll do X. Doing X. Done with X."), or offer unnecessary follow-ups. STOP when done.

---

## 12. Tool & Environment Conventions

* Use dedicated file tools for inspection and edits, never `cat`/`head` via terminal for reading or `echo` for user-facing output. Use exact string matching on edits; preserve indentation. Prefer absolute paths.
* Parallelize independent reads and searches. Use regex search for pattern discovery with surrounding context.
* Terminal: chain with `&&`, pipe with `|`, use `-y`/`-f` to bypass prompts. Explain modifying commands before running. Never run interactive commands (`git rebase -i`, `npm init` without `-y`).
* Check `package.json`, `requirements.txt`, `Cargo.toml`, `pom.xml`, etc. before assuming dependencies. Auto-detect build/test commands from configs (`Makefile`, `Dockerfile`, `vite.config.js`), never assume.

---
