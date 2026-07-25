---
id: 0ikxql
title: "Phase 5: Cleanup — remove dead code, verify, document"
status: todo
priority: medium
createdAt: "2026-07-25T16:36:05+07:00"
updatedAt: "2026-07-25T16:36:05+07:00"
---

Remove all dead code after migration. Run full regression test. Update docs.

Deliverables:
5A. Remove deprecated classes: VNLButtonVariance, VNLButtonStyle, VNLAbstractButtonStyle, VNLWidgetStatesProvider, VNLStatedWidget, ControlledComponent, ControlledComponentAdapter, VNLDividerPainter, VNLSurfaceBarrierPainter, VNLCheckboxPainter, custom state animation in VNLClickable
5B. Clean shadcn_flutter.dart barrel: remove all hide directives for Flutter widgets
5C. Run vnl_ui_docs full screenshot regression (desktop + mobile, dark + light)
5D. Accessibility test (screen reader, keyboard nav)
5E. Update vnl_guide/components_guide.md
5F. Mark deprecated VNL classes with @Deprecated if any must remain

Depends on: Phase 4 (all migration done)
Constraint: All visual regression tests pass. Zero breaking change to consumer API.

