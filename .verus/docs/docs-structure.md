---
title: "Verus Docs Structure"
description: "Canonical folder structure for Verus project documentation"
createdAt: "2026-07-25T16:14:22+07:00"
updatedAt: "2026-07-25T16:14:22+07:00"
---

# Verus Docs Structure

This file describes the canonical folder structure for all documentation in a Verus project (`.verus/docs/`).
Each folder has a specific purpose. Keep content in the correct folder to ensure agents can find information efficiently.

---

## Top-level Folders And Stores

```
.verus/docs/
├── overview/            Human-readable project summary: structure, features, workflows
├── knowledge-base/      Technical reference: architecture, workflows, API, gotchas, decisions
├── project-features/    Per-feature deep docs: overview, features, architectures
├── diagrams/            Standalone editable diagram docs
├── doc-html/            Standalone decision-support HTML pages — managed by vr-doc-html skill
├── specs/               Feature specification docs (SDD) — managed by vr-spec skill
├── architecture/        Long-form architecture guides and reference material
├── guides/              User/developer workflow guides
├── patterns/            Reusable implementation patterns
├── reviews/             Independent post-implementation review docs for task-only work — managed by vr-flow-review (VERIFY MODE)
└── proposals/           Harness evolution proposals — managed by vr-flow-evolve (RFC-style, user-reviewed)

.verus/tasks/            Task state: requirements, AC, plans, notes, lifecycle
.verus/templates/        Code-generation templates and template metadata
```

---

## overview/

Human-readable summaries of the project. Written for anyone (new dev, user, PM) to understand the project at a glance.
Managed by `vr-gen-overview` skill.

```
overview/
├── codebase-overview    What the project is, product lines, tech stack, repo identity
├── project-structure    Top-level dirs, module layout, entry points, key subsystems
├── architecture-map     Architecture diagram (Mermaid), layers, boundaries, dependency flow
├── use-cases            Main user-facing features, user stories, feature summary
├── feature-list         All features with short descriptions and entry points
├── main-workflows       High-level build/test/deploy/dev-setup workflows
├── api-reference        API endpoints, request/response formats, auth (if applicable)
└── external-libraries   Dependencies, why used, version constraints
```

**Purpose:** Breadth over depth. Pointers and summaries only — deep details go in `knowledge-base/` or `project-features/`.

---

## knowledge-base/

Lean, cross-cutting docs reused across the codebase. Each doc is focused and small.
Managed by `vr-gen-kb` and `vr-update-kb` skills.

