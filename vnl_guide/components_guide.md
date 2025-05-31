# VNL Common UI Components Guide

> **Note:** These UI components are designed following Shadcn UI principles. If a component name with the VNL prefix matches a Material 3 widget, always prefer using the VNL version for consistency and design alignment.
> 
> This is the official documentation for all VNL Common UI components. Do not confuse these with Material 3 widgets.

## Table of Contents

- [VNLookApp](#vnlookapp)
- [VNLookLayer](#vnlooklayer)
- [VNLookAnimatedTheme](#vnlookanimatedtheme)
- [VNLookUI](#vnlookui)
- [AdaptiveScaler](#adaptivescaler)
- [Scrollbar](#scrollbar)
- [ScrollViewInterceptor](#scrollviewinterceptor)
- [CommandEmpty](#commandempty)
- [VNLCommand](#vnlcommand)
- [CommandCategory](#commandcategory)
- [CommandItem](#commanditem)
- [AnimatedValueBuilder](#animatedvaluebuilder)
- [RepeatedAnimationBuilder](#repeatedanimationbuilder)
- [CrossFadedTransition](#crossfadedtransition)
- [VNLRefreshTrigger](#vnlrefreshtrigger)
- [DefaultRefreshIndicator](#defaultrefreshindicator)
- [VNLSelectableText](#vnlselectabletext)
- [ToastLayer](#toastlayer)
- [VNLToastEntryLayout](#vnltoastentrylayout)
- [ControlledToggle](#controlledtoggle)
- [VNLToggle](#vnltoggle)
- [VNLSelectedButton](#vnlselectedbutton)
- [VNLButton](#vnlbutton)
- [PrimaryButton](#primarybutton)
- [SecondaryButton](#secondarybutton)
- [OutlineButton](#outlinebutton)
- [GhostButton](#ghostbutton)
- [LinkButton](#linkbutton)
- [VNLTextButton](#vnltextbutton)
- [DestructiveButton](#destructivebutton)
- [VNLTabButton](#vnltabbutton)
- [CardButton](#cardbutton)
- [VNLICONButton](#iconbutton)
- [VNLButtonStyleOverride](#vnlbuttonstyleoverride)
- [VNLButtonGroup](#vnlbuttongroup)
- [CodeSnippet](#codesnippet)
- [VNLDropdownMenu](#vnldropdownmenu)
- [AvatarWidget](#avatarwidget)
- [VNLAvatar](#avatar)
- [VNLAvatarBadge](#vnlavatarbadge)
- [_AvatarWidget](#_avatarwidget)
- [VNLAvatarGroup](#vnlavatargroup)
- [AvatarGroupClipper](#avatargroupclipper)
- [ModalBackdrop](#modalbackdrop)
- [ModalContainer](#modalcontainer)
- [VNLDivider](#vnldivider)
- [VerticalDivider](#verticaldivider)
- [CircularProgressIndicator](#circularprogressindicator)
- [VNLSpinner](#vnlspinner)
- [ChipButton](#chipbutton)
- [VNLChip](#vnlchip)
- [VNLDotItem](#vnldotitem)
- [VNLHover](#vnlhover)
- [VNLHoverActivity](#vnlhoveractivity)
- [VNLLabel](#vnllabel)
- [KeyboardShortcutDisplayMapper](#keyboardshortcutdisplaymapper)
- [VNLKeyboardDisplay](#vnlkeyboarddisplay)
- [KeyboardKeyDisplay](#keyboardkeydisplay)
- [VNLProgress](#vnlprogress)
- [VNLookSkeletonizerConfigLayer](#vnlookskeletonizerconfiglayer)
- [VNLCarousel](#vnlcarousel)
- [_CarouselState](#_carouselstate)
- [CarouselDotIndicator](#carouseldotindicator)
- [NumberTicker](#numberticker)
- [LinearProgressIndicator](#linearprogressindicator)
- [PrimaryBadge](#primarybadge)
- [SecondaryBadge](#secondarybadge)
- [OutlineBadge](#outlinebadge)
- [DestructiveBadge](#destructivebadge)
- [FadeScroll](#fadescroll)
- [VNLMenuPopup](#vnlmenupopup)
- [DesktopEditableTextContextMenu](#desktopeditabletextcontextmenu)
- [MobileEditableTextContextMenu](#mobileeditabletextcontextmenu)
- [VNLContextMenu](#vnlcontextmenu)
- [ContextMenuPopup](#contextmenupopup)
- [VNLTextModifier](#vnltextmodifier)
- [_TextThenWidget](#_textthenwidget)
- [_RichTextThenWidget](#_richtextthenwidget)
- [_SelectableTextThenWidget](#_selectabletextthenwidget)
- [VNLWrappedText](#vnlwrappedtext)
- [VNLTextModifierImpl](#vnltextmodifierimpl)
- [DatePickerDialog](#datepickerdialog)
- [VNLCalendar](#vnlcalendar)
- [VNLMonthCalendar](#vnlmonthcalendar)
- [YearCalendar](#yearcalendar)
- [CalendarItem](#calendaritem)
- [CalendarGrid](#calendargrid)
- [VNLMenubar](#vnlmenubar)
- [VNLStatedWidget](#vnlstatedwidget)
- [WidgetStatesProvider](#widgetstatesprovider)
- [Clickable](#clickable)
- [VNLCardButton](#vnlcardbutton)
- [VNLChipButton](#vnlchipbutton)
- [VNLClickable](#vnlclickable)
- [VNLContextMenuPopup](#vnlcontextmenupopup)
- [VNLPagination](#vnlpagination)
- [VNLPopoverOverlayWidget](#vnlpopoveroverlaywidget)

---

## Icon System in VNL UI

VNL UI provides a flexible icon system with multiple icon sets and easy theming:

- **Icon Sets:**
  - `RadixIcons`, `LucideIcons`, `BootstrapIcons` (imported and used as `Icon(RadixIcons.someIcon)`)
- **Sizing/Color Extensions:**
  - Use `.iconSmall()`, `.iconMedium()`, `.iconLarge()`, `.iconPrimary()`, `.iconSecondary()`, etc. on any Icon widget for consistent theming.
  - Example:
    ```dart
    Icon(RadixIcons.home).iconLarge().iconPrimary()
    ```
- **WrappedIcon:**
  - Use `WrappedIcon` to apply custom theming or combine with your own widgets.

---

## VNLTextField
_No image available._

**Description:** The main text input field for VNL UI, supporting advanced features, decoration, and theming.

**Usage:**
```dart
VNLTextField(
  controller: TextEditingController(),
  placeholder: Text('Enter text'),
)
```
**Note:** Do not confuse with TextField from Material 3. Prefer VNLTextField for Shadcn UI consistency.

---

## VNLTextArea
_No image available._

**Description:** Multi-line text input for VNL UI, with auto-expanding and theming support.

**Usage:**
```dart
VNLTextArea(
  controller: TextEditingController(),
  placeholder: Text('Enter multi-line text'),
)
```
**Note:** Do not confuse with TextField/Material 3. Prefer VNLTextArea for Shadcn UI consistency.

---

## VNLNumberInput
_No image available._

**Description:** Numeric input field for VNL UI, supporting stepper buttons and formatting.

**Usage:**
```dart
VNLNumberInput(
  controller: TextEditingController(),
  min: 0,
  max: 100,
  step: 1,
)
```
**Note:** Prefer VNLNumberInput for numeric entry over Material 3 alternatives.

---

## VNLCheckbox
_No image available._

**Description:** Checkbox widget for VNL UI, supporting custom theming and states.

**Usage:**
```dart
VNLCheckbox(
  value: true,
  onChanged: (val) {},
)
```
**Note:** Do not confuse with Checkbox from Material 3.

---

## VNLRadio
_No image available._

**Description:** Radio button widget for VNL UI, supporting custom theming and states.

**Usage:**
```dart
VNLRadio(
  value: 'option1',
  groupValue: selectedValue,
  onChanged: (val) {},
)
```
**Note:** Do not confuse with Radio from Material 3.

---

## VNLSlider
_No image available._

**Description:** Slider widget for VNL UI, supporting custom theming and value formatting.

**Usage:**
```dart
VNLSlider(
  value: 50,
  min: 0,
  max: 100,
  onChanged: (val) {},
)
```
**Note:** Do not confuse with Slider from Material 3.

---

## VNLDatePicker
_No image available._

**Description:** Date picker widget for VNL UI, supporting custom theming and formats.

**Usage:**
```dart
VNLDatePicker(
  initialDate: DateTime.now(),
  onDateChanged: (date) {},
)
```
**Note:** Do not confuse with showDatePicker from Material 3.

---

## VNLForm
_No image available._

**Description:** Form container for VNL UI, supporting validation and advanced form features.

**Usage:**
```dart
VNLForm(
  child: Column(
    children: [VNLTextField(), VNLCheckbox()],
  ),
)
```
**Note:** Prefer VNLForm for form logic over Material 3 alternatives.

---

## VNLTooltip
_No image available._

**Description:** Tooltip widget for VNL UI, supporting custom theming and placement.

**Usage:**
```dart
VNLTooltip(
  message: 'Tooltip text',
  child: Icon(Icons.info),
)
```
**Note:** Do not confuse with Tooltip from Material 3.

---

## VNLSwiper
_No image available._

**Description:** Swiper/carousel widget for VNL UI, supporting swipe gestures and custom content.

**Usage:**
```dart
VNLSwiper(
  items: [...],
)
```
**Note:** Not a Material 3 widget.

---

## VNLPopover
_No image available._

**Description:** Popover widget for VNL UI, supporting custom content and placement.

**Usage:**
```dart
VNLPopover(
  child: Text('Popover'),
)
```
**Note:** Not a Material 3 widget.

---

## VNLAlert
_No image available._

**Description:** Alert widget for VNL UI, supporting custom theming and content.

**Usage:**
```dart
VNLAlert(
  title: Text('Alert'),
  content: Text('This is an alert.'),
)
```
**Note:** Do not confuse with AlertDialog from Material 3.

---

## VNLPagination
_No image available._

**Description:** Pagination widget for VNL UI, supporting custom theming and navigation.

**Usage:**
```dart
VNLPagination(
  pageCount: 10,
  onPageChanged: (page) {},
)
```
**Note:** Not a Material 3 widget.

---

## VNLCard
_No image available._

**Description:** Card widget for VNL UI, supporting custom theming and content.

**Usage:**
```dart
VNLCard(
  child: Text('Card content'),
)
```
**Note:** Do not confuse with Card from Material 3.

---

## VNLSteps
_No image available._

**Description:** Steps widget for VNL UI, supporting multi-step flows.

**Usage:**
```dart
VNLSteps(
  steps: [...],
)
```
**Note:** Not a Material 3 widget.

---

## VNLStepper
_No image available._

**Description:** Stepper widget for VNL UI, supporting multi-step flows and navigation.

**Usage:**
```dart
VNLStepper(
  steps: [...],
)
```
**Note:** Do not confuse with Stepper from Material 3.

---

## VNLTabList
_No image available._

**Description:** Tab list widget for VNL UI, supporting tab navigation.

**Usage:**
```dart
VNLTabList(
  tabs: [...],
)
```
**Note:** Not a Material 3 widget.

---

## VNLTabs
_No image available._

**Description:** Tabs widget for VNL UI, supporting tab navigation and content switching.

**Usage:**
```dart
VNLTabs(
  tabs: [...],
  children: [...],
)
```
**Note:** Do not confuse with TabBar/TabView from Material 3.

---

## VNLNavigationBar
_No image available._

**Description:** Navigation bar widget for VNL UI, supporting custom theming and navigation.

**Usage:**
```dart
VNLNavigationBar(
  items: [...],
)
```
**Note:** Do not confuse with NavigationBar from Material 3.

---

## VNLNavigationRail
_No image available._

**Description:** Navigation rail widget for VNL UI, supporting custom theming and navigation.

**Usage:**
```dart
VNLNavigationRail(
  items: [...],
)
```
**Note:** Do not confuse with NavigationRail from Material 3.

---

## VNLNavigationSidebar
_No image available._

**Description:** Navigation sidebar widget for VNL UI, supporting custom theming and navigation.

**Usage:**
```dart
VNLNavigationSidebar(
  items: [...],
)
```
**Note:** Not a Material 3 widget.

---

<!-- AUTO-GENERATED COMPONENT SECTIONS BELOW -->

## Button
![Button](./docs_images/button.png)

- **Name:** `PrimaryButton`, `SecondaryButton`, `OutlineButton`, ...
- **Description:** Various customizable button types, supporting multiple styles, states, and icons.
- **Usage:**
```dart
PrimaryButton(
  onPressed: () {},
  child: Text('Primary'),
)
```
- **Note:** Do not confuse with `ElevatedButton`, `TextButton` from Material 3. These buttons have their own style and behavior in VNL.

---

## Accordion
![Accordion](./docs_images/accordion.png)

- **Name:** `Accordion`, `AccordionItem`, `AccordionTrigger`
- **Description:** Accordion allows expanding/collapsing content.
- **Usage:**
```dart
Accordion(
  children: [
    AccordionItem(
      title: Text('Title'),
      content: Text('Content'),
    ),
  ],
)
```
- **Note:** Do not confuse with ExpansionPanel from Material.

---

## AlertDialog
![AlertDialog](./docs_images/alert_dialog.png)

- **Name:** `AlertDialog`
- **Description:** Alert dialog, confirmation dialog, customizable interface.
- **Usage:**
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Alert'),
    content: Text('Are you sure?'),
    actions: [
      PrimaryButton(child: Text('OK'), onPressed: () {}),
    ],
  ),
);
```
- **Note:** Do not confuse with `showDialog`/`AlertDialog` from Material.

---

## Avatar
![Avatar](./docs_images/avatar.png)

- **Name:** `Avatar`, `AvatarGroup`
- **Description:** Displays user avatar, group avatar.
- **Usage:**
```dart
VNLAvatar(
  image: NetworkImage('https://...'),
  size: 40,
)
```
- **Note:** Do not confuse with CircleAvatar from Material.

---

## Badge
![Badge](./docs_images/badge.png)

- **Name:** `PrimaryBadge`, `SecondaryBadge`, ...
- **Description:** Displays status badge, quantity, ...
- **Usage:**
```dart
PrimaryBadge(
  label: 'New',
)
```
- **Note:** Do not confuse with Badge from Material 3.

---

## VNLookApp
_No image available._

**Description:** Root widget for VNL UI applications, providing theming and configuration.

**Usage:**
```dart
VNLookApp(
  child: MyHomePage(),
)
```
**Note:** Do not confuse with MaterialApp from Material 3.

---

## VNLookLayer
_No image available._

**Description:** Provides a layer for advanced UI composition in VNL UI.

**Usage:**
```dart
VNLookLayer(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## VNLookAnimatedTheme
_No image available._

**Description:** Animated theme transitions for VNL UI.

**Usage:**
```dart
VNLookAnimatedTheme(
  data: themeData,
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## VNLookUI
_No image available._

**Description:** Main entry point for VNL UI widgets.

**Usage:**
```dart
VNLookUI(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## AdaptiveScaler
_No image available._

**Description:** Widget for responsive scaling in VNL UI.

**Usage:**
```dart
AdaptiveScaler(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## Scrollbar
_No image available._

**Description:** Custom scrollbar for VNL UI scrollable widgets.

**Usage:**
```dart
Scrollbar(
  child: ListView(...),
)
```
**Note:** Do not confuse with Scrollbar from Material 3.

---

## ScrollViewInterceptor
_No image available._

**Description:** Intercepts scroll events for advanced scroll handling.

**Usage:**
```dart
ScrollViewInterceptor(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## CommandEmpty
![Command](./docs_images/command.png)

**Description:** An empty command widget for command palette or menu.

**Usage:**
```dart
CommandEmpty()
```
**Note:** Not a Material 3 widget.

---

## VNLCommand
![Command](./docs_images/command.png)

**Description:** Command widget for command palette or menu.

**Usage:**
```dart
VNLCommand(
  label: 'Command',
  onPressed: () {},
)
```
**Note:** Not a Material 3 widget.

---

## CommandCategory
![Command](./docs_images/command.png)

**Description:** Category grouping for commands in a palette or menu.

**Usage:**
```dart
CommandCategory(
  label: 'Category',
  children: [...],
)
```
**Note:** Not a Material 3 widget.

---

## CommandItem
![Command](./docs_images/command.png)

**Description:** Represents a single command item in a palette or menu.

**Usage:**
```dart
CommandItem(
  label: 'Item',
  onPressed: () {},
)
```
**Note:** Not a Material 3 widget.

---

## AnimatedValueBuilder
![AnimatedValueBuilder](./docs_images/animatedvaluebuilder.png)

**Description:** Widget for building animated values over time.

**Usage:**
```dart
AnimatedValueBuilder(
  value: ...,
  builder: (context, value, child) => ...,
)
```
**Note:** Not a Material 3 widget.

---

## RepeatedAnimationBuilder
![RepeatedAnimationBuilder](./docs_images/repeatedanimationbuilder.png)

**Description:** Widget for building repeated animations.

**Usage:**
```dart
RepeatedAnimationBuilder(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## CrossFadedTransition
_No image available._

**Description:** Widget for cross-fading between two children.

**Usage:**
```dart
CrossFadedTransition(
  firstChild: ...,
  secondChild: ...,
  showFirst: true,
)
```
**Note:** Not a Material 3 widget.

---

## VNLRefreshTrigger
![RefreshTrigger](./docs_images/form.png)

**Description:** Widget to trigger refresh actions in lists or forms.

**Usage:**
```dart
VNLRefreshTrigger(
  onRefresh: () async { ... },
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## DefaultRefreshIndicator
![RefreshTrigger](./docs_images/form.png)

**Description:** Default refresh indicator for pull-to-refresh actions.

**Usage:**
```dart
DefaultRefreshIndicator(
  onRefresh: () async { ... },
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## VNLSelectableText
![SelectableText](./docs_images/textarea.png)

**Description:** Selectable text widget for VNL UI.

**Usage:**
```dart
VNLSelectableText('Selectable text')
```
**Note:** Do not confuse with SelectableText from Material 3.

---

## ToastLayer
![Toast](./docs_images/toast.png)

**Description:** Layer for displaying toast notifications.

**Usage:**
```dart
ToastLayer(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## VNLToastEntryLayout
![Toast](./docs_images/toast.png)

**Description:** Layout for individual toast entries.

**Usage:**
```dart
VNLToastEntryLayout(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## ControlledToggle
![Toggle](./docs_images/toggle.png)

**Description:** Controlled toggle switch widget.

**Usage:**
```dart
ControlledToggle(
  value: true,
  onChanged: (val) {},
)
```
**Note:** Do not confuse with Switch from Material 3.

---

## VNLToggle
![Toggle](./docs_images/toggle.png)

**Description:** Toggle switch widget for VNL UI.

**Usage:**
```dart
VNLToggle(
  value: true,
  onChanged: (val) {},
)
```
**Note:** Do not confuse with Switch from Material 3.

---

## VNLSelectedButton
![Button](./docs_images/button.png)

**Description:** Button widget with selected state.

**Usage:**
```dart
VNLSelectedButton(
  selected: true,
  child: Text('Selected'),
)
```
**Note:** Not a Material 3 widget.

---

## VNLButton
![Button](./docs_images/button.png)

**Description:** Base button widget for VNL UI.

**Usage:**
```dart
VNLButton(
  onPressed: () {},
  child: Text('Button'),
)
```
**Note:** Do not confuse with ElevatedButton from Material 3.

---

## PrimaryButton
![Button](./docs_images/button.png)

**Description:** Primary action button for VNL UI.

**Usage:**
```dart
PrimaryButton(
  onPressed: () {},
  child: Text('Primary'),
)
```
**Note:** Do not confuse with ElevatedButton from Material 3.

---

## SecondaryButton
![Button](./docs_images/button.png)

**Description:** Secondary action button for VNL UI.

**Usage:**
```dart
SecondaryButton(
  onPressed: () {},
  child: Text('Secondary'),
)
```
**Note:** Do not confuse with OutlinedButton from Material 3.

---

## OutlineButton
![Button](./docs_images/button.png)

**Description:** Outline style button for VNL UI.

**Usage:**
```dart
OutlineButton(
  onPressed: () {},
  child: Text('Outline'),
)
```
**Note:** Do not confuse with OutlinedButton from Material 3.

---

## GhostButton
![Button](./docs_images/button.png)

**Description:** Ghost style button for VNL UI.

**Usage:**
```dart
GhostButton(
  onPressed: () {},
  child: Text('Ghost'),
)
```
**Note:** Not a Material 3 widget.

---

## LinkButton
![Button](./docs_images/button.png)

**Description:** Link style button for VNL UI.

**Usage:**
```dart
LinkButton(
  onPressed: () {},
  child: Text('Link'),
)
```
**Note:** Not a Material 3 widget.

---

## VNLTextButton
![Button](./docs_images/button.png)

**Description:** Text style button for VNL UI.

**Usage:**
```dart
VNLTextButton(
  onPressed: () {},
  child: Text('Text'),
)
```
**Note:** Do not confuse with TextButton from Material 3.

---

## DestructiveButton
![Button](./docs_images/button.png)

**Description:** Destructive action button for VNL UI.

**Usage:**
```dart
DestructiveButton(
  onPressed: () {},
  child: Text('Delete'),
)
```
**Note:** Not a Material 3 widget.

---

## VNLTabButton
![Button](./docs_images/button.png)

**Description:** Tab style button for VNL UI.

**Usage:**
```dart
VNLTabButton(
  onPressed: () {},
  child: Text('Tab'),
)
```
**Note:** Not a Material 3 widget.

---

## VNLICONButton
![Button](./docs_images/button.png)

**Description:** Icon button for VNL UI.

**Usage:**
```dart
VNLICONButton(
  icon: Icon(Icons.star),
  onPressed: () {},
)
```
**Note:** Do not confuse with IconButton from Material 3.

---

## VNLButtonStyleOverride
![Button](./docs_images/button.png)

**Description:** Widget to override button styles in VNL UI.

**Usage:**
```dart
VNLButtonStyleOverride(
  style: ..., 
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## VNLButtonGroup
![Button](./docs_images/button.png)

**Description:** Group of buttons for VNL UI.

**Usage:**
```dart
VNLButtonGroup(
  children: [...],
)
```
**Note:** Not a Material 3 widget.

---

## CodeSnippet
![CodeSnippet](./docs_images/codesnippet.png)

**Description:** Widget to display code snippets with formatting.

**Usage:**
```dart
CodeSnippet(
  code: 'print("Hello World")',
)
```
**Note:** Not a Material 3 widget.

---

## VNLDropdownMenu
![DropdownMenu](./docs_images/dropdown_menu.png)

**Description:** Dropdown menu for VNL UI.

**Usage:**
```dart
VNLDropdownMenu(
  items: [...],
)
```
**Note:** Do not confuse with DropdownButton from Material 3.

---

## VNLAvatarWidget
![Avatar](./docs_images/avatar.png)

**Description:** Base widget for avatar display in VNL UI.

**Usage:**
```dart
VNLAvatarWidget(
  ...
)
```
**Note:** Do not confuse with CircleAvatar from Material 3.

---

## VNLAvatar
![Avatar](./docs_images/avatar.png)

**Description:** Widget to display a user avatar.

**Usage:**
```dart
VNLAvatar(
  image: NetworkImage('https://...'),
  size: 40,
)
```
**Note:** Do not confuse with CircleAvatar from Material 3.

---

## VNLAvatarBadge
![Avatar](./docs_images/avatar.png)

**Description:** Badge for avatar widget.

**Usage:**
```dart
VNLAvatarBadge(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## _AvatarWidget
![Avatar](./docs_images/avatar.png)

**Description:** Internal avatar widget for VNL UI.

**Usage:**
```dart
_AvatarWidget(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLAvatarGroup
![AvatarGroup](./docs_images/avatar_group.png)

**Description:** Widget to display a group of avatars.

**Usage:**
```dart
VNLAvatarGroup(
  avatars: [...],
)
```
**Note:** Not a Material 3 widget.

---

## AvatarGroupClipper
_No image available._

**Description:** Clipper for avatar group widget.

**Usage:**
```dart
AvatarGroupClipper(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## ModalBackdrop
![Dialog](./docs_images/dialog.png)

**Description:** Backdrop for modal dialogs.

**Usage:**
```dart
ModalBackdrop(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## ModalContainer
![Dialog](./docs_images/dialog.png)

**Description:** Container for modal dialogs.

**Usage:**
```dart
ModalContainer(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## VNLDivider
![Divider](./docs_images/divider.png)

**Description:** Divider widget for VNL UI.

**Usage:**
```dart
VNLDivider()
```
**Note:** Do not confuse with Divider from Material 3.

---

## VerticalDivider
![Divider](./docs_images/divider.png)

**Description:** Vertical divider widget for VNL UI.

**Usage:**
```dart
VerticalDivider()
```
**Note:** Do not confuse with VerticalDivider from Material 3.

---

## CircularProgressIndicator
![CircularProgress](./docs_images/circular_progress.png)

**Description:** Circular progress indicator for VNL UI.

**Usage:**
```dart
CircularProgressIndicator()
```
**Note:** Do not confuse with CircularProgressIndicator from Material 3.

---

## VNLSpinner
![Spinner](./docs_images/spinner.png)

**Description:** Spinner widget for loading states.

**Usage:**
```dart
VNLSpinner()
```
**Note:** Not a Material 3 widget.

---

## ChipButton
![ChipInput](./docs_images/chip_input.png)

**Description:** Button styled as a chip.

**Usage:**
```dart
ChipButton(
  label: 'Chip',
)
```
**Note:** Not a Material 3 widget.

---

## VNLChip
![ChipInput](./docs_images/chip_input.png)

**Description:** Chip widget for VNL UI.

**Usage:**
```dart
VNLChip(
  label: 'Chip',
)
```
**Note:** Do not confuse with Chip from Material 3.

---

## VNLDotItem
![DotIndicator](./docs_images/star_rating.png)

**Description:** Single dot item for dot indicators.

**Usage:**
```dart
VNLDotItem()
```
**Note:** Not a Material 3 widget.

---

## VNLHover
_No image available._

**Description:** Widget for hover effects.

**Usage:**
```dart
VNLHover(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLHoverActivity
_No image available._

**Description:** Widget for hover activity effects.

**Usage:**
```dart
VNLHoverActivity(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLLabel
_No image available._

**Description:** Widget for label display.

**Usage:**
```dart
VNLLabel(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## KeyboardShortcutDisplayMapper
_No image available._

**Description:** Widget to map and display keyboard shortcuts.

**Usage:**
```dart
KeyboardShortcutDisplayMapper(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLKeyboardDisplay
_No image available._

**Description:** Widget to display a keyboard layout.

**Usage:**
```dart
VNLKeyboardDisplay(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## KeyboardKeyDisplay
_No image available._

**Description:** Widget to display a single keyboard key.

**Usage:**
```dart
KeyboardKeyDisplay(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLProgress
![Progress](./docs_images/progress.png)

**Description:** Progress bar widget for VNL UI.

**Usage:**
```dart
VNLProgress(
  value: 0.5,
)
```
**Note:** Do not confuse with LinearProgressIndicator from Material 3.

---

## VNLookSkeletonizerConfigLayer
![Skeleton](./docs_images/skeleton.png)

**Description:** Skeleton loading layer for VNL UI.

**Usage:**
```dart
VNLookSkeletonizerConfigLayer(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## VNLCarousel
![Carousel](./docs_images/carousel.png)

**Description:** Carousel widget for VNL UI.

**Usage:**
```dart
VNLCarousel(
  items: [...],
)
```
**Note:** Not a Material 3 widget.

---

## _CarouselState
![Carousel](./docs_images/carousel.png)

**Description:** Internal state for carousel widget.

**Usage:**
```dart
_CarouselState()
```
**Note:** Not a Material 3 widget.

---

## CarouselDotIndicator
![Carousel](./docs_images/carousel.png)

**Description:** Dot indicator for carousel widget.

**Usage:**
```dart
CarouselDotIndicator(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## NumberTicker
![NumberTicker](./docs_images/number_ticker.png)

**Description:** Animated number ticker widget.

**Usage:**
```dart
NumberTicker(
  value: 100,
)
```
**Note:** Not a Material 3 widget.

---

## LinearProgressIndicator
![LinearProgressIndicator](./docs_images/progress.png)

**Description:** Linear progress indicator for VNL UI.

**Usage:**
```dart
LinearProgressIndicator(
  value: 0.5,
)
```
**Note:** Do not confuse with LinearProgressIndicator from Material 3.

---

## PrimaryBadge
![Badge](./docs_images/badge.png)

**Description:** Primary badge widget for VNL UI.

**Usage:**
```dart
PrimaryBadge(
  label: 'New',
)
```
**Note:** Not a Material 3 widget.

---

## SecondaryBadge
![Badge](./docs_images/badge.png)

**Description:** Secondary badge widget for VNL UI.

**Usage:**
```dart
SecondaryBadge(
  label: 'Info',
)
```
**Note:** Not a Material 3 widget.

---

## OutlineBadge
![Badge](./docs_images/badge.png)

**Description:** Outline badge widget for VNL UI.

**Usage:**
```dart
OutlineBadge(
  label: 'Outline',
)
```
**Note:** Not a Material 3 widget.

---

## DestructiveBadge
![Badge](./docs_images/badge.png)

**Description:** Destructive badge widget for VNL UI.

**Usage:**
```dart
DestructiveBadge(
  label: 'Delete',
)
```
**Note:** Not a Material 3 widget.

---

## FadeScroll
![FadeScroll](./docs_images/fade_scroll.png)

**Description:** Widget for fading scroll effects.

**Usage:**
```dart
FadeScroll(
  child: ...,
)
```
**Note:** Not a Material 3 widget.

---

## VNLMenuPopup
![ContextMenu](./docs_images/context_menu.png)

**Description:** Popup menu widget for VNL UI.

**Usage:**
```dart
VNLMenuPopup(
  items: [...],
)
```
**Note:** Not a Material 3 widget.

---

## DesktopEditableTextContextMenu
![ContextMenu](./docs_images/context_menu.png)

**Description:** Desktop context menu for editable text fields.

**Usage:**
```dart
DesktopEditableTextContextMenu(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## MobileEditableTextContextMenu
![ContextMenu](./docs_images/context_menu.png)

**Description:** Mobile context menu for editable text fields.

**Usage:**
```dart
MobileEditableTextContextMenu(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLContextMenu
![ContextMenu](./docs_images/context_menu.png)

**Description:** Context menu widget for VNL UI.

**Usage:**
```dart
VNLContextMenu(
  items: [...],
)
```
**Note:** Not a Material 3 widget.

---

## ContextMenuPopup
![ContextMenu](./docs_images/context_menu.png)

**Description:** Popup for context menu widget.

**Usage:**
```dart
ContextMenuPopup(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLTextModifier
_No image available._

**Description:** Widget to modify text display in VNL UI.

**Usage:**
```dart
VNLTextModifier(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## _TextThenWidget
_No image available._

**Description:** Internal widget for text display.

**Usage:**
```dart
_TextThenWidget(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## _RichTextThenWidget
_No image available._

**Description:** Internal widget for rich text display.

**Usage:**
```dart
_RichTextThenWidget(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## _SelectableTextThenWidget
_No image available._

**Description:** Internal widget for selectable text display.

**Usage:**
```dart
_SelectableTextThenWidget(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLWrappedText
_No image available._

**Description:** Widget for wrapped text display in VNL UI.

**Usage:**
```dart
VNLWrappedText(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLTextModifierImpl
_No image available._

**Description:** Implementation of text modifier for VNL UI.

**Usage:**
```dart
VNLTextModifierImpl(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## DatePickerDialog
![DatePicker](./docs_images/datepicker.png)

**Description:** Date picker dialog for VNL UI.

**Usage:**
```dart
DatePickerDialog(
  ...
)
```
**Note:** Do not confuse with showDatePicker from Material 3.

---

## VNLCalendar
![Calendar](./docs_images/calendar.png)

**Description:** Calendar widget for VNL UI.

**Usage:**
```dart
VNLCalendar(
  ...
)
```
**Note:** Do not confuse with CalendarDatePicker from Material 3.

---

## VNLMonthCalendar
![Calendar](./docs_images/calendar.png)

**Description:** Month view calendar widget.

**Usage:**
```dart
VNLMonthCalendar(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## YearCalendar
![Calendar](./docs_images/calendar.png)

**Description:** Year view calendar widget.

**Usage:**
```dart
YearCalendar(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## CalendarItem
![Calendar](./docs_images/calendar.png)

**Description:** Single item in a calendar view.

**Usage:**
```dart
CalendarItem(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## CalendarGrid
![Calendar](./docs_images/calendar.png)

**Description:** Grid layout for calendar widget.

**Usage:**
```dart
CalendarGrid(
  ...
)
```
**Note:** Not a Material 3 widget.

---

## VNLMenubar
![Menubar](./docs_images/menubar.png)

**Description:** Menubar widget for VNL UI.

**Usage:**
```