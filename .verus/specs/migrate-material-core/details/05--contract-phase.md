Task: @task-uunxmw
Spec: @doc/specs/migrate-material-core/migrate-vnl-to-material-core
Status: done

# 05 — Contract: Phase

## Phase 1 — Theme Unification

**Status:** planned

### Plan (stable contract)
* **Goal:** Theme.of(context) trả về material.ThemeData. VNL token (ColorScheme, Typography, density, radius) access qua VNLThemeExtension + extension getter. Theme cũ vẫn tồn tại song song.
* **Impact / Risk:** `theme/color_scheme.dart`, `theme/typography.dart`, `theme/density.dart`, `theme/theme.dart`, `shadcn_flutter.dart`. Risk: map color sai → visual drift toàn bộ app. Mitigate: map từng property, verify screenshot.
* **Invariants touched:** I1, I2, I3
* **Rollback:** Revert commit — additive phase, chưa xóa gì

* **Steps (detailed):**

  | # | Step | Precondition | Action (`file:line`) | Postcondition / output | On error |
  |---|------|--------------|----------------------|------------------------|----------|
  | 1 | Tạo VNLThemeExtension class | Phase 1 bắt đầu | Tạo file mới `lib/src/theme/theme_extension.dart` với class `VNLThemeExtension extends ThemeExtension` chứa `ColorScheme`, `Typography`, `scaling`, `surfaceOpacity`, `surfaceBlur`, `density` | Compile: class tồn tại, có đủ field | Abort |
  | 2 | Tạo extension getter trên BuildContext | — | Thêm `extension VNLThemeAccess on BuildContext` → getter `vnlTheme` trả về `VNLThemeExtension` | `context.vnlTheme.colorScheme.background` compile | Abort |
  | 3 | Tạo radius token extension trên material.ThemeData | — | Thêm `extension VNLRadiusToken on material.ThemeData` → getter `radiusMd`, `borderRadiusMd`, `radiusLg`, `borderRadiusLg`... tính từ Material property | `theme.radiusMd` compile (qua extension) | Abort |
  | 4 | Map VNL ColorScheme → Material: tạo internal mapping | Đã có VNL ColorScheme class | Thêm internal extension method map từng VNL property → Material property (background→surface, muted→surfaceContainerHighest...) | Mọi VNL property có Material equivalent | Abort — fallback về giá trị cũ |
  | 5 | Map VNL Typography → Material: tạo internal mapping | Đã có VNL Typography class | Thêm internal extension method map từng VNL property → Material TextTheme (h1→displayLarge, large→titleLarge...) | Mọi VNL property có Material equivalent | Abort |
  | 6 | Map VNLDensity → Material VisualDensity | Đã có VNLDensity class | Map baseGap/baseContentPadding/baseContainerPadding sang VisualDensity + extension getter | VNLDensity value access được qua Material | Abort |
  | 7 | App root: dùng MaterialApp với VNLThemeExtension | Đã có MaterialApp trong app | Thêm `VNLThemeExtension` vào `ThemeData.extensions` của MaterialApp theme | Runtime: `Theme.of(context).extension<VNLThemeExtension>()` trả về non-null | Abort |
  | 8 | Export VNLThemeExtension + extension từ barrel | Barrel đã export theme | Thêm export vào `shadcn_flutter.dart` | Import được từ package | Abort |
  | 9 | Verify: vnl_ui_docs compile + chạy, theme access đúng | Các step trên hoàn tất | Chạy `flutter build` vnl_ui_docs; test runtime Theme access | Không compile error; theme color đúng | Fix + retry |

* **Done Criteria:**
  - `Theme.of(context)` trả về `material.ThemeData`
  - `context.vnlTheme.colorScheme.background` trả về đúng màu
  - `context.vnlTheme.typography.h1` trả về đúng TextStyle
  - `theme.radiusMd` hoạt động
  - vnl_ui_docs compile + chạy không crash
  - VNL ThemeData cũ vẫn tồn tại (chưa xóa)

