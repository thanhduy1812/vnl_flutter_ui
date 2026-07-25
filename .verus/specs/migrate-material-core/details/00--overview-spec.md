Task: @task-uunxmw
Spec: @doc/specs/migrate-material-core/migrate-vnl-to-material-core

# Migrate VNL to Material Core — Overview & Spec

## Summary

* Type: Improvement
* Status: planning
* Problem: 180+ custom widget build từ primitive thay vì subclass Material. Theme riêng shadow Material.
* Solution: Material widget làm core, VNL component thành style wrapper. Giữ nguyên design token name.
* Scope — In: toàn bộ `lib/src/theme/`, `lib/src/components/`, barrel
* Scope — Out: `base_app` consumer code, external API

## Acceptance Criteria (aggregate)

- [ ] Tất cả VNL component giữ nguyên class name + constructor API
- [ ] VNL ColorScheme + Typography giữ nguyên tên property
- [ ] Zero visual regression trên `vnl_ui_docs`
- [ ] Barrel không còn hide Flutter widget
- [ ] Material widget là core của mọi VNL component

## Section Index

| #  | Section                              | File                        |
|----|--------------------------------------|-----------------------------|
| 01 | Requirements                         | `01--requirements`          |
| 02 | Codebase Analysis (current state)    | `02--codebase-analysis`     |
| 03 | Solution Analysis (goal/how/impacts) | `03--solution-analysis`     |
| 04 | Contract — Plan (technical + tests)  | `04--contract-plan`         |
| 05 | Contract — Phase (detailed plan)     | `05--contract-phase`        |
| 06 | Contract — Verify (vs phase)         | `06--contract-verify`       |
| 07 | Scenarios (test-case verification)   | `07--scenarios`             |
| 08 | Contract — Fix (bugs + retrospective)| `08--contract-fix`          |

## Report

The synthesized implementation report is built by `vr-doc-report` from sections
00–08 into `specs/migrate-material-core/reports/`.
