Task: @task-uunxmw
Spec: @doc/specs/migrate-material-core/migrate-vnl-to-material-core
Status: done

# 04 — Contract: Plan

## Technical Solution — [MANDATORY]

### Core Logic Solution

**Theme map adapter pattern:**

```dart
// 1. VNLThemeExtension — carries VNL design tokens inside Material ThemeData
class VNLThemeExtension extends ThemeExtension<VNLThemeExtension> {
  final ColorScheme colorScheme;    // VNL ColorScheme (giữ nguyên tên)
  final Typography typography;       // VNL Typography (giữ nguyên tên)
  final double scaling;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final VNLDensity density;
}

// 2. Extension on Material ColorScheme — map VNL names to Material properties
extension VNLColorSchemeMaterial on material.ColorScheme {
  Color get vnlBackground => surface;
  Color get vnlMuted => surfaceContainerHighest;
  // ... (không dùng trực tiếp — chỉ internal)
}

// 3. Extension on Material TextTheme — map VNL names
extension VNLTypographyMaterial on material.TextTheme {
  TextStyle get vnlH1 => displayLarge ?? defaultStyle;
  // ...
}

// 4. Radius token extension on Material ThemeData
extension VNLRadiusToken on material.ThemeData {
  double get radiusMd => (visualDensity.baseSizeAdjustment...); // từ Material
  BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  // ...
}
```

**VNLClickable → InkWell:**

```dart
// Giữ nguyên VNLClickable class + constructor
// Build method: InkWell thay GestureDetector + FocusableActionDetector
// State management: MaterialStateProperty thay WidgetStatesController
// Decoration/margin/padding/textStyle/iconTheme → wrap ngoài InkWell
```

**VNLButton → Material buttons:**

```dart
// Adapter function: VNLAbstractButtonStyle → material.ButtonStyle
material.ButtonStyle _toMaterialStyle(VNLAbstractButtonStyle vnlStyle) {
  return material.ButtonStyle(
    backgroundColor: _mapBackgroundColor(vnlStyle),
    foregroundColor: _mapForegroundColor(vnlStyle),
    overlayColor: _mapOverlayColor(vnlStyle),
    side: _mapBorder(vnlStyle),
    padding: _mapPadding(vnlStyle),
    textStyle: _mapTextStyle(vnlStyle),
    iconTheme: _mapIconTheme(vnlStyle),
    // ...
  );
}
```

### New Classes/Functions to Create

| Symbol | file:line | Input → Output | Purpose |
|--------|-----------|----------------|---------|
| `VNLThemeExtension` | `lib/src/theme/theme_extension.dart` (new) | VNL ColorScheme, Typography, scaling, density → ThemeExtension | Mang VNL token trong Material ThemeData |
| `extension VNLThemeAccess on BuildContext` | `lib/src/theme/theme_extension.dart` | BuildContext → VNLThemeExtension | Shorthand access: `context.vnlTheme.colorScheme` |
| `extension VNLRadiusToken on material.ThemeData` | `lib/src/theme/theme_extension.dart` | material.ThemeData → double/BorderRadius | Giữ getter radiusMd, borderRadiusMd... |
| `VNLButtonStyleAdapter` | `lib/src/components/control/button.dart` | VNLAbstractButtonStyle → material.ButtonStyle | Map VNL style sang Material |

### Existing Functions to Modify