### Post-Report (fill after implementing this phase)
* **Files / Symbols Changed:** (điền sau khi implement)
* **Implemented Changes:**
* **Removed / Superseded:**
* **Behavior Change:**
* **Preserved Behavior:**
* **Verification Done:**
* **Remaining / Pending:**

### ⛔ Next-Phase Gate — [MANDATORY]
* **QC Verdict:** (filled by vr-flow-qc)

---

## Phase 2 — VNLClickable → InkWell + VNLButton → Material

**Status:** planned

### Plan (stable contract)
* **Goal:** VNLClickable build dùng InkWell. VNLButton build dùng Material button (FilledButton/FilledTonalButton/OutlinedButton/TextButton). Tất cả button variant visual match.
* **Impact / Risk:** `control/clickable.dart`, `control/button.dart`, ~30 component dùng VNLButton. Risk: button style map không khớp, thiếu state animation. Mitigate: map từng variant + state, screenshot diff.
* **Invariants touched:** I3, I4
* **Rollback:** Revert commit

* **Steps (detailed):**

  | # | Step | Precondition | Action | Postcondition | On error |
  |---|------|--------------|--------|---------------|----------|
  | 1 | Tạo VNLButtonStyleAdapter | Phase 1 done | Tạo adapter function `_toMaterialButtonStyle(VNLAbstractButtonStyle)` → `material.ButtonStyle` | Mọi VNLButtonVariance map được sang Material | Abort |
  | 2 | Map từng VNLButtonVariance variant | Adapter tồn tại | Map primary→FilledButton, secondary→FilledTonalButton, outline→OutlinedButton, ghost→TextButton, link→TextButton(underline), destructive→FilledButton(error), text→TextButton, muted→TextButton | Đủ 8 variant map | Fix từng variant |
  | 3 | Map state colors (hover/press/focus/disabled) | Variant map xong | Mỗi variant: backgroundColor, foregroundColor, overlayColor, side cho từng MaterialState | Hover/press/focus/disabled hiển thị đúng màu | Fix từng state |
  | 4 | Refactor VNLClickable.build → InkWell | Variant map xong | `_ClickableState.build()`: thay GestureDetector+FocusableActionDetector bằng InkWell; xóa WidgetStatesController tự build | InkWell ripple hoạt động | Abort — revert về GestureDetector |
  | 5 | Refactor VNLButton.build → Material buttons | VNLClickable dùng InkWell | `ButtonState.build()`: resolve style → gọi `_toMaterialButtonStyle()` → build FilledButton/OutlinedButton/TextButton theo variant | Button compile + chạy | Abort |
  | 6 | Giữ VNLButtonStyle/VNLButtonVariance API | Button build xong | VNLButtonStyle + VNLButtonVariance class vẫn tồn tại làm input, nhưng build dùng Material | Consumer code VNLButtonStyle.primary() vẫn compile | Abort |
  | 7 | Verify: screenshot diff từng variant + state | Các step trên hoàn tất | Chụp screenshot từng VNLButton variant (primary/secondary/outline/ghost/link/destructive/text/muted) × từng state (normal/hover/press/focus/disabled) trên desktop + mobile, light + dark | Không visual diff (trừ ripple) | Fix style map |

* **Done Criteria:**
  - Tất cả VNLButton variant compile
  - Tất cả VNLButton variant hiển thị giống hệt trước migrate (trừ ripple)
  - Hover/press/focus/disabled state hoạt động
  - Ripple effect hiển thị khi click
  - Keyboard Enter/Space hoạt động
  - Component dùng VNLButton (Chip, Badge, Toggle...) vẫn compile

### Post-Report (fill after implementing this phase)
* **Files / Symbols Changed:**
* **Implemented Changes:**
* **Removed / Superseded:**
* **Behavior Change:**
* **Preserved Behavior:**
* **Verification Done:**
* **Remaining / Pending:**

