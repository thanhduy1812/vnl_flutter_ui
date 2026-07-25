Task: @task-uunxmw @task-zg7ssl @task-b31mzy @task-og9bsk @task-0ikxql

# Migrate VNL to Material Core

**Type:** Improvement
**Status:** planned
**Linked Tasks:** @task-uunxmw (Phase 1), @task-zg7ssl (Phase 2), @task-b31mzy (Phase 3), @task-og9bsk (Phase 4), @task-0ikxql (Phase 5)

## Problem
`vnl_common_ui` hiện có ~180+ custom widget build từ low-level primitive (GestureDetector, AnimatedContainer, CustomPaint) thay vì subclass/extend Material widget của Flutter. Hệ thống theme riêng (`vnl.ThemeData`, `vnl.ColorScheme`, `vnl.Typography`) shadow toàn bộ Material theme. Chỉ 1 component (VNLCircularProgressIndicator) wrap Material widget bên trong. Điều này tạo ra một UI kit độc lập thay vì một design system shadcn-style base trên Material.

## Solution
Refactor toàn bộ `vnl_common_ui` để dùng Flutter Material widget làm core. VNL component trở thành style wrapper mỏng (shadcn design system) — giữ nguyên VNL class name + constructor API, chỉ thay internal build method. VNL ColorScheme + Typography giữ nguyên tên design token, map nội bộ sang Material property.

## Scope
- In: Toàn bộ `lib/src/theme/`, `lib/src/components/`, barrel `lib/shadcn_flutter.dart`
- Out: `base_app` consumer code (không đổi), `vnl_ui_docs` (chỉ verify), external API của `vnl_common_ui`

## Spec Progress

| Section | Acceptance Criteria | Tasks | Doc |
|---------|---------------------|-------|-----|
| Overview & Spec | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/00--overview-spec |
| Requirements | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/01--requirements |
| Codebase Analysis | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/02--codebase-analysis |
| Solution Analysis | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/03--solution-analysis |
| Contract — Plan | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/04--contract-plan |
| Contract — Phase | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/05--contract-phase |
| Contract — Verify | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/06--contract-verify |
| Scenarios | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/07--scenarios |
| Contract — Fix | 0/0 | 0/0 | @doc/specs/migrate-material-core/details/08--contract-fix |

## Acceptance Criteria
- [ ] Tất cả VNL component giữ nguyên class name + constructor API
- [ ] VNL ColorScheme + Typography giữ nguyên tên design token
- [ ] Zero visual regression trên `vnl_ui_docs` (desktop + mobile, light + dark)
- [ ] `shadcn_flutter.dart` không còn hide Flutter Material widget
- [ ] Material widget là core, VNL component là style wrapper mỏng

## Details
- @doc/specs/migrate-material-core/details/00--overview-spec — Overview, summary, section index
- @doc/specs/migrate-material-core/details/01--requirements — Functional/Non-Functional Requirements, Acceptance Criteria
- @doc/specs/migrate-material-core/details/02--codebase-analysis — Current state: current logic/workflow, file:line trace
- @doc/specs/migrate-material-core/details/03--solution-analysis — New requirement design: Goal + Approach + Impacts & Risks + Open Questions
- @doc/specs/migrate-material-core/details/04--contract-plan — Locked technical contract: symbol tables, evidence, test cases
- @doc/specs/migrate-material-core/details/05--contract-phase — Detailed numbered phase plan
- @doc/specs/migrate-material-core/details/06--contract-verify — Verify vs contract-phase, % complete
- @doc/specs/migrate-material-core/details/07--scenarios — Test-case scenario results
- @doc/specs/migrate-material-core/details/08--contract-fix — Bugs missed + fixes

- [x] Làm rõ approach: Mỗi phase merge riêng, tuần tự Phase 1 → 2 → 3 → 4 → 5


## Next Action
Implement Phase 1 (@task-uunxmw)
