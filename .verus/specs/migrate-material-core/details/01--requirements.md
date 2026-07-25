Task: @task-uunxmw
Spec: @doc/specs/migrate-material-core/migrate-vnl-to-material-core
Status: in-review

# 01 — Requirements

## Grounding (⛔ GATE — before the Readback below)

| Requirement line (from task `description`) | What it asks for |
|--------------------------------------------|------------------|
| "Replace vnl.ThemeData + vnl.Theme with Material ThemeData + ThemeExtension" | Theme system dùng Material core, VNL chỉ là extension |
| "Keep ALL VNL ColorScheme property names (background, foreground, muted, border...)" | Tên property giữ nguyên, chỉ map nội bộ sang Material |
| "Keep ALL Typography names (h1, h2, large, normal...)" | Tên giữ nguyên |
| "Only add internal mapping to Material properties" | Không đổi API public |
| "ZERO visual change. ZERO API change for consumers" | Không regression |
| User: "material của flutter làm core, custom và extend là hợp lý nhất" | Material widget là nền tảng, VNL extends/style wraps |
| User: "cover đầy đủ tránh bị thay đổi UI đã build" | Full migration, không bỏ sót |
| User: "localize và theme nên xử lý đồng bộ" | Dùng Material l10n + ThemeData |
| User: "shadcn style chứ không phải bộ UI Kit riêng" | Design system, không phải custom UI kit |
| User: "chấp nhận update sửa nếu flutter update material" | Theo sát Material API của Flutter |

| Grounded fact | Source |
|---------------|--------|
| Product: vnl_common_ui — Flutter shadcn-style design system library, ~223 custom widgets | `vnl_common_ui/custom_widgets.txt` |
| Core: VNL ThemeData/Theme shadow Material; VNLClickable base interactive; VNLButton 212KB backbone | `lib/src/theme/theme.dart:148`, `lib/src/components/control/clickable.dart:487`, `lib/src/components/control/button.dart:659` |
| Barrel hides Material widgets: Flexible, Expanded, Row, Column, Form, Table... | `lib/shadcn_flutter.dart:24-42` |
| Chỉ 1 component dùng Material: VNLCircularProgressIndicator wrap mat.CircularProgressIndicator | `lib/src/components/display/circular_progress_indicator.dart:246` |
| Pattern: GestureDetector + AnimatedContainer thay InkWell; CustomPaint thay Material widget | `lib/src/components/form/switch.dart:394-474`, `lib/src/components/display/divider.dart:328-351` |
| Consumer: base_app dùng package:vnl_common_ui/vnl_ui.dart | `base_app/page_rule.md:3` |
| VNL ColorScheme property: background, foreground, primary, muted, border, destructive... | `lib/src/theme/color_scheme.dart` |
| VNL Typography property: h1, h2, h3, h4, large, normal, small, xSmall, mono | `lib/src/theme/typography.dart` |
| Localization dùng flutter_localizations + GlobalMaterialLocalizations.delegate | `lib/src/components/locale/shadcn_localizations.dart:86-92` |

## Requirement Readback (⛔ STOP-GATE — CONFIRMED by user 2026-07-25)

- **My understanding:** Refactor toàn bộ vnl_common_ui để Material widget của Flutter làm core. 3 lớp: (1) Theme — VNL ThemeData/ColorScheme/Typography giữ nguyên tên property, map nội bộ sang Material; (2) VNLClickable → InkWell wrapper; (3) 180+ component → style wrapper của Material widget tương ứng. Component không có Material equivalent giữ nguyên.
- **Concrete outcome:** vnl_common_ui compile với material.ThemeData, mọi VNL component dùng Material widget bên trong, barrel không hide Material widget. vnl_ui_docs chạy không visual regression.
- **Blocking questions:** Đã resolve — (1) dùng InkWell với ripple effect; (2) component không có Material equivalent giữ nguyên.

## Requirement Understanding

* **Core Business Logic:** vnl_common_ui là design system shadcn-style. Hiện tại tự build toàn bộ widget + theme từ primitive (GestureDetector, CustomPaint...), không dùng Material. Cần migrate để Material là core, VNL component thành style wrapper mỏng. Design token (ColorScheme property name, Typography property name) giữ nguyên — đây là ngôn ngữ thiết kế của team, không phải implementation detail.