### ⛔ Next-Phase Gate — [MANDATORY]
* **QC Verdict:** (filled by vr-flow-qc)

---

## Phase 3 — Form Controls → Material

**Status:** planned

### Plan (stable contract)
* **Goal:** Tất cả form control wrap Material widget tương ứng bên trong. API public không đổi. Form validation giữ nguyên.
* **Impact / Risk:** `form/switch.dart`, `form/checkbox.dart`, `form/multiple_choice.dart`, `form/slider.dart`, `form/text_field.dart`, `display/chip.dart`, `display/badge.dart`, `overlay/tooltip.dart`, `display/linear_progress_indicator.dart`, `form/date_picker.dart`, `form/time_picker.dart`. Risk: form control behavior khác Material → validation bị ảnh hưởng. Mitigate: giữ VNL form system, chỉ đổi internal widget.
* **Invariants touched:** I3, I4
* **Rollback:** Revert commit

* **Steps (detailed):**

  | # | Step | Precondition | Action | Postcondition | On error |
  |---|------|--------------|--------|---------------|----------|
  | 1 | VNLSwitch → material.Switch | Phase 2 done | `_SwitchState.build()`: thay AnimatedContainer bằng `material.Switch(value:, onChanged:, activeColor:, inactiveThumbColor:, inactiveTrackColor:)` | Switch compile + toggle hoạt động | Abort |
  | 2 | Map VNLSwitchTheme → SwitchThemeData | Switch build xong | Map activeColor/inactiveColor/activeThumbColor/inactiveThumbColor từ VNLSwitchTheme sang material.SwitchThemeData | Theme color map đúng | Fix map |
  | 3 | VNLCheckbox → material.Checkbox | — | Thay custom painter bằng `material.Checkbox(value:, onChanged:, tristate: true)`. Map VNLCheckboxState → bool? | Checkbox compile + check/uncheck/indeterminate hoạt động | Abort |
  | 4 | VNLRadio → material.Radio | — | Thay custom radio bằng `material.Radio(value:, groupValue:, onChanged:)` | Radio compile + select hoạt động | Abort |
  | 5 | VNLSlider → material.Slider/RangeSlider | — | `VNLSlider.single` → `material.Slider`. `VNLSlider.range` → `material.RangeSlider`. Map VNLSliderTheme → SliderThemeData | Slider compile + drag hoạt động | Abort |
  | 6 | VNLTextField → giữ EditableText, map InputDecoration | — | Giữ EditableText nội bộ. Map VNLTextFieldTheme (border, borderRadius, filled, padding) → material.InputDecoration. Style map sang Material TextField style | TextField compile + nhập text hoạt động | Abort |
  | 7 | VNLTooltip → material.Tooltip | — | Thay custom overlay bằng `material.Tooltip(message:, child:)` | Tooltip compile + hover hiển thị | Abort |
  | 8 | VNLChip → material.FilterChip | — | `VNLChip.build()`: thay VNLButton bằng `material.FilterChip(onSelected:, label:, avatar:, deleteIcon:)` | Chip compile + select hoạt động | Abort |
  | 9 | VNLBadge → material.Badge | — | Thay VNLButton wrapper bằng `material.Badge(label:, child:)` | Badge compile + hiển thị đúng | Abort |
  | 10 | VNLLinearProgressIndicator → material.LinearProgressIndicator | — | Thay custom bằng `material.LinearProgressIndicator(value:, color:, backgroundColor:)` | Progress compile + animate | Abort |
  | 11 | VNLDatePicker → material.showDatePicker | — | Thay custom calendar bằng `material.showDatePicker()`. Map theme sang DatePickerThemeData | DatePicker compile + chọn ngày hoạt động | Abort |
  | 12 | VNLTimePicker → material.showTimePicker | — | Thay custom bằng `material.showTimePicker()` | TimePicker compile + chọn giờ hoạt động | Abort |
  | 13 | Verify: screenshot diff từng control | Các step trên hoàn tất | Chụp screenshot từng form control trên desktop + mobile, light + dark | Không visual diff | Fix style map |

