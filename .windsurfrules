<project_description>
### Project Description

**"FocusForge"** - An advanced Pomodoro timer application with AI-driven productivity insights, customizable work rhythms, and team synchronization capabilities for distributed teams.
</project_description>

<main_goals>
### Main Goals

- Develop an adaptive Pomodoro system that learns user productivity patterns.
- Create a distraction-blocking mechanism with browser and OS integration.
- Implement team synchronization for coordinated deep work sessions.
- Build a comprehensive analytics dashboard with mood tracking, productivity scores, and focus metrics.
- Create a gamified achievement system to reward consistent deep work habits.
</main_goals>

<architecture_overview>
### Architecture Overview

- **Type:** Progressive Web App (PWA) with offline capabilities.
- **Backend:** Serverless architecture for scalability and real-time synchronization.
</architecture_overview>

<technology_stack>
## Technology Stack

* **Primary Programming Languages:**
  * TypeScript 5.2+ (strict mode)
  * Python 3.11+ (for analytics backend)
  
* **Frameworks/Libraries:**
  * Frontend: React 18.2, Next.js 14.0, TailwindCSS 3.3
  * Backend: NestJS 10.0, FastAPI 0.104
  * State Management: Zustand 4.4, React Query 5.0
  * Testing: Vitest 0.34, Playwright 1.40
  
* **Databases:**
  * PostgreSQL 15+ with Prisma ORM (main data)
  * MongoDB 6.0+ with Mongoose (user analytics)
  * Redis 7.0+ (caching)
  
* **Additional Tools/Technologies:**
  * Docker & Docker Compose
  * GitHub Actions for CI/CD
  * AWS (ECS, RDS, S3)
  * OpenTelemetry for observability
  
* **Explicitly DO NOT use:**
  * Redux (use Zustand instead)
  * CSS-in-JS libraries (use TailwindCSS)
  * Axios (use native fetch API)
  * jQuery or other legacy libraries
  * Material UI (use Radix UI primitives with custom styling)
</technology_stack>

<project_structure>
## Project Structure Example


* **Directory Structure:**
```
├── apps/
│   ├── web/               # Next.js frontend
│   │   ├── src/
│   │   │   ├── app/       # App router pages
│   │   │   ├── components/
│   │   │   ├── hooks/
│   │   │   ├── lib/       # Utilities
│   │   │   ├── services/  # API clients
│   │   │   └── types/
│   ├── api/               # NestJS API service
│   │   ├── src/
│   │   │   ├── modules/
│   │   │   ├── common/
│   │   │   └── tests/
│   ├── analytics/         # FastAPI analytics service
│   │   ├── src/
│   │   │   ├── routes/
│   │   │   ├── models/
│   │   │   ├── services/
│   │   │   └── tests/
├── packages/              # Shared libraries
│   ├── ui/                # Component library
│   ├── config/            # Shared configuration
│   ├── types/             # Shared TypeScript types
│   └── utils/             # Shared utilities
├── infrastructure/        # IaC and deployment
│   ├── terraform/
│   ├── docker/
│   └── scripts/
```
* **Reusable Components/Modules:**
  * `packages/ui` - Component library with design system primitives
  * `packages/utils/analytics` - Analytics tracking utilities
  * `packages/utils/formatting` - Data formatting helpers
  * `packages/utils/validation` - Input validation functions
</project_structure>

<coding_style>
## Coding Style and Conventions

* **Language-Specific Style Guides:**
  * TypeScript: Airbnb style guide with project-specific ESLint config
  * Python: PEP 8 with Black formatter (line length 88)
  
* **Naming Conventions:**
  * TypeScript:
    * PascalCase for components, interfaces, types, and classes
    * camelCase for variables, functions, and instances
    * UPPER_SNAKE_CASE for constants
  * Python:
    * snake_case for variables, functions, and methods
    * PascalCase for classes
    * UPPER_SNAKE_CASE for constants
  
* **Specific Formatting Rules:**
  * Indentation: 2 spaces for TypeScript, 4 spaces for Python
  * Maximum line length: 100 characters
  * Single quotes for TypeScript, double quotes for Python
  * Trailing commas required in multiline arrays/objects
  * Semicolons required in TypeScript
  
* **Comment Guidelines:**
  * Use JSDoc/TSDoc for public API functions
  * Inline comments only for non-obvious solutions
  * Comment complex algorithms with time/space complexity analysis
  * Include references to external resources where relevant
  
* **Environment Variables:**
  * Never commit .env files to version control
  * Use .env.example files with dummy values
  * Document all environment variables in README.md
  # Document all important steps how to deploy, install the application in README.md, keep it up to date
  * Group variables by service/purpose with prefixes
</coding_style>

<workflow>
## Workflow

* **Testing Strategy:**
  * Unit tests for utilities and pure functions (>90% coverage)
  * Integration tests for API endpoints and services
  * E2E tests for critical user flows
  * Visual regression tests for UI components
  
* **Deployment Process:**
  * PR builds deployed to preview environments
  * Main branch deploys to staging environment
  * Release tags deploy to production
  * Database migrations run automatically in CI/CD
  
* **Branching Strategy:**
  * Feature branches: `feature/feature-name`
  * Bugfix branches: `fix/issue-description`
  * Release branches: `release/v1.2.3`
  * Test AI changes in separate branches: `ai/description`
</workflow>

<ai_interaction>
## AI Interaction

* **Focus in Requests:**
  * Limit scope to specific files or functions
  * Provide clear acceptance criteria
  * Use custom tags for structured requests: `<request>...</request>`
  
* **Handling Existing Code:**
  * Preserve formatting and style of surrounding code
  * Leave existing comments intact unless specifically editing them
  * Match abstraction level of current implementation
  
* **Feedback on Rules:**
  * Tag rule applications with abbreviations: [SF], [DRY], etc.
  * Explain reasoning when choosing between conflicting rules
  * Suggest rule improvements if patterns emerge
</ai_interaction>

<additional_notes>
## Additional Notes

* **Important Patterns/Architectural Principles:**
  * Repository pattern for data access
  * Command/Query Responsibility Segregation (CQRS)
  * Feature-based folder structure within modules
  * Atomic design principles for UI components
</additional_notes>
