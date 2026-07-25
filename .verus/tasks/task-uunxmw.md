---
id: uunxmw
title: "Phase 1: Theme Unification — Map VNL theme to Material"
status: in_progress
priority: high
createdAt: "2026-07-25T16:35:43+07:00"
updatedAt: "2026-07-25T17:06:22+07:00"
schemaVersion: 1
---

Replace vnl.ThemeData + vnl.Theme with Material ThemeData + ThemeExtension. Keep ALL VNL ColorScheme property names (background, foreground, muted, border...) and Typography names (h1, h2, large, normal...). Only add internal mapping to Material properties.

Deliverables:
1A. VNL ColorScheme extension mapping to Material ColorScheme (keep VNL property names)
1B. VNL Typography extension mapping to Material TextTheme (keep VNL property names)  
1C. VNLDensity mapping to Material VisualDensity
1D. Radius token getters as Material ThemeData extension
1E. VNLThemeExtension for surfaceOpacity/surfaceBlur/scaling
1F. Replace vnl.Theme widget with Material Theme + extension

Constraint: ZERO visual change. ZERO API change for consumers.

## Implementation Notes

## 2026-07-25
Spec: @doc/specs/migrate-material-core/migrate-vnl-to-material-core
All 5 phases planned (01-05 done). Plan-Complete Gate satisfied.
Phase 1 (Theme Unification) ready for implementation.

Phase 1 Steps (from 05--contract-phase):
1. Tạo VNLThemeExtension class
2. Tạo extension getter trên BuildContext
3. Tạo radius token extension trên material.ThemeData
4. Map VNL ColorScheme → Material
5. Map VNL Typography → Material
6. Map VNLDensity → Material VisualDensity
7. App root: MaterialApp với VNLThemeExtension
8. Export từ barrel
9. Verify: vnl_ui_docs compile + chạy