* **Scope — In:**
  - `lib/src/theme/` — VNL ThemeData, ColorScheme, Typography, VNLDensity, radius tokens
  - `lib/src/components/control/` — VNLClickable, VNLButton + variants, VNLScrollbar
  - `lib/src/components/form/` — VNLTextField, VNLSwitch, VNLCheckbox, VNLRadio, VNLSlider, VNLDatePicker, VNLTimePicker, VNLChip, VNLTooltip
  - `lib/src/components/display/` — VNLCircularProgressIndicator (giữ), VNLLinearProgressIndicator, VNLDivider, VNLAvatar, VNLBadge, VNLChip
  - `lib/src/components/layout/` — VNLCard, VNLSurfaceCard, VNLScaffold, VNLAppBar, VNLStepper, VNLAccordion, VNLCollapsible, VNLAlertDialog
  - `lib/src/components/navigation/` — VNLNavigationBar, VNLTabs, VNLPagination, VNLDropdownMenu, VNLContextMenu
  - `lib/src/components/overlay/` — VNLTooltip, VNLAlertDialog, VNLDrawer, VNLToast
  - `lib/shadcn_flutter.dart` — xóa hide directives, giữ export

* **Scope — Out:**
  - Consumer code trong `base_app/` (không đổi API)
  - Component không có Material equivalent: `VNLColorPicker`, `VNLInputOTP`, `VNLStarRating`, `VNLWindowWidget`, `VNLResizableTable`, `VNLSortableLayer`, `VNLForm` system, `VNLCarousel`, `VNLCommand`
  - `vnl_ui_docs` (chỉ dùng để verify, không sửa)

* **Assumptions & Open Questions:**
  - Ripple effect của InkWell acceptable (confirmed)
  - Không có Open Question còn tồn tại

## Functional Requirements

- FR1: VNL `ColorScheme` class giữ nguyên tất cả property name, thêm extension method map sang `material.ColorScheme`
- FR2: VNL `Typography` class giữ nguyên tất cả property name (h1, h2, h3, h4, large, normal, small, xSmall, mono), map sang `material.TextTheme`
- FR3: `vnl.ThemeData` và `vnl.Theme` widget bị xóa, thay bằng `material.ThemeData` + `VNLThemeExtension`
- FR4: `VNLClickable` build method dùng `InkWell` thay `GestureDetector` + `FocusableActionDetector`
- FR5: `VNLButton` dùng Material button (FilledButton, FilledTonalButton, OutlinedButton, TextButton) thay custom VNLClickable
- FR6: Tất cả form control (Switch, Checkbox, Radio, Slider) dùng Material widget tương ứng bên trong
- FR7: Tất cả display/layout/nav/overlay component dùng Material widget tương ứng bên trong
- FR8: Barrel `shadcn_flutter.dart` không còn `hide` Flutter Material widget
- FR9: Mọi VNL class name + constructor API giữ nguyên — chỉ internal build method thay đổi
- FR10: `VNLookLocalizations` tiếp tục dùng `GlobalMaterialLocalizations.delegate`

## Non-Functional Requirements

- NFR1: Zero visual regression trên `vnl_ui_docs` (desktop + mobile, light + dark)
- NFR2: Zero breaking change API cho `base_app` consumer
- NFR3: Performance không degrade — Material widget được optimize bởi Flutter team
- NFR4: Accessibility giữ nguyên hoặc tốt hơn (Material widget có a11y built-in)

## Acceptance Criteria

- [ ] AC1: `Theme.of(context)` trả về `material.ThemeData`, VNL token access qua `Theme.of(context).extension<VNLThemeExtension>()`
- [ ] AC2: `colorScheme.background`, `colorScheme.muted`, `colorScheme.border`... vẫn compile
- [ ] AC3: `typography.h1`, `typography.large`, `typography.normal`... vẫn compile
- [ ] AC4: `VNLClickable` build dùng `InkWell`, ripple effect hiển thị
- [ ] AC5: Tất cả VNLButton variant (primary/secondary/outline/ghost/link/destructive) hiển thị giống hệt
- [ ] AC6: VNLSwitch, VNLCheckbox, VNLRadio, VNLSlider hiển thị giống hệt
- [ ] AC7: VNLDivider, VNLCard, VNLBadge, VNLAvatar hiển thị giống hệt
- [ ] AC8: VNLScaffold, VNLNavigationBar, VNLTabs hiển thị giống hệt
- [ ] AC9: VNLAlertDialog, VNLTooltip, VNLDropdownMenu hiển thị giống hệt
- [ ] AC10: Barrel `shadcn_flutter.dart` không hide Material widget, `import 'package:flutter/material.dart'` hoạt động bình thường
- [ ] AC11: `vnl_ui_docs` app chạy trên desktop + mobile, light + dark, không visual regression

