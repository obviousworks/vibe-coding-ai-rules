# Vibe Coding Rules in short

## Setup & AI Configuration
- Use **Cursor** or **Wind Surf** as AI-powered IDEs.
- Prefer **Claude 3.7 Thinking** or **Grok 3** for agentic coding.
- Ensure **API keys** are correctly set up.
- Define **project rules** in the IDE to control AI behavior.

## Coding Workflow
- Start with **detailed specs** before generating AI code.
- Keep AI requests **small and precise** to avoid unnecessary changes.
- Run **tests frequently** to verify AI-generated code.
- Prefer **end-to-end tests** over unit tests for better real-world validation.
- Monitor **AI chat context size**, restart sessions when performance drops.

## Code Quality & Structure
- Prefer **simple solutions**, avoid over-engineering.
- Eliminate **code duplication**, reuse existing functions where possible.
- Maintain **separate environments** for DEV, TEST, and PROD.
- Only apply **requested changes**, avoid modifying unrelated parts.
- Don’t introduce **new tech or patterns** unless strictly necessary.
- Keep the codebase **clean & structured**, refactor regularly.
- Never use **mock data** in DEV or PROD, only for tests.
- Never overwrite **.env files** without explicit approval.

## Documentation & Progress Tracking
- Continuously update the **README** (installation, maintenance, key info).
- Always **verify AI-generated code** before proceeding.
- Maintain a **TODO file** (To Do, In Progress, Done) to track AI progress.

## Deployment & Version Control
- **Commit frequently** to enable easy rollbacks.
- Use **built-in IDE versioning** to revert changes when needed.
- Run AI modifications in **separate branches** before merging to main.
- Never use **YOLO mode** in production, manually approve critical deployments.

## Additional Optimizations
- Stick to **popular tech stacks** (Python, JS, SQL, etc.) for better AI support.
- Use **multiple AI agent windows** to develop features in parallel.
- Leverage **AI chat history & restore checkpoints** when needed.