```
knowledge-base/
├── 00_overview/
│   ├── project_overview        Project purpose, scope, main features, important links
│   ├── system_context          Actors (user/admin/system), use cases, business domain
│   └── glossary                Term definitions, abbreviations (token, session, sync…)
│
├── 01_architecture/
│   ├── architecture_overview   High-level system diagram, data flow, layer boundaries
│   ├── tech_stack              Languages, frameworks, key libraries, version notes
│   ├── module_breakdown        Module list, responsibilities, inter-module dependencies
│   ├── data_flow               Main data flow API→DB→UI, cache strategy
│   └── state_management        State strategy, single source of truth location
│
├── 02_workflows/
│   └── {name}_flow             One file per workflow (login_flow, sync_flow, background_task_flow…)
│                               Format per workflow doc:
│                               - Entry point (file/class)
│                               - Input
│                               - Step-by-step flow
│                               - Side effects
│                               - Related files
│                               - Common issues
│
├── 03_code_map/
│   ├── folder_structure        Explanation of each folder's role
│   ├── key_files               Important files and their roles
│   ├── dependency_graph        Which module calls which, circular dependencies
│   ├── naming_conventions      File/class/function naming rules
│   └── code_patterns           Patterns in use (Repository, Service, Manager…) + examples
│
├── 04_api/
│   ├── api_overview            Full API list grouped by domain
│   ├── {domain}_api            Per-domain API doc (auth_api, user_api, sync_api…)
│   └── error_handling          Error response format, retry strategy, timeout handling
│
├── 05_gotchas/
│   ├── common_bugs             Known bugs encountered + fixes
│   ├── edge_cases              Cases that fail easily
│   ├── performance_issues      Lag, memory leaks, bottlenecks
│   └── platform_issues         iOS/Android/OS lifecycle quirks
│
├── 06_decisions/
│   ├── architecture_decisions  Decision, reason, tradeoff
│   └── rejected_approaches     Tried-but-dropped solutions + reasons
│
├── 07_onboarding/
│   ├── setup_guide             How to set up the project from scratch
│   ├── dev_workflow            Git flow, CI/CD
│   ├── debug_guide             How to trace flows quickly, tools to use
│   └── faq                     Frequently asked questions for new devs
│
├── 08_testing/                 (add when project has tests)
│   ├── testing_strategy        Unit / Integration / UI test approach
│   ├── test_cases              Important test cases
│   └── mocking_guide           How to mock API / data
│
├── 09_release/                 (add when release process is defined)
│   ├── release_process         Release procedure
│   ├── versioning              Versioning rules
│   └── changelog               Change log
│
├── 10_security/                (add when project has auth/sensitive data)
│   ├── auth_flow               Token lifecycle
│   └── data_security           Encryption, sensitive data handling
│
├── 11_observability/           (add when project has monitoring)
│   ├── logging                 Log format, key log points
│   ├── monitoring              Metrics, alerts
│   └── crash_handling          Crash tracking, debugging production issues
│
└── 12_ai_context/              (optional — for AI-assisted projects)
    ├── prompts                 Prompt templates
    ├── embeddings              Chunk strategy, indexing rules
    └── ai_usage               How AI is used with this codebase
```

---

## project-features/

Per-feature docs with large, detailed content. Each feature gets its own subfolder with exactly 3 docs.
Managed by `vr-doc` skill (create) and `vr-update-kb` (update).

```
project-features/
└── {feature-name}/
    ├── overview        Summary, user stories, entry points, key classes/files
    ├── features        UI flow, all screens, navigation, UI states, components
    └── architectures   Business logic, data model, engine, patterns, API contracts, workflow
```

**Naming:** `{feature-name}` = kebab-case (e.g., `task-management`, `auth`, `kanban-board`).

---

## diagrams/

Standalone editable diagram docs. Use `vr-doc-diagram` for Excalidraw scene
docs, or `mermaidjs-v11` when the target doc explicitly needs Mermaid syntax.

```
diagrams/
└── {diagram-name}      One doc per diagram (e.g., system-architecture, data-flow, auth-sequence)
```

---

## doc-html/

Standalone self-contained `.html` pages generated to make tasks and specs easy
to read and decide on (approach comparison, implementation plan, status report,
incident report, code review…). Managed by `vr-doc-html` skill. These are plain
files written directly (NOT Verus docs — never via doc MCP).

```
doc-html/
└── {task-or-spec-slug}--{doc-type}.html   e.g. task-zopayo--status-report.html
```

---

## specs/

Feature specification docs (SDD). Managed by `vr-spec` skill. Do not manually create files here.

```
specs/
└── {feature-slug}/
    ├── {Feature Name}              Main spec (overview, scope, AC, progress table)
    ├── details/
    │   ├── 01--overview--spec      Problem, solution, scope, success metrics
    │   ├── 02--implementation-plan Phases, file changes, execution strategy
    │   ├── 03--requirements        Functional/Non-functional requirements, AC
    │   ├── 04--workflow-analysis   Current workflow, edge cases (for fix/improve)
    │   └── 05--scenarios           Given/When/Then test cases (for complex UX)
    ├── reports/                    Implementation report (vr-doc-report) + optional HTML review pages
    └── reviews/                    Independent reviews (vr-flow-review)
        ├── {date}--readiness-review   SPEC MODE — before implementation ("đủ chất lượng để code chưa?")
        └── {date}--verify-review      VERIFY MODE — after implementation ("code có đúng contract không?")
```