## AC Alignment

| AC | Maps to FR | Verify method |
|----|-----------|---------------|
| AC1–AC3 | FR1–FR3 | Compile check + runtime Theme access |
| AC4 | FR4 | Visual: InkWell ripple on click |
| AC5 | FR5 | Visual: screenshot diff từng variant |
| AC6 | FR6 | Visual: screenshot diff form controls |
| AC7–AC9 | FR7 | Visual: screenshot diff display/layout/nav/overlay |
| AC10 | FR8 | Static: grep `hide` trong barrel |
| AC11 | FR9, NFR1 | Runtime: chạy vnl_ui_docs, screenshot compare |

## AC Feasibility Check

| AC | Needs capability | Exists in code? (`file:line`) | Verdict |
|----|------------------|-------------------------------|---------|
| AC1–AC3 | Material ThemeData + ThemeExtension | Flutter SDK — luôn có | OK |
| AC4 | InkWell với WidgetStateProperty | Flutter SDK — luôn có | OK |
| AC5 | FilledButton, FilledTonalButton, OutlinedButton, TextButton | Flutter SDK — luôn có | OK |
| AC6 | Switch, Checkbox, Radio, Slider, RangeSlider | Flutter SDK — luôn có | OK |
| AC7 | Divider, Card, Badge, CircleAvatar | Flutter SDK — luôn có | OK |
| AC8 | Scaffold, AppBar, NavigationBar, TabBar | Flutter SDK — luôn có | OK |
| AC9 | AlertDialog, Tooltip, DropdownMenu, showMenu | Flutter SDK — luôn có | OK |
| AC10 | — | Static check | OK |

## Business Behavior Matrix (S1)

> Migration này là internal refactor — không thay đổi business behavior. Tất cả target giữ nguyên hành vi.

| Action × target | Business meaning | Allowed? | API/owner · feedback · persist |
|-----------------|------------------|----------|--------------------------------|
| Consumer gọi VNLButton.primary(onPressed: ...) | Button hiển thị + fire callback | Yes | VNLButton API không đổi; internal dùng FilledButton |
| Consumer gọi Theme.of(context).colorScheme.background | Trả về màu background | Yes | Map từ material.ColorScheme.surface |
| Consumer gọi typography.h1 | Trả về TextStyle displayLarge | Yes | Map từ material.TextTheme.displayLarge |
| Consumer import package:vnl_common_ui/vnl_ui.dart | Import toàn bộ VNL + Material | Yes | Barrel không hide Material nữa |

## Requirements Completeness Matrix (S1)

> Internal refactor — tập trung vào coverage các component cần migrate.

| Case / axis enumerated | Covered? | Evidence | Gap | Owner decision? |
|------------------------|----------|----------|-----|-----------------|
| Tất cả component trong custom_widgets.txt (223 widgets) | Yes | `vnl_common_ui/custom_widgets.txt` | Component không có Material equivalent → giữ nguyên | User confirmed |
| Theme token mapping (ColorScheme ~20 property) | Yes | `lib/src/theme/color_scheme.dart` | — | — |
| Typography mapping (9 property) | Yes | `lib/src/theme/typography.dart` | — | — |
| VNLDensity mapping | Yes | `lib/src/theme/density.dart` | — | — |
| Radius token (6 mức) | Yes | `lib/src/theme/theme.dart:241-292` | — | — |
| Light + Dark mode | Yes | `ThemeData` + `ThemeData.dark` constructor | — | — |
| Desktop + Mobile scaling | Yes | `AdaptiveScaling` class | — | — |
| Localization (EN) | Yes | `lib/src/components/locale/shadcn_localizations.dart` | — | — |
| Form validation system | Yes | `lib/src/components/form/form.dart` (103KB) | Form system dùng VNL internal — giữ nguyên | — |
