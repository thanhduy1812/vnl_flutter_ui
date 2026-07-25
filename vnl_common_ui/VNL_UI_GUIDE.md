# VNL Common UI — Agent Reference Guide

> **Package:** `vnl_common_ui`  
> **Import:** `import 'package:vnl_common_ui/vnl_ui.dart';`  
> **Version:** 0.0.51

---

## 1. Theme System

### Dual Theme Architecture

After the Material migration (Phase 1), the app uses **two coexisting theme systems**:

| System | Widget | Access | Used by |
|--------|--------|--------|---------|
| VNL Theme | `Theme` (VNL) | `Theme.of(context)` | All VNL components |
| Material Theme | `material.Theme` | `Theme.of(context)` (Material import) | Material widgets |

Both return different `ThemeData` types. VNL components import VNL's `Theme`, Material widgets import `material.Theme`. They don't conflict.

### VNL ThemeData Properties

```dart
final theme = Theme.of(context); // VNL ThemeData
theme.colorScheme          // VNL ColorScheme (NOT material)
theme.typography           // VNL Typography
theme.radius               // base radius multiplier (default 0.5)
theme.scaling              // scale factor (default 1.0)
theme.density              // VNLDensity
theme.surfaceOpacity       // double?
theme.surfaceBlur          // double?
theme.borderRadiusMd       // double — scaled radius
theme.borderRadiusLg       // BorderRadius
theme.iconTheme            // IconThemeProperties
```

### VNLThemeExtension (Material bridge)

```dart
final vnl = context.vnlTheme;  // VNLThemeExtension
vnl.colorScheme               // VNL ColorScheme
vnl.typography                // VNL Typography
vnl.scaling                   // double
vnl.density                   // VNLDensity
vnl.radiusMd                  // double
vnl.borderRadiusMd            // BorderRadius
```

**Use `context.vnlTheme`** inside Material dialog/overlay contexts where `Theme.of(context)` might resolve to Material ThemeData.

### ColorScheme

```dart
colorScheme.background        // Color
colorScheme.foreground        // Color
colorScheme.primary           // Color
colorScheme.secondary         // Color
colorScheme.muted             // Color
colorScheme.border            // Color
colorScheme.popover           // Color
colorScheme.destructive       // Color
colorScheme.accent            // Color
colorScheme.ring              // Color
colorScheme.input             // Color
colorScheme.card / cardForeground
```

### Typography

```dart
typography.h1     // 36px w800
typography.h2     // 30px w600
typography.h3     // 24px w600
typography.h4     // 18px w600
typography.p      // 16px w400 (paragraph)
typography.lead   // lead text
typography.large  // 18px
typography.base   // 16px
typography.small  // 14px
typography.xSmall // 12px
typography.sans   // base sans-serif
typography.mono   // monospace
```

**Text style extensions** (chain on `Text` widgets):
```dart
Text('Hello').h1().bold().muted().center()
// .h1() .h2() .h3() .h4() .p() .lead()
// .large() .small() .xSmall() .muted()
// .bold() .semiBold() .medium() .normal()
// .center() .italic()
```

### VNLDensity

```dart
VNLDensity.defaultDensity    // base 16px
VNLDensity.compactDensity    // base 8px
VNLDensity.reducedDensity    // base 12px
VNLDensity.spaciousDensity   // base 20px
```

### ColorShades (palette)

```dart
VNLColors.slate              // ColorShades
VNLColors.slate.shade500     // specific shade
VNLColors.red, .blue, .green, etc.
```

---

## 2. Key Components

### Buttons

```dart
VNLPrimaryButton(onPressed: () {}, child: Text('OK'))
VNLSecondaryButton(onPressed: () {}, child: Text('Cancel'))
VNLOutlineButton(onPressed: () {}, child: Text('Outline'))
VNLGhostButton(onPressed: () {}, child: Text('Ghost'))
VNLTextButton(onPressed: () {}, child: Text('Text'))
VNLDestructiveButton(onPressed: () {}, child: Text('Delete'))
VNLLinkButton(onPressed: () {}, child: Text('Link'))
VNLFixedButton(onPressed: () {}, child: Icon(...))  // icon button
VNLMutedButton(onPressed: () {}, child: Text('Muted'))
```

**Sizes:** `VNLButtonSize.small / .medium / .large / .xl / .icon`  
**Density:** `VNLButtonDensity.compact / .comfortable / .normal`  
**Styles:** `VNLButtonStyle.primary(size:, density:)` etc.

### Clickable (Interactive wrapper)

```dart
VNLClickable(
  onPressed: () {},
  onLongPress: () {},
  onHover: (hovered) {},
  decoration: WidgetStateProperty.resolveWith((states) { ... }),
  child: ...,
)
```
Uses **InkWell** internally (Material ripple effect).  
Supports `enabled`, `focusOutline`, `mouseCursor`, `textStyle`, `iconTheme`.

### Form Controls