* **Done Criteria:**
  - Tất cả form control compile
  - Tất cả form control hiển thị giống hệt trước migrate
  - VNLForm validation vẫn hoạt động
  - Keyboard navigation hoạt động
  - Accessibility không regression

### Post-Report (fill after implementing this phase)
* **Files / Symbols Changed:**
* **Implemented Changes:**
* **Removed / Superseded:**
* **Behavior Change:**
* **Preserved Behavior:**
* **Verification Done:**
* **Remaining / Pending:**

### ⛔ Next-Phase Gate — [MANDATORY]
* **QC Verdict:** (filled by vr-flow-qc)

---

## Phase 4 — Layout, Navigation, Overlay → Material

**Status:** planned

### Plan (stable contract)
* **Goal:** Layout/nav/overlay component wrap Material widget. Navigation API giữ nguyên.
* **Impact / Risk:** `display/divider.dart`, `layout/card.dart`, `layout/scaffold.dart`, `navigation/*`, `overlay/dialog.dart`, `menu/*`, `layout/stepper.dart`, `layout/accordion.dart`. Risk: Material NavBar/Tabs API khác VNL. Mitigate: adapter dày hơn.
* **Invariants touched:** I3, I4
* **Rollback:** Revert commit

* **Steps (detailed):**

  | # | Step | Precondition | Action | Postcondition | On error |
  |---|------|--------------|--------|---------------|----------|
  | 1 | VNLDivider/VNLVerticalDivider → material.Divider/VerticalDivider | Phase 3 done | Thay CustomPaint bằng material.Divider. Map VNLDividerTheme → DividerThemeData | Divider compile + hiển thị đúng | Abort |
  | 2 | VNLCard/VNLSurfaceCard → material.Card | — | Thay custom bằng material.Card. Map VNLCardTheme → CardThemeData. Surface blur qua BackdropFilter nếu cần | Card compile + hiển thị đúng | Abort |
  | 3 | VNLScaffold/VNLAppBar → material.Scaffold/AppBar | — | Thay custom bằng material.Scaffold. Map VNLScaffoldTheme → ScaffoldBackgroundColor + AppBarTheme | Scaffold compile + layout đúng | Abort |
  | 4 | VNLNavigationBar → material.NavigationBar/NavigationRail/NavigationDrawer | — | Map 3 mode: bar→NavigationBar, rail→NavigationRail, sidebar→NavigationDrawer. Giữ VNLNavigationBar API ngoài | Navigation compile + select hoạt động | Abort |
  | 5 | VNLTabs → material.TabBar + TabBarView | — | Thay custom bằng material.TabBar. Map VNLTabsTheme → TabBarTheme | Tabs compile + switch tab hoạt động | Abort |
  | 6 | VNLAlertDialog → material.AlertDialog + showDialog | — | Thay custom bằng material.AlertDialog + material.showDialog. Map theme sang DialogTheme | Dialog compile + hiển thị đúng | Abort |
  | 7 | VNLContextMenu/VNLDropdownMenu → material.showMenu/DropdownMenu | — | Thay custom bằng material.showMenu + material.DropdownMenu. Map theme sang MenuTheme | Menu compile + select hoạt động | Abort |
  | 8 | VNLStepper → material.Stepper | — | Thay custom bằng material.Stepper. Map theme sang StepperThemeData | Stepper compile + step hoạt động | Abort |
  | 9 | VNLAccordion/VNLCollapsible → material.ExpansionTile | — | Thay custom bằng material.ExpansionTile. Map theme sang ExpansionTileThemeData | Accordion compile + expand hoạt động | Abort |
  | 10 | Verify: screenshot diff layout/nav/overlay | Các step trên hoàn tất | Chụp screenshot từng component trên desktop + mobile, light + dark | Không visual diff | Fix style map |

