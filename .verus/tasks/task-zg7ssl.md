---
id: zg7ssl
title: "Phase 2: VNLClickable → InkWell wrapper"
status: todo
priority: high
createdAt: "2026-07-25T16:36:05+07:00"
updatedAt: "2026-07-25T16:36:05+07:00"
---

Refactor VNLClickable to use Material InkWell internally instead of GestureDetector + FocusableActionDetector + AnimatedContainer. Map VNLButtonStyle/VNLButtonVariance to Material ButtonStyle. Keep VNLClickable + VNLButton API unchanged.

Deliverables:
2A. VNLClickable wraps InkWell, keeps all callback APIs
2B. VNLButtonVariance → Material ButtonStyle adapter (primary→FilledButton, secondary→FilledTonal, outline→OutlinedButton, ghost/link/text→TextButton, destructive→FilledButton error)
2C. VNLButton build uses Material buttons via adapter
2D. Remove custom WidgetState management, use MaterialStateProperty

Depends on: Phase 1 (theme must be Material-based first)
Constraint: ZERO visual change on all button variants + states. Ripple effect is acceptable.

