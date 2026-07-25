---
id: b31mzy
title: "Phase 3: Core Form Controls — migrate to Material widgets"
status: todo
priority: high
createdAt: "2026-07-25T16:36:05+07:00"
updatedAt: "2026-07-25T16:36:05+07:00"
---

Replace custom-built form controls with Material equivalents. Keep ALL VNL class names + constructor APIs. Only change internal build methods.

Deliverables:
3A. VNLTextField → wrap material.TextField with custom InputDecoration
3B. VNLSwitch → wrap material.Switch  
3C. VNLCheckbox → wrap material.Checkbox (tristate: true)
3D. VNLRadio → wrap material.Radio
3E. VNLSlider → wrap material.Slider / material.RangeSlider
3F. VNLChip → wrap material.FilterChip / InputChip
3G. VNLBadge (4 variants) → wrap material.Badge
3H. VNLTooltip → wrap material.Tooltip
3I. VNLDatePicker/VNLCalendar → wrap material.showDatePicker
3J. VNLTimePicker → wrap material.showTimePicker
3K. VNLLinearProgressIndicator → wrap material.LinearProgressIndicator
3L. VNLStarRating, VNLColorPicker, VNLInputOTP → giữ nguyên (Material không có)

Depends on: Phase 2 (VNLClickable → InkWell must be done first, VNLChip+VNLBadge depend on VNLButton)
Constraint: ZERO visual change. All form validation + submit works.