**Important:** All `@doc/` references must use the slugified path (lowercase, spaces→`-`, em-dash→`--`).
Example: `@doc/specs/my-feature/details/01--overview--spec` ✅
Never: `@doc/specs/my-feature/details/01 — Overview & Spec` ❌

---

## architecture/

Long-form architecture guides and reference material. Use when the content is
broader than one KB page and is meant to explain a system area in depth.

```
architecture/
└── {topic-name}
```

Examples: MCP protocols, search engine internals, Web UI architecture, template
engine architecture.

---

## guides/

User/developer workflow guides. Use when the content explains how to operate,
configure, or use Verus rather than documenting the target project internals.

```
guides/
└── {guide-name}
```

Examples: CLI reference, quick start, KB search strategy, release workflow.

---

## patterns/

Reusable implementation patterns. Use when a pattern can be applied across
multiple tasks or features. Mandatory implementation rules may also be captured
through the technical-template workflow when that skill is in use.

```
patterns/
└── {pattern-name}
```

---

## reviews/

Independent post-implementation review docs for task-only work. Written by
`vr-flow-review` (VERIFY MODE) when no spec slug is present — the contract is then the
task's `ImplementationPlan` + AC + `ImplementationNotes`. One doc per task; re-reviews
append to the same file so OPEN → FIXED transitions survive across review rounds.

Spec-backed reviews do NOT live here — they go to `specs/<slug>/reviews/`:
`<date>--readiness-review.md` (SPEC MODE, before implementation) and
`<date>--verify-review.md` (VERIFY MODE, after implementation).

```
reviews/
└── task-<id>--review.md    e.g. task-zopayo--review.md
```

---

## proposals/

Harness evolution proposals. Written by `vr-flow-evolve` when friction and audit data warrant a harness change.
Each proposal is an RFC-style doc reviewed and approved by the user before any change is applied.

```
proposals/
└── <yyyymmdd>--<component>--<short-description>.md    e.g. 20260613--budget-search--lower-limit.md
```

---

## Non-doc Stores

`.verus/tasks/` and `.verus/templates/` are not documentation folders.

| Store | Purpose | Managed by |
|-------|---------|------------|
| `.verus/tasks/` | Task state: requirements, AC, plans, notes, lifecycle | `vr-flow-task`, `vr-flow-post-report` |
| `.verus/templates/` | Code-generation templates and metadata | `vr-doc-template` |

---

## Skill Mapping

| Folder | Purpose | Created/Updated by |
|--------|---------|-------------------|
| `overview/` | Human-readable project summary | `vr-gen-overview` |
| `knowledge-base/` | Technical reference, grep-first | `vr-gen-kb`, `vr-update-kb` |
| `project-features/` | Per-feature deep docs | `vr-doc` (create), `vr-update-kb` (update) |
| `diagrams/` | Standalone editable diagrams | `vr-doc`, `vr-diagram` |
| `doc-html/` | Decision-support HTML pages | `vr-doc-html` |
| `specs/` | Feature specifications (SDD) | `vr-spec` |
| `architecture/` | Long-form architecture guides | `vr-doc` |
| `guides/` | User/developer workflow guides | `vr-doc` |
| `patterns/` | Reusable implementation patterns | `vr-doc`, `vr-doc-tech` when mandatory |
| `reviews/` | Post-implementation review docs for task-only work | `vr-flow-review` (VERIFY MODE) |
| `proposals/` | Harness evolution proposals (RFC-style) | `vr-flow-evolve` |
| `.verus/tasks/` | Task state | `vr-flow-task`, `vr-flow-post-report` |
| `.verus/templates/` | Code-generation templates | `vr-doc-template` |