```dart
VNLSwitch(value: on, onChanged: (v) {})         // custom switch
VNLCheckbox(state: VNLCheckboxState.checked, onChanged: ...)  // tristate
VNLSlider.single(value: 0.5, onChanged: ...)     // single thumb
VNLSlider.range(values: ..., onChanged: ...)     // dual thumb
VNLTextField(controller: ..., placeholder: ...)   // text input
VNLTextArea(controller: ..., placeholder: ...)    // multiline
VNLInputOTP(length: 6, onCompleted: ...)         // OTP input
VNLSelect(items: ..., onChanged: ...)            // dropdown
VNLMultipleChoice(options: ..., onChanged: ...)  // multi-select
VNLDatePicker / VNLTimePicker                    // date/time
```

**Form Validation:**
```dart
VNLForm(
  controller: VNLFormController(),
  child: VNLFormField(
    validators: [RequiredValidator(), VNLEmailValidator()],
    builder: (context, onChanged, error) => VNLTextField(...),
  ),
)
```

### Display

```dart
VNLCard(child: ...)              // card container
VNLCard.filled / .outlined       // variants
VNLBadge(child: Text('NEW'))     // badge
VNLPrimaryBadge / VNLSecondaryBadge / VNLOutlineBadge / VNLDestructiveBadge
VNLChip(label: ..., onDeleted: ...)
VNLCodeSnippet(code: '...', language: 'dart')
VNLAvatar / VNLAvatarGroup
VNLCircularProgressIndicator()
VNLLinearProgressIndicator(value: 0.5)
VNLTooltip(message: 'Help', child: ...)
VNLKeyboardDisplay.fromActivator(activator: ...)  // Ctrl+F display
VNLPinnedSheet(...)             // bottom sheet with stages
VNLTable(...)                   // data table
```

### Layout

```dart
VNLScaffold(appBar:, body:, bottomNavigationBar:)   // scaffold
VNLAppBar(title:, actions:, leading:)
VNLTabs(tabs: [...], selectedIndex:)                // tabs
VNLTabPane(label:, icon:, child:)
VNLAlertDialog(title:, content:, actions:)          // dialog
VNLAccordion / VNLCollapsible                       // expandable
VNLStepper(steps: [...])                            // stepper
VNLVerticalDivider / VNLDivider                     // divider
VNLOutlinedContainer(child:, borderRadius:)         // bordered container
VNLDrawerContainer(child:)                          // drawer-style container
VNLSheetContainer(child:)                           // sheet-style container
VNLDensityRow / VNLDensityColumn / VNLDensityFlex   // density-aware layout
```

### Navigation

```dart
VNLNavigationBar(items: [...], selectedIndex:)
VNLNavigationRail(items: [...])
VNLNavigationSidebar(items: [...])
VNLNavigationItem(key:, label:, child:)
```

### Overlay

```dart
showDialog(context: context, builder: (ctx) => VNLAlertDialog(...))
showPopover(context: context, builder: (ctx) => ..., alignment: ...)
VNLPopover(child:, overlay:)
VNLContextMenu / VNLMenu / VNLMenuBar / VNLDropdownMenu
VNLToast / VNLDrawer / VNLHoverCard
```

### Spacing Helpers

```dart
Gap(16)                     // fixed gap
VNLDensityGap(gap: gapLg)   // density-aware gap
.withPadding(padding:)       // padding extension
.sized(width:, height:)      // size extension
.gap(8)                      // gap extension on Column/Row
```

---

## 3. Naming Convention

**ALL public classes use VNL prefix** (except theme types without prefix):

| Prefixed | Unprefixed |
|----------|------------|
| `VNLPrimaryButton`, `VNLCard`, `VNLSwitch` | `ColorScheme`, `Typography`, `ThemeData` |
| `VNLDivider`, `VNLTabs`, `VNLAlertDialog` | `VNLDensity`, `IconThemeProperties` |
| `VNLOverlayPosition`, `VNLSheetStage` | `AdaptiveScaling` |

No unprefixed aliases exist for component classes.

---

## 4. Do / Don't

| ✅ Do | ❌ Don't |
|-------|---------|
| `import 'package:vnl_common_ui/vnl_ui.dart';` | Import Material directly for UI |
| Use `VNLThemeData`, `VNLColorScheme` from VNL Theme | Mix Material + VNL theme in same component |
| `Theme.of(context).colorScheme.background` | `material.Theme.of(context).colorScheme.surface` |
| `VNLPrimaryButton(onPressed:, child:)` | `PrimaryButton` (no VNL prefix) |
| `context.vnlTheme` inside Material dialogs | `Theme.of(context).scaling` inside Material context |
| `Text('X').h1().muted()` for styling | Manual `TextStyle(fontSize: 36, ...)` |
| `VNLButtonStyle.primary(size:, density:)` for custom | Hand-roll button styling |

---

## 5. Quick Reference Card

```
Theme       → Theme.of(context)     // VNL ThemeData
Material    → context.vnlTheme      // VNLThemeExtension bridge  
Color       → VNLColors.slate.shade500
Button      → VNLPrimaryButton(onPressed:, child:)
Dialog      → VNLAlertDialog(title:, content:, actions:)
Form        → VNLForm(controller:, child: VNLFormField(...))
Layout      → VNLScaffold(appBar:, body:)
Sheet       → VNLPinnedSheet(stages:, child:)
Popover     → showPopover(context:, builder:)
Text style  → Text('...').h2().muted()
Spacing     → Gap(16) or VNLDensityGap(gap: gapLg)
```