* **Done Criteria:**
  - Tất cả layout/nav/overlay component compile
  - Tất cả hiển thị giống hệt trước migrate
  - Navigation state không mất khi chuyển tab/page
  - Dialog dismiss hoạt động
  - Keyboard navigation hoạt động

### Post-Report (fill after implementing this phase)
* **Files / Symbols Changed:**
* **Implemented Changes:**
* **Removed / Superseded:**
* **Behavior Change:**
* **Preserved Behavior:**
* **Verification Done:**
* **Remaining / Pending:**

### ⛔ Next-Phase Gate — [MANDATORY]
* **QC Verdict:** (filled by vr-flow-qc)

---

## Phase 5 — Cleanup + Verify

**Status:** planned

### Plan (stable contract)
* **Goal:** Xóa dead code (VNLButtonStyle system cũ, custom painter, state machine), xóa hide directives trong barrel, full regression test.
* **Impact / Risk:** `shadcn_flutter.dart`, toàn bộ file đã migrate. Risk: xóa nhầm code; bỏ hide → conflict patched flex. Mitigate: xóa từng phần, verify compile sau mỗi bước.
* **Invariants touched:** I3, I4, I5
* **Rollback:** Revert commit

* **Steps (detailed):**

  | # | Step | Precondition | Action | Postcondition | On error |
  |---|------|--------------|--------|---------------|----------|
  | 1 | Xóa VNLWidgetStatesProvider, VNLStatedWidget | Phase 4 done | Xóa class khỏi `clickable.dart`; verify không còn usage | Compile không lỗi | Revert xóa |
  | 2 | Xóa ControlledComponent, ControlledComponentAdapter nếu không còn dùng | — | Audit usage; nếu không còn → xóa | Compile không lỗi | Giữ lại nếu còn dùng |
  | 3 | Xóa custom painter (VNLDividerPainter, VNLSurfaceBarrierPainter, VNLCheckboxPainter) | Component đã migrate | Xóa class khỏi file tương ứng | Compile không lỗi | Revert xóa |
  | 4 | Xóa VNLButtonStyle, VNLButtonVariance, VNLAbstractButtonStyle nếu không còn dùng | Button đã migrate | Audit usage; giữ làm adapter input nếu còn cần | Compile không lỗi | Giữ nếu còn dùng |
  | 5 | Xóa VNLDensity class cũ nếu không còn dùng | Density đã map | Audit usage; map sang VisualDensity | Compile không lỗi | Giữ nếu còn dùng |
  | 6 | Xóa vnl.ThemeData + vnl.Theme class | Đã dùng material.ThemeData | Xóa class khỏi `theme.dart`; verify không còn reference | Compile không lỗi | Revert xóa |
  | 7 | Xóa hide directives trong shadcn_flutter.dart | Không còn conflict | Xóa dòng hide Row, Column, Flexible, Expanded, Form... | Material widget có sẵn cho consumer | Giữ hide cụ thể nếu conflict |
  | 8 | Verify: full vnl_ui_docs regression | Cleanup xong | Chạy vnl_ui_docs trên desktop + mobile, light + dark. Screenshot compare từng page | Không visual regression | Fix từng page |
  | 9 | Accessibility test | Regression pass | Test screen reader + keyboard nav toàn bộ component | Không regression | Fix từng component |
  | 10 | Update vnl_guide/components_guide.md | Regression pass | Cập nhật doc ghi chú Material migration | Doc updated | — |

* **Done Criteria:**
  - Không còn dead code từ hệ thống cũ
  - Barrel không hide Material widget
  - vnl_ui_docs full regression pass
  - Accessibility pass
  - Documentation updated