| Symbol | file:line | Change |
|--------|-----------|--------|
| `ThemeData` class | `lib/src/theme/theme.dart:148` | Xóa class, thay bằng re-export material.ThemeData |
| `Theme` widget | `lib/src/theme/theme.dart:395` | Xóa, dùng material.Theme |
| `ColorScheme` class | `lib/src/theme/color_scheme.dart` | Giữ nguyên class, thêm extension map sang material.ColorScheme |
| `Typography` class | `lib/src/theme/typography.dart` | Giữ nguyên class, thêm extension map sang material.TextTheme |
| `VNLDensity` class | `lib/src/theme/density.dart` | Giữ nguyên class, map sang material.VisualDensity |
| `VNLClickable` | `lib/src/components/control/clickable.dart:487` | Build dùng InkWell thay GestureDetector |
| `_ClickableState` | `lib/src/components/control/clickable.dart:691` | Xóa WidgetStatesController, dùng MaterialStateProperty |
| `VNLButton` | `lib/src/components/control/button.dart:659` | Build dùng Material button thay VNLClickable |
| `ButtonState` | `lib/src/components/control/button.dart:1388` | Xóa, thay bằng StatelessWidget build |
| `VNLButtonStyle`, `VNLButtonVariance`, `VNLAbstractButtonStyle` | `lib/src/components/control/button.dart` | Giữ làm adapter input, build không dùng |
| `VNLSwitch._SwitchState` | `lib/src/components/form/switch.dart:336` | Build dùng material.Switch |
| `VNLCheckbox` | `lib/src/components/form/checkbox.dart:462` | Build dùng material.Checkbox |
| `VNLSlider` | `lib/src/components/form/slider.dart` | Build dùng material.Slider/RangeSlider |
| `VNLDivider` | `lib/src/components/display/divider.dart:171` | Build dùng material.Divider |
| Các component Tier 1-4 (theo audit) | ~30 files | Build dùng Material widget tương ứng |
| `shadcn_flutter.dart` | `lib/shadcn_flutter.dart:24-42` | Xóa hide directives |

### Evidence

| Claim | Evidence |
|-------|----------|
| VNLClickable build với GestureDetector | `lib/src/components/control/clickable.dart:800` |
| VNLButton build với VNLClickable | `lib/src/components/control/button.dart:1479` |
| VNLSwitch build với AnimatedContainer | `lib/src/components/form/switch.dart:428-466` |
| VNLDivider build với CustomPaint | `lib/src/components/display/divider.dart:341-349` |
| VNLCircularProgressIndicator dùng mat.CircularProgressIndicator | `lib/src/components/display/circular_progress_indicator.dart:246` |
| Barrel hide directives | `lib/shadcn_flutter.dart:24-42` |

## Phase Contract — [MANDATORY]

### Phase Ordering Principles

1. **Dependency first** — Theme (Phase 1) trước, VNLClickable (Phase 2) trước component dùng nó (Phase 3-4).
2. **Observe before act** — Không áp dụng (internal refactor, không risky logic mới).
3. **De-risk before destroy** — Theme map xong trước khi xóa vnl.ThemeData.
4. **Ship the core value early** — Phase 1+2 là core value (theme + button), ship được ngay.

| # | Phase | Goal | Impact (files / features) | Risk | Potential Bugs | Trade-off | Rollback | Flag / kill-switch | Ship? | Depends on |
|---|-------|------|---------------------------|------|----------------|-----------|----------|--------------------|-------|------------|
| 1 | Theme Unification | Theme.of(context) trả về material.ThemeData, VNL token access qua VNLThemeExtension | `theme/color_scheme.dart`, `theme/typography.dart`, `theme/density.dart`, `theme/theme.dart`, `shadcn_flutter.dart`, toàn bộ component (đổi import) | Màu map không khớp → visual drift toàn bộ app | Màu sai, spacing sai, font sai do map sai property Material | Không — chỉ có 1 cách: map đúng từng property | Revert commit — mọi thay đổi là additive (thêm extension, chưa xóa theme cũ) | None — additive phase, theme cũ vẫn tồn tại song song | — | — |
| 2 | VNLClickable → InkWell + VNLButton → Material | Button + interactive component dùng Material button; ripple effect | `control/clickable.dart`, `control/button.dart`, ~30 component dùng VNLButton | Button style map không khớp → visual drift; thiếu state animation cũ (scale 0.95) | Màu button sai variant, padding sai, hover/press state không hiển thị, focus outline khác | Mất animation scale 0.95 → accept ripple effect thay thế | Revert commit | None — behavior change visible ngay | ★ | Phase 1 |
| 3 | Form Controls → Material | Switch, Checkbox, Radio, Slider, TextField, DatePicker, Tooltip, Chip, Badge, Progress dùng Material widget | `form/switch.dart`, `form/checkbox.dart`, `form/multiple_choice.dart`, `form/slider.dart`, `form/text_field.dart`, `display/chip.dart`, `display/badge.dart`, `overlay/tooltip.dart`, `display/linear_progress_indicator.dart`, `form/date_picker.dart`, `form/time_picker.dart` | Form control behavior khác Material mặc định → form validation có thể bị ảnh hưởng | State không sync giữa VNL form system và Material widget, onChange callback khác signature, keyboard navigation khác | Mất custom animation của VNL control → accept Material animation | Revert commit | None | ★ | Phase 2 |
| 4 | Layout/Nav/Overlay → Material | Divider, Card, Scaffold, NavBar, Tabs, Dialog, Dropdown, Stepper, Accordion dùng Material widget | `display/divider.dart`, `layout/card.dart`, `layout/scaffold.dart`, `navigation/*`, `overlay/dialog.dart`, `menu/*`, `layout/stepper.dart`, `layout/accordion.dart` | Material NavBar/Tabs API khác VNL → cần adapter dày hơn | Navigation state mất khi đổi widget, dialog animation khác, card surface khác | Giữ VNL navigation API bên ngoài, map internal → phức tạp hơn component đơn giản | Revert commit | None | ★ | Phase 3 |
| 5 | Cleanup + Verify | Xóa dead code, xóa hide directives, full regression test | `shadcn_flutter.dart`, toàn bộ file đã migrate | Xóa nhầm code còn dùng → compile error; bỏ hide → conflict patched flex | Row/Column/Flex của Material conflict với patched flex, Form/FormState conflict với VNL form | Không | Revert commit | None | — | Phase 4 |

## Invariants — [MANDATORY]

| # | Invariant (must ALWAYS hold) | Enforced/checked at | Violation ⇒ consequence |
|---|------------------------------|---------------------|-------------------------|
| I1 | VNL ColorScheme property name không đổi | Compile check: consumer code `colorScheme.background` vẫn compile | Compile error → block merge |
| I2 | VNL Typography property name không đổi | Compile check: `typography.h1` vẫn compile | Compile error → block merge |
| I3 | VNL component public API không đổi | Compile check: base_app compile với vnl_common_ui mới | Compile error → block merge |
| I4 | Visual output không đổi (trừ ripple effect) | Screenshot diff: từng page vnl_ui_docs | Visual regression → block merge |
| I5 | Barrel không hide Material widget sau Phase 5 | Static check: grep `hide` trong shadcn_flutter.dart | Không pass AC10 |

## Failure & Interruption Contract — [MANDATORY]

N/A — internal refactor, không có multi-stage flow, không có destructive operation, không có data migration. Mỗi phase là atomic commit — nếu fail thì revert.

## Cross-team / Out-of-scope Interface

| Work | Owning team | Data we provide | Lifecycle | Done when |
|------|-------------|-----------------|-----------|-----------|
| base_app consumer update | base_app team | VNL API không đổi — không cần update | N/A | base_app compile + run với vnl_common_ui mới |

## Test Cases (S4)

* Happy Path: Mọi VNL component hiển thị giống hệt trước migrate → Phase 1-4
* Happy Path: Consumer code compile không lỗi → Phase 1-5
* Happy Path: Theme token access hoạt động qua extension → Phase 1
* Happy Path: Ripple effect hiển thị khi click button → Phase 2
* Edge Cases: Dark mode — màu map đúng → Phase 1
* Edge Cases: Mobile scaling — density map đúng → Phase 1
* Edge Cases: Disabled state — tất cả component disabled giống hệt → Phase 2-4
* Edge Cases: Keyboard navigation — focus + Enter/Space hoạt động → Phase 2
* Edge Cases: Form validation — VNLForm vẫn hoạt động với Material control → Phase 3
* Edge Cases: Navigation state — chuyển tab/page không mất state → Phase 4
* Interruption / recovery: Rebuild giữa chừng — hot reload không crash → Phase 1-5
