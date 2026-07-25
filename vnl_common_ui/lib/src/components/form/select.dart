import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:vnl_common_ui/src/components/control/hover.dart';

/// Theme data for customizing [Select] widget appearance and behavior.
///
/// This class defines the visual and behavioral properties that can be applied to
/// [Select] widgets, including popup constraints, positioning, styling, and
/// interaction behaviors. These properties can be set at the theme level
/// to provide consistent behavior across the application.
class VNLSelectTheme extends ComponentThemeData {
  /// Constraints for the popup menu size.
  final BoxConstraints? popupConstraints;

  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Border radius for select items.
  final BorderRadiusGeometry? borderRadius;

  /// Padding inside select items.
  final EdgeInsetsGeometry? padding;

  /// Whether to disable hover effects on items.
  final bool? disableHoverEffect;

  /// Whether the selected item can be unselected.
  final bool? canUnselect;

  /// Whether to automatically close the popover after selection.
  final bool? autoClosePopover;

  /// Creates a select theme.
  const VNLSelectTheme({
    this.popupConstraints,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.borderRadius,
    this.padding,
    this.disableHoverEffect,
    this.canUnselect,
    this.autoClosePopover,
  });

  /// Creates a copy of this theme with the given fields replaced.
  VNLSelectTheme copyWith({
    ValueGetter<BoxConstraints?>? popupConstraints,
    ValueGetter<AlignmentGeometry?>? popoverAlignment,
    ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<bool?>? disableHoverEffect,
    ValueGetter<bool?>? canUnselect,
    ValueGetter<bool?>? autoClosePopover,
  }) {
    return VNLSelectTheme(
      popupConstraints:
          popupConstraints == null ? this.popupConstraints : popupConstraints(),
      popoverAlignment:
          popoverAlignment == null ? this.popoverAlignment : popoverAlignment(),
      popoverAnchorAlignment: popoverAnchorAlignment == null
          ? this.popoverAnchorAlignment
          : popoverAnchorAlignment(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
      disableHoverEffect: disableHoverEffect == null
          ? this.disableHoverEffect
          : disableHoverEffect(),
      canUnselect: canUnselect == null ? this.canUnselect : canUnselect(),
      autoClosePopover:
          autoClosePopover == null ? this.autoClosePopover : autoClosePopover(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VNLSelectTheme &&
        other.popupConstraints == popupConstraints &&
        other.popoverAlignment == popoverAlignment &&
        other.popoverAnchorAlignment == popoverAnchorAlignment &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.disableHoverEffect == disableHoverEffect &&
        other.canUnselect == canUnselect &&
        other.autoClosePopover == autoClosePopover;
  }

  @override
  int get hashCode => Object.hash(
        popupConstraints,
        popoverAlignment,
        popoverAnchorAlignment,
        borderRadius,
        padding,
        disableHoverEffect,
        canUnselect,
        autoClosePopover,
      );
}

/// Controller for managing [ControlledSelect] state programmatically.
///
/// Extends [ValueNotifier] to provide reactive state management for select
/// components. Can be used to programmatically change selection, listen to
/// state changes, and integrate with forms and other reactive systems.
///
/// Example:
/// ```dart
/// final controller = VNLSelectController<String>('initial');
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Selection changed to: ${controller.value}');
/// });
///
/// // Update selection
/// controller.value = 'new_value';
/// ```
class VNLSelectController<T> extends ValueNotifier<T?>
    with ComponentController<T?> {
  /// Creates a [VNLSelectController] with an optional initial value.
  ///
  /// The [value] parameter sets the initial selected item. Can be null
  /// to start with no selection.
  ///
  /// Parameters:
  /// - [value] (T?, optional): Initial selected value
  VNLSelectController([super.value]);
}

/// Reactive single-selection dropdown with automatic state management.
///
/// A high-level select widget that provides automatic state management through
/// the controlled component pattern. Supports both controller-based and callback-based
/// state management with comprehensive customization options for item presentation,
/// popup behavior, and interaction handling.
///
/// ## Features
///
/// - **Flexible item rendering**: Custom builders for complete visual control over items
/// - **Popup positioning**: Configurable alignment and constraints for the dropdown
/// - **Keyboard navigation**: Full keyboard support with arrow keys and Enter/Escape
/// - **VNLForm integration**: Automatic validation and form field registration
/// - **Unselection support**: Optional ability to deselect the current selection
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = VNLSelectController<String>('apple');
///
/// ControlledSelect<String>(
///   controller: controller,
///   items: ['apple', 'banana', 'cherry'],
///   itemBuilder: (context, item) => Text(item),
///   placeholder: Text('Choose fruit'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// String? selectedFruit;
///
/// ControlledSelect<String>(
///   initialValue: selectedFruit,
///   onChanged: (fruit) => setState(() => selectedFruit = fruit),
///   items: ['apple', 'banana', 'cherry'],
///   itemBuilder: (context, item) => Text(item),
/// )
/// ```
class ControlledSelect<T> extends StatelessWidget
    with ControlledComponent<T?>, SelectBase<T> {
  @override
  final T? initialValue;
  @override
  final ValueChanged<T?>? onChanged;
  @override
  final bool enabled;
  @override
  final VNLSelectController<T>? controller;

  @override
  final Widget? placeholder;
  @override
  final bool filled;
  @override
  final FocusNode? focusNode;
  @override
  final BoxConstraints? constraints;
  @override
  final BoxConstraints? popupConstraints;
  @override
  final VNLPopoverConstraint popupWidthConstraint;
  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final AlignmentGeometry popoverAlignment;
  @override
  final AlignmentGeometry? popoverAnchorAlignment;
  @override
  final bool disableHoverEffect;
  @override
  final bool canUnselect;
  @override
  final bool autoClosePopover;
  @override
  final SelectPopupBuilder popup;
  @override
  final SelectValueBuilder<T> itemBuilder;
  @override
  final SelectValueSelectionHandler<T>? valueSelectionHandler;
  @override
  final SelectValueSelectionPredicate<T>? valueSelectionPredicate;
  @override
  final Predicate<T>? showValuePredicate;

  /// Creates a [ControlledSelect].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns depending on application architecture needs.
  ///
  /// Parameters:
  /// - [controller] (`VNLSelectController<T>?`, optional): external state controller
  /// - [initialValue] (T?, optional): starting selection when no controller
  /// - [onChanged] (`ValueChanged<T?>?`, optional): selection change callback
  /// - [enabled] (bool, default: true): whether select is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no item selected
  /// - [filled] (bool, default: false): whether to use filled appearance
  /// - [focusNode] (FocusNode?, optional): custom focus node for keyboard handling
  /// - [constraints] (BoxConstraints?, optional): size constraints for select widget
  /// - [popupConstraints] (BoxConstraints?, optional): size constraints for popup
  /// - [popupWidthConstraint] (VNLPopoverConstraint, default: anchorFixedSize): popup width behavior
  /// - [borderRadius] (BorderRadiusGeometry?, optional): override select border radius
  /// - [padding] (EdgeInsetsGeometry?, optional): override internal padding
  /// - [popoverAlignment] (AlignmentGeometry, default: topCenter): popup alignment
  /// - [popoverAnchorAlignment] (AlignmentGeometry?, optional): anchor alignment
  /// - [disableHoverEffect] (bool, default: false): disable item hover effects
  /// - [canUnselect] (bool, default: false): allow deselecting current item
  /// - [autoClosePopover] (bool, default: true): close popup after selection
  /// - [popup] (SelectPopupBuilder, required): builder for popup content
  /// - [itemBuilder] (`VNLSelectItemBuilder<T>`, required): builder for individual items
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<T>?`, optional): custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<T>?`, optional): selection validation
  /// - [showValuePredicate] (`Predicate<T>?`, optional): visibility filter for values
  ///
  /// Example:
  /// ```dart
  /// ControlledSelect<String>(
  ///   controller: controller,
  ///   popup: (context, items) => ListView(children: items),
  ///   itemBuilder: (context, item, selected) => Text(item),
  ///   placeholder: Text('Select option'),
  /// )
  /// ```
  const ControlledSelect({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = VNLPopoverConstraint.anchorFixedSize,
    this.borderRadius,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.disableHoverEffect = false,
    this.canUnselect = false,
    this.autoClosePopover = true,
    required this.popup,
    required this.itemBuilder,
    this.valueSelectionHandler,
    this.valueSelectionPredicate,
    this.showValuePredicate,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<T?>(
      builder: (context, data) {
        return Select<T>(
          onChanged: data.onChanged,
          placeholder: placeholder,
          filled: filled,
          focusNode: focusNode,
          constraints: constraints,
          popupConstraints: popupConstraints,
          popupWidthConstraint: popupWidthConstraint,
          value: data.value,
          borderRadius: borderRadius,
          padding: padding,
          popoverAlignment: popoverAlignment,
          popoverAnchorAlignment: popoverAnchorAlignment,
          disableHoverEffect: disableHoverEffect,
          canUnselect: canUnselect,
          autoClosePopover: autoClosePopover,
          enabled: data.enabled,
          itemBuilder: itemBuilder,
          valueSelectionHandler: valueSelectionHandler,
          valueSelectionPredicate: valueSelectionPredicate,
          showValuePredicate: showValuePredicate,
          popup: popup,
        );
      },
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,
    );
  }
}

/// Controller for managing [ControlledMultiSelect] state programmatically.
///
/// Extends [VNLSelectController] to provide reactive state management for multi-selection
/// components. Manages a collection of selected items with methods for adding,
/// removing, and bulk operations.
///
/// Example:
/// ```dart
/// final controller = VNLMultiSelectController<String>(['apple', 'banana']);
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Selection changed to: ${controller.value}');
/// });
///
/// // Update selection
/// controller.value = ['apple', 'cherry'];
/// ```
class VNLMultiSelectController<T> extends VNLSelectController<Iterable<T>> {
  /// Creates a [VNLMultiSelectController] with an optional initial selection.
  ///
  /// The [value] parameter sets the initial selected items collection.
  /// Can be null or empty to start with no selections.
  ///
  /// Parameters:
  /// - [value] (`Iterable<T>?`, optional): Initial selected items
  VNLMultiSelectController([super.value]);
}

/// Reactive multi-selection dropdown with automatic state management.
///
/// A high-level multi-select widget that provides automatic state management through
/// the controlled component pattern. Supports both controller-based and callback-based
/// state management with comprehensive customization options for item presentation,
/// selection behavior, and popup management.
///
/// ## Features
///
/// - **Multiple selection**: Select and deselect multiple items simultaneously
/// - **Flexible item rendering**: Custom builders for complete visual control over items
/// - **Selection indicators**: Built-in checkboxes or custom selection indicators
/// - **Popup positioning**: Configurable alignment and constraints for the dropdown
/// - **Keyboard navigation**: Full keyboard support with Space for selection toggle
/// - **VNLForm integration**: Automatic validation and form field registration
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = VNLMultiSelectController<String>(['apple']);
///
/// ControlledMultiSelect<String>(
///   controller: controller,
///   items: ['apple', 'banana', 'cherry', 'date'],
///   itemBuilder: (context, item, selected) => ListTile(
///     leading: VNLCheckbox(value: selected),
///     title: Text(item),
///   ),
///   placeholder: Text('Choose fruits'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// List<String> selectedFruits = [];
///
/// ControlledMultiSelect<String>(
///   initialValue: selectedFruits,
///   onChanged: (fruits) => setState(() => selectedFruits = fruits?.toList() ?? []),
///   items: ['apple', 'banana', 'cherry'],
///   itemBuilder: (context, item, selected) => Text(item),
/// )
/// ```
class ControlledMultiSelect<T> extends StatelessWidget
    with ControlledComponent<Iterable<T>?>, SelectBase<Iterable<T>> {
  @override
  final Iterable<T>? initialValue;
  @override
  final ValueChanged<Iterable<T>?>? onChanged;
  @override
  final bool enabled;
  @override
  final VNLMultiSelectController<T>? controller;

  @override
  final Widget? placeholder;
  @override
  final bool filled;
  @override
  final FocusNode? focusNode;
  @override
  final BoxConstraints? constraints;
  @override
  final BoxConstraints? popupConstraints;
  @override
  final VNLPopoverConstraint popupWidthConstraint;
  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final AlignmentGeometry popoverAlignment;
  @override
  final AlignmentGeometry? popoverAnchorAlignment;
  @override
  final bool disableHoverEffect;
  @override
  final bool canUnselect;
  @override
  final bool autoClosePopover;
  @override
  final SelectPopupBuilder popup;
  @override
  SelectValueBuilder<Iterable<T>> get itemBuilder => (context, value) {
        return MultiSelect._buildItem(multiItemBuilder, context, value);
      };
  @override
  final SelectValueSelectionHandler<Iterable<T>>? valueSelectionHandler;
  @override
  final SelectValueSelectionPredicate<Iterable<T>>? valueSelectionPredicate;
  @override
  final Predicate<Iterable<T>>? showValuePredicate;

  /// Builder for rendering individual items in multi-select mode.
  final SelectValueBuilder<T> multiItemBuilder;

  /// Creates a [ControlledMultiSelect].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with multiple item selection capabilities.
  ///
  /// Parameters:
  /// - [controller] (`VNLMultiSelectController<T>?`, optional): external state controller
  /// - [initialValue] (`Iterable<T>?`, optional): starting selection when no controller
  /// - [onChanged] (`ValueChanged<Iterable<T>?>?`, optional): selection change callback
  /// - [enabled] (bool, default: true): whether select is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no items selected
  /// - [filled] (bool, default: false): whether to use filled appearance
  /// - [focusNode] (FocusNode?, optional): custom focus node for keyboard handling
  /// - [constraints] (BoxConstraints?, optional): size constraints for select widget
  /// - [popupConstraints] (BoxConstraints?, optional): size constraints for popup
  /// - [popupWidthConstraint] (VNLPopoverConstraint, default: anchorFixedSize): popup width behavior
  /// - [borderRadius] (BorderRadiusGeometry?, optional): override select border radius
  /// - [padding] (EdgeInsetsGeometry?, optional): override internal padding
  /// - [popoverAlignment] (AlignmentGeometry, default: topCenter): popup alignment
  /// - [popoverAnchorAlignment] (AlignmentGeometry?, optional): anchor alignment
  /// - [disableHoverEffect] (bool, default: false): disable item hover effects
  /// - [canUnselect] (bool, default: false): allow deselecting all items
  /// - [autoClosePopover] (bool, default: false): close popup after each selection
  /// - [popup] (SelectPopupBuilder, required): builder for popup content
  /// - [itemBuilder] (`VNLSelectItemBuilder<T>`, required): builder for individual items
  /// - [multiItemBuilder] (`SelectValueBuilder<T>`, required): builder for selected items display
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<Iterable<T>>?`, optional): custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<Iterable<T>>?`, optional): selection validation
  /// - [showValuePredicate] (`Predicate<Iterable<T>>?`, optional): visibility filter for values
  ///
  /// Example:
  /// ```dart
  /// ControlledMultiSelect<String>(
  ///   controller: controller,
  ///   popup: (context, items) => ListView(children: items),
  ///   itemBuilder: (context, item, selected) => CheckboxListTile(
  ///     value: selected,
  ///     title: Text(item),
  ///   ),
  ///   multiItemBuilder: (context, items) => Wrap(
  ///     children: items.map((item) => VNLChip(label: Text(item))).toList(),
  ///   ),
  /// )
  /// ```
  const ControlledMultiSelect({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled = true,
    this.initialValue,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = VNLPopoverConstraint.anchorFixedSize,
    this.borderRadius,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.disableHoverEffect = false,
    this.canUnselect = true,
    this.autoClosePopover = false,
    this.showValuePredicate,
    required this.popup,
    required SelectValueBuilder<T> itemBuilder,
    this.valueSelectionHandler,
    this.valueSelectionPredicate,
  }) : multiItemBuilder = itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ControlledSelect<Iterable<T>>(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      initialValue: initialValue,
      placeholder: placeholder,
      filled: filled,
      focusNode: focusNode,
      constraints: constraints,
      popupConstraints: popupConstraints,
      popupWidthConstraint: popupWidthConstraint,
      borderRadius: borderRadius,
      padding: padding,
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      disableHoverEffect: disableHoverEffect,
      canUnselect: canUnselect,
      autoClosePopover: autoClosePopover,
      popup: popup,
      itemBuilder: itemBuilder,
      showValuePredicate: (test) {
        return test.isNotEmpty && (showValuePredicate?.call(test) ?? true);
      },
      valueSelectionHandler:
          valueSelectionHandler ?? _defaultMultiSelectValueSelectionHandler,
      valueSelectionPredicate:
          valueSelectionPredicate ?? _defaultMultiSelectValueSelectionPredicate,
    );
  }
}

/// A button widget representing a selectable item in a dropdown menu.
///
/// Used within select dropdowns to create clickable option items.
class SelectItemButton<T> extends StatelessWidget {
  /// The value this item represents.
  final T value;

  /// The child widget to display as the item content.
  final Widget child;

  /// The button style for this item.
  final VNLAbstractButtonStyle style;

  /// Whether this item is enabled.
  final bool? enabled;

  /// Creates a select item button.
  const SelectItemButton({
    super.key,
    required this.value,
    required this.child,
    this.enabled,
    this.style = const VNLButtonStyle.ghost(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final data = Data.maybeOf<SelectPopupHandle>(context);
    bool isSelected = data?.isSelected(value) ?? false;
    bool hasSelection = data?.hasSelection ?? false;
    return Actions(
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) {
            data?.selectItem(value, !isSelected);
            return null;
          },
        ),
      },
      child: VNLSubFocus(builder: (context, subFocusState) {
        return VNLWidgetStatesProvider(
          states: {
            if (subFocusState.isFocused) WidgetState.hovered,
          },
          child: VNLButton(
            enabled: enabled,
            disableTransition: true,
            alignment: AlignmentDirectional.centerStart,
            onPressed: () {
              data?.selectItem(value, !isSelected);
            },
            style: style.copyWith(
              padding: (context, states, value) => EdgeInsets.symmetric(
                vertical: 8 * scaling,
                horizontal: 8 * scaling,
              ),
              mouseCursor: (context, states, value) {
                return SystemMouseCursors.basic;
              },
            ),
            trailing: isSelected
                ? const Icon(LucideIcons.check).iconSmall()
                : hasSelection
                    ? SizedBox(width: 16 * scaling)
                    : null,
            child: child.normal(),
          ),
        );
      }),
    );
  }
}

/// A container for grouping related select items with optional headers and footers.
///
/// Organizes select menu items into logical sections with optional header
/// and footer widgets.
class VNLSelectGroup extends StatelessWidget {
  /// Optional header widgets displayed above the group.
  final List<Widget>? headers;

  /// The list of select items in this group.
  final List<Widget> children;

  /// Optional footer widgets displayed below the group.
  final List<Widget>? footers;

  /// Creates a select group.
  const VNLSelectGroup({
    super.key,
    this.headers,
    this.footers,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (headers != null) ...headers!,
        ...children,
        if (footers != null) ...footers!,
      ],
    );
  }
}

/// Represents a selectable item in a dropdown menu.
///
/// Used within select popups to define individual selectable options.
/// Automatically applies selected state styling when the item matches
/// the current selection.
///
/// Example:
/// ```dart
/// VNLSelectItem(
///   value: 'option1',
///   builder: (context) => Text('Option 1'),
/// )
/// ```
class VNLSelectItem extends StatelessWidget {
  /// Builder for the item's content.
  final WidgetBuilder builder;

  /// The value associated with this item.
  final Object? value;

  /// Creates a [VNLSelectItem].
  ///
  /// Parameters:
  /// - [value] (`Object?`, required): Item value.
  /// - [builder] (`WidgetBuilder`, required): Content builder.
  const VNLSelectItem({super.key, required this.value, required this.builder});

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<VNLSelectData>(context);
    final selected = data?.isSelected(value) ?? false;
    return VNLWidgetStatesProvider(
      states: {if (selected) WidgetState.selected},
      child: Builder(builder: builder),
    );
  }
}

/// A label widget for grouping items in a select popup.
///
/// Displays a non-selectable label to organize dropdown items into categories.
///
/// Example:
/// ```dart
/// VNLSelectLabel(
///   child: Text('Category Name'),
/// )
/// ```
class VNLSelectLabel extends StatelessWidget {
  /// The label content.
  final Widget child;

  /// Creates a [VNLSelectLabel].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): VNLLabel content.
  const VNLSelectLabel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    return Padding(
      padding: EdgeInsets.all(densityGap),
      child: child.semiBold().small(),
    );
  }
}

/// Builder function for select popup content.
///
/// Returns the widget tree for the dropdown/popup menu.
typedef SelectPopupBuilder = Widget Function(BuildContext context);

/// Builder function for rendering selected values.
///
/// Parameters:
/// - [context] (`BuildContext`): Build context.
/// - [value] (`T`): The selected value.
///
/// Returns: Widget representation of the value.
typedef SelectValueBuilder<T> = Widget Function(BuildContext context, T value);

/// Handler for custom selection logic.
///
/// Parameters:
/// - [oldValue] (`T?`): Previous selection.
/// - [value] (`Object?`): Newly selected item.
/// - [selected] (`bool`): Whether item is being selected (true) or deselected (false).
///
/// Returns: `T?` — the new selection state.
typedef SelectValueSelectionHandler<T> = T? Function(
    T? oldValue, Object? value, bool selected);

/// Predicate for testing value selection state.
///
/// Parameters:
/// - [value] (`T?`): Current selection.
/// - [test] (`Object?`): Value to test against.
///
/// Returns: `bool` — true if test matches selection.
typedef SelectValueSelectionPredicate<T> = bool Function(
    T? value, Object? test);

T? _defaultSingleSelectValueSelectionHandler<T>(
  T? oldValue,
  Object? value,
  bool selected,
) {
  if (value is! T?) {
    return null;
  }
  return selected ? value : null;
}

bool _defaultSingleSelectValueSelectionPredicate<T>(T? value, Object? test) {
  return value == test;
}

Iterable<T>? _defaultMultiSelectValueSelectionHandler<T>(
  Iterable<T>? oldValue,
  Object? newValue,
  bool selected,
) {
  if (newValue == null) {
    return null;
  }
  Iterable<T> wrappedNewValue = [newValue as T];
  if (oldValue == null) {
    return selected ? wrappedNewValue : null;
  }
  if (selected) {
    return oldValue.followedBy(wrappedNewValue);
  } else {
    var newIterable = oldValue.where((element) => element != newValue);
    return newIterable.isEmpty ? null : newIterable;
  }
}

bool _defaultMultiSelectValueSelectionPredicate<T>(
  Iterable<T>? value,
  Object? test,
) {
  if (value == null) {
    return test == null;
  }
  if (test == null) {
    return false;
  }
  return value.contains(test);
}

/// Common interface for select components.
///
/// Defines the contract for both single and multi-select widgets, providing
/// properties for popup behavior, styling, and value handling.
mixin SelectBase<T> {
  /// Callback when selection changes.
  ValueChanged<T?>? get onChanged;

  /// Placeholder widget shown when nothing is selected.
  Widget? get placeholder;

  /// Whether to use filled appearance style.
  bool get filled;

  /// Focus node for keyboard navigation.
  FocusNode? get focusNode;

  /// Size constraints for the select trigger.
  BoxConstraints? get constraints;

  /// Size constraints for the popup menu.
  BoxConstraints? get popupConstraints;

  /// How popup width should relate to trigger width.
  VNLPopoverConstraint get popupWidthConstraint;

  /// Border radius of the select trigger.
  BorderRadiusGeometry? get borderRadius;

  /// Internal padding of the select trigger.
  EdgeInsetsGeometry? get padding;

  /// Alignment of popup relative to trigger.
  AlignmentGeometry get popoverAlignment;

  /// Alignment of anchor point for popup positioning.
  AlignmentGeometry? get popoverAnchorAlignment;

  /// Whether to disable hover effects.
  bool get disableHoverEffect;

  /// Whether clicking selected item deselects it.
  bool get canUnselect;

  /// Whether popup auto-closes after selection.
  bool? get autoClosePopover;

  /// Builder for popup content.
  SelectPopupBuilder get popup;

  /// Builder for rendering selected values.
  SelectValueBuilder<T> get itemBuilder;

  /// Custom selection handler logic.
  SelectValueSelectionHandler<T>? get valueSelectionHandler;

  /// Predicate for testing selection state.
  SelectValueSelectionPredicate<T>? get valueSelectionPredicate;

  /// Predicate for showing value in trigger.
  Predicate<T>? get showValuePredicate;
}

/// A customizable dropdown selection widget for single-value selection.
///
/// [Select] provides a comprehensive dropdown selection experience with support for
/// custom item rendering, keyboard navigation, search functionality, and extensive
/// customization options. It displays a trigger button that opens a popup containing
/// selectable options when activated.
///
/// Key features:
/// - Single-value selection with optional null/unselect capability
/// - Customizable item rendering through builder functions
/// - Keyboard navigation and accessibility support
/// - Configurable popup positioning and constraints
/// - Search and filtering capabilities
/// - Focus management and interaction handling
/// - Theming and visual customization
/// - VNLForm integration and validation support
///
/// The widget supports various configuration modes:
/// - Filled or outlined appearance styles
/// - Custom popup positioning and alignment
/// - Conditional item visibility and selection
/// - VNLHover effects and interaction feedback
/// - Auto-closing popup behavior
///
/// Selection behavior can be customized through:
/// - [valueSelectionHandler]: Custom logic for handling selection
/// - [valueSelectionPredicate]: Conditions for allowing selection
/// - [showValuePredicate]: Conditions for displaying items
/// - [canUnselect]: Whether to allow deselecting the current value
///
/// Example:
/// ```dart
/// Select<String>(
///   value: selectedItem,
///   placeholder: Text('Choose an option'),
///   onChanged: (value) => setState(() => selectedItem = value),
///   popup: SelectPopup.menu(
///     children: [
///       VNLSelectItem(value: 'option1', child: Text('Option 1')),
///       VNLSelectItem(value: 'option2', child: Text('Option 2')),
///       VNLSelectItem(value: 'option3', child: Text('Option 3')),
///     ],
///   ),
/// );
/// ```
class Select<T> extends StatefulWidget with SelectBase<T> {
  /// Default maximum height for select popups in logical pixels.
  static const kDefaultSelectMaxHeight = 240.0;
  @override
  final ValueChanged<T?>? onChanged; // if null, then it's a disabled combobox
  @override
  final Widget? placeholder; // placeholder when value is null
  @override
  final bool filled;
  @override
  final FocusNode? focusNode;
  @override
  final BoxConstraints? constraints;
  @override
  final BoxConstraints? popupConstraints;
  @override
  final VNLPopoverConstraint popupWidthConstraint;

  /// The currently selected value.
  final T? value;

  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final AlignmentGeometry popoverAlignment;
  @override
  final AlignmentGeometry? popoverAnchorAlignment;
  @override
  final bool disableHoverEffect;
  @override
  final bool canUnselect;
  @override
  final bool? autoClosePopover;

  /// Whether the select is enabled for user interaction.
  final bool? enabled;
  @override
  final SelectPopupBuilder popup;
  @override
  final SelectValueBuilder<T> itemBuilder;
  @override
  final SelectValueSelectionHandler<T>? valueSelectionHandler;
  @override
  final SelectValueSelectionPredicate<T>? valueSelectionPredicate;
  @override
  final Predicate<T>? showValuePredicate;

  /// Creates a single-selection dropdown widget.
  ///
  /// The [popup] and [itemBuilder] parameters are required to define the
  /// dropdown content and how selected values are displayed.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget key for controlling widget identity
  /// - [onChanged] (`ValueChanged<T?>?`): Callback when selection changes; if null, select is disabled
  /// - [placeholder] (Widget?): Widget shown when no value is selected
  /// - [filled] (bool): Whether to use filled background style, defaults to false
  /// - [focusNode] (FocusNode?): Focus node for keyboard interaction
  /// - [constraints] (BoxConstraints?): Size constraints for the select button
  /// - [popupConstraints] (BoxConstraints?): Size constraints for the popup menu
  /// - [popupWidthConstraint] (VNLPopoverConstraint): Width constraint mode for popup, defaults to `VNLPopoverConstraint.anchorFixedSize`
  /// - [value] (T?): Currently selected value
  /// - [disableHoverEffect] (bool): Whether to disable hover visual feedback, defaults to false
  /// - [borderRadius] (BorderRadiusGeometry?): Custom border radius
  /// - [padding] (EdgeInsetsGeometry?): Custom padding
  /// - [popoverAlignment] (AlignmentGeometry): Popup alignment, defaults to `Alignment.topCenter`
  /// - [popoverAnchorAlignment] (AlignmentGeometry?): Anchor alignment for popup positioning
  /// - [canUnselect] (bool): Whether user can deselect current value, defaults to false
  /// - [autoClosePopover] (bool?): Whether popup closes after selection, defaults to true
  /// - [enabled] (bool?): Whether select is enabled for interaction
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<T>?`): Custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<T>?`): Predicate for allowing selection
  /// - [showValuePredicate] (`Predicate<T>?`): Predicate for showing items
  /// - [popup] (SelectPopupBuilder): Required builder for popup content
  /// - [itemBuilder] (`SelectValueBuilder<T>`): Required builder for selected value display
  const Select({
    super.key,
    this.onChanged,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = VNLPopoverConstraint.anchorFixedSize,
    this.value,
    this.disableHoverEffect = false,
    this.borderRadius,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.canUnselect = false,
    this.autoClosePopover = true,
    this.enabled,
    this.valueSelectionHandler,
    this.valueSelectionPredicate,
    this.showValuePredicate,
    required this.popup,
    required this.itemBuilder,
  });

  @override
  SelectState<T> createState() => SelectState<T>();
}

/// State class for the [Select] widget managing selection and popup interactions.
///
/// This state class handles the select dropdown's internal state including:
/// - Focus management for keyboard navigation
/// - Popup controller for opening/closing the dropdown menu
/// - Value change notifications
/// - Theme integration
///
/// The state implements [FormValueSupplier] to integrate with form validation
/// and value management systems.
///
/// See also:
/// - [Select], the widget that uses this state
/// - [VNLPopoverController], used to control the dropdown popup
/// - [FormValueSupplier], the mixin providing form integration
class SelectState<T> extends State<Select<T>>
    with FormValueSupplier<T, Select<T>> {
  late FocusNode _focusNode;
  final VNLPopoverController _popoverController = VNLPopoverController();
  late ValueNotifier<T?> _valueNotifier;

  VNLSelectTheme? _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = VNLComponentTheme.maybeOf<VNLSelectTheme>(context);
  }

  BoxConstraints? get _popupConstraints => styleValue(
        widgetValue: widget.popupConstraints,
        themeValue: _theme?.popupConstraints,
        defaultValue: null,
      );

  AlignmentGeometry get _popoverAlignment => styleValue(
        widgetValue: widget.popoverAlignment,
        themeValue: _theme?.popoverAlignment,
        defaultValue: Alignment.topCenter,
      );

  AlignmentGeometry? get _popoverAnchorAlignment => styleValue(
        widgetValue: widget.popoverAnchorAlignment,
        themeValue: _theme?.popoverAnchorAlignment,
        defaultValue: null,
      );

  BorderRadiusGeometry? get _borderRadius => styleValue(
        widgetValue: widget.borderRadius,
        themeValue: _theme?.borderRadius,
        defaultValue: null,
      );

  EdgeInsetsGeometry? get _padding => styleValue(
        widgetValue: widget.padding,
        themeValue: _theme?.padding,
        defaultValue: null,
      );

  bool get _disableHoverEffect => styleValue(
        widgetValue: widget.disableHoverEffect,
        themeValue: _theme?.disableHoverEffect,
        defaultValue: false,
      );

  bool get _canUnselect => styleValue(
        widgetValue: widget.canUnselect,
        themeValue: _theme?.canUnselect,
        defaultValue: false,
      );

  bool get _autoClosePopover => styleValue(
        widgetValue: widget.autoClosePopover,
        themeValue: _theme?.autoClosePopover,
        defaultValue: true,
      );

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _valueNotifier = ValueNotifier(widget.value);
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(Select<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode = widget.focusNode ?? FocusNode();
    }
    if (widget.value != oldWidget.value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _valueNotifier.value = widget.value;
      });
      formValue = widget.value;
    } else if (widget.valueSelectionPredicate !=
        oldWidget.valueSelectionPredicate) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _valueNotifier.value = widget.value;
      });
    }
    if (widget.enabled != oldWidget.enabled ||
        widget.onChanged != oldWidget.onChanged) {
      bool enabled = widget.enabled ?? widget.onChanged != null;
      if (!enabled) {
        _focusNode.unfocus();
        _popoverController.close();
      }
    }
  }

  Widget get _placeholder {
    if (widget.placeholder != null) {
      return widget.placeholder!.muted;
    }
    return const SizedBox();
  }

  @override
  void didReplaceFormValue(T value) {
    widget.onChanged?.call(value);
  }

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  BoxDecoration _overrideBorderRadius(
    BuildContext context,
    Set<WidgetState> states,
    Decoration value,
  ) {
    return (value as BoxDecoration).copyWith(borderRadius: _borderRadius);
  }

  EdgeInsetsGeometry _overridePadding(
    BuildContext context,
    Set<WidgetState> states,
    EdgeInsetsGeometry value,
  ) {
    return _padding!;
  }

  bool _onChanged(Object? value, bool selected) {
    if (!selected && !_canUnselect) {
      return false;
    }
    var selectionHandler = widget.valueSelectionHandler ??
        _defaultSingleSelectValueSelectionHandler;
    var newValue = selectionHandler(widget.value, value, selected);
    widget.onChanged?.call(newValue);
    return true;
  }

  bool _isSelected(Object? value) {
    final selectionPredicate = widget.valueSelectionPredicate ??
        _defaultSingleSelectValueSelectionPredicate;
    return selectionPredicate(widget.value, value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    var enabled = widget.enabled ?? widget.onChanged != null;
    return IntrinsicWidth(
      child: ConstrainedBox(
        constraints: widget.constraints ?? const BoxConstraints(),
        child: TapRegion(
          onTapOutside: (event) {
            _focusNode.unfocus();
          },
          child: VNLButton(
            enabled: enabled,
            disableHoverEffect: _disableHoverEffect,
            focusNode: _focusNode,
            style: (widget.filled
                    ? VNLButtonVariance.secondary
                    : VNLButtonVariance.outline)
                .copyWith(
              decoration: _borderRadius != null ? _overrideBorderRadius : null,
              padding: _padding != null ? _overridePadding : null,
            ),
            onPressed: widget.onChanged == null
                ? null
                : () {
                    // to prevent entire ListView from rebuilding
                    // while the Data<VNLSelectData> is being updated
                    GlobalKey popupKey = GlobalKey();
                    _popoverController
                        .show(
                      context: context,
                      offset: Offset(0, densityGap),
                      alignment: _popoverAlignment,
                      anchorAlignment: _popoverAnchorAlignment,
                      widthConstraint: widget.popupWidthConstraint,
                      overlayBarrier: VNLOverlayBarrier(
                        padding: EdgeInsets.symmetric(vertical: densityGap),
                        borderRadius: BorderRadius.circular(theme.radiusLg),
                      ),
                      builder: (context) {
                        return ConstrainedBox(
                          constraints: _popupConstraints ??
                              BoxConstraints(
                                maxHeight:
                                    Select.kDefaultSelectMaxHeight * scaling,
                              ),
                          child: ListenableBuilder(
                            listenable: _valueNotifier,
                            builder: (context, _) {
                              return Data.inherit(
                                key: ValueKey(widget.value),
                                data: VNLSelectData(
                                  enabled: enabled,
                                  autoClose: _autoClosePopover,
                                  isSelected: _isSelected,
                                  onChanged: _onChanged,
                                  hasSelection: widget.value != null,
                                ),
                                child: Builder(
                                  key: popupKey,
                                  builder: (context) {
                                    return widget.popup(context);
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                        .then((value) {
                      _focusNode.requestFocus();
                    });
                  },
            child: VNLWidgetStatesProvider.boundary(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Data.inherit(
                    data: VNLSelectData(
                      enabled: enabled,
                      autoClose: _autoClosePopover,
                      isSelected: _isSelected,
                      onChanged: _onChanged,
                      hasSelection: widget.value != null,
                    ),
                    child: Expanded(
                      child: widget.value != null &&
                              (widget.showValuePredicate?.call(
                                    widget.value as T,
                                  ) ??
                                  true)
                          ? Builder(
                              builder: (context) {
                                return widget.itemBuilder(
                                  context,
                                  widget.value as T,
                                );
                              },
                            )
                          : _placeholder,
                    ),
                  ),
                  SizedBox(width: 8 * scaling),
                  IconTheme.merge(
                    data: IconThemeData(
                      color: theme.colorScheme.foreground,
                      opacity: 0.5,
                    ),
                    child: const Icon(LucideIcons.chevronsUpDown).iconSmall(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// VNLChip widget designed for multi-select contexts with automatic removal functionality.
///
/// A specialized chip widget that integrates with multi-select components to display
/// selected items with built-in removal capabilities. Automatically detects its
/// multi-select context and provides appropriate removal behavior.
///
/// ## Features
///
/// - **Context-aware removal**: Automatically integrates with parent multi-select state
/// - **Visual feedback**: Clear visual indication of selected state
/// - **Interactive deletion**: Built-in X button for removing selections
/// - **Consistent styling**: Matches multi-select component design patterns
/// - **Accessibility**: Full screen reader support for selection management
///
/// This widget is typically used within multi-select components to represent
/// individual selected items with the ability to remove them from the selection.
///
/// Example:
/// ```dart
/// VNLMultiSelectChip(
///   value: 'apple',
///   child: Text('Apple'),
///   style: VNLButtonStyle.secondary(),
/// );
/// ```
class VNLMultiSelectChip extends StatelessWidget {
  /// The value this chip represents in the selection.
  final Object? value;

  /// The content displayed inside the chip.
  final Widget child;

  /// The chip styling.
  final VNLAbstractButtonStyle style;

  /// Creates a [VNLMultiSelectChip].
  ///
  /// Designed to be used within multi-select components where it automatically
  /// integrates with the parent selection state for removal functionality.
  ///
  /// Parameters:
  /// - [value] (Object?, required): the value this chip represents in the selection
  /// - [child] (Widget, required): content displayed inside the chip
  /// - [style] (VNLAbstractButtonStyle, default: primary): chip styling
  ///
  /// Example:
  /// ```dart
  /// VNLMultiSelectChip(
  ///   value: user.id,
  ///   child: Row(
  ///     children: [
  ///       VNLAvatar(user: user),
  ///       Text(user.name),
  ///     ],
  ///   ),
  ///   style: VNLButtonStyle.secondary(),
  /// )
  /// ```
  const VNLMultiSelectChip({
    super.key,
    this.style = const VNLButtonStyle.primary(),
    required this.value,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<VNLSelectData>(context);
    return VNLChip(
      style: style,
      trailing: data?.enabled == false
          ? null
          : VNLChipButton(
              onPressed: () {
                data?.onChanged(value, false);
              },
              child: const Icon(LucideIcons.x).iconSmall(),
            ),
      child: child,
    );
  }
}

/// A customizable dropdown selection widget for multi-value selection.
///
/// Extends the base select functionality to support selecting multiple items
/// simultaneously. Displays selected items as removable chips within the trigger.
///
/// Example:
/// ```dart
/// MultiSelect<String>(
///   value: selectedItems,
///   onChanged: (items) => setState(() => selectedItems = items),
///   popup: SelectPopup.menu(children: [...]),
///   multiItemBuilder: (context, item) => Text(item),
/// )
/// ```
class MultiSelect<T> extends StatelessWidget with SelectBase<Iterable<T>> {
  @override
  final ValueChanged<Iterable<T>?>?
      onChanged; // if null, then it's a disabled combobox
  @override
  final Widget? placeholder; // placeholder when value is null
  @override
  final bool filled;
  @override
  final FocusNode? focusNode;
  @override
  final BoxConstraints? constraints;
  @override
  final BoxConstraints? popupConstraints;
  @override
  final VNLPopoverConstraint popupWidthConstraint;

  /// The currently selected values.
  final Iterable<T>? value;

  @override
  final BorderRadiusGeometry? borderRadius;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final AlignmentGeometry popoverAlignment;
  @override
  final AlignmentGeometry? popoverAnchorAlignment;
  @override
  final bool disableHoverEffect;
  @override
  final bool canUnselect;
  @override
  final bool? autoClosePopover;

  /// Whether the multi-select is enabled for user interaction.
  final bool? enabled;

  @override
  final SelectPopupBuilder popup;
  @override
  SelectValueBuilder<Iterable<T>> get itemBuilder => (context, value) {
        return _buildItem(multiItemBuilder, context, value);
      };
  @override
  final SelectValueSelectionHandler<Iterable<T>>? valueSelectionHandler;
  @override
  final SelectValueSelectionPredicate<Iterable<T>>? valueSelectionPredicate;

  /// Builder for rendering individual items in the chip display.
  final SelectValueBuilder<T> multiItemBuilder;

  @override
  final Predicate<Iterable<T>>? showValuePredicate;

  /// Creates a multi-selection dropdown widget.
  ///
  /// Allows selecting multiple items from a dropdown list, displaying them as chips.
  /// The [value], [popup], and [itemBuilder] parameters are required.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget key for controlling widget identity
  /// - [onChanged] (`ValueChanged<Iterable<T>?>?`): Callback when selection changes; if null, widget is disabled
  /// - [placeholder] (Widget?): Widget shown when no values are selected
  /// - [filled] (bool): Whether to use filled background style, defaults to false
  /// - [focusNode] (FocusNode?): Focus node for keyboard interaction
  /// - [constraints] (BoxConstraints?): Size constraints for the select button
  /// - [popupConstraints] (BoxConstraints?): Size constraints for the popup menu
  /// - [popupWidthConstraint] (VNLPopoverConstraint): Width constraint mode for popup, defaults to `VNLPopoverConstraint.anchorFixedSize`
  /// - [value] (`Iterable<T>`): Required currently selected values
  /// - [disableHoverEffect] (bool): Whether to disable hover visual feedback, defaults to false
  /// - [borderRadius] (BorderRadiusGeometry?): Custom border radius
  /// - [padding] (EdgeInsetsGeometry?): Custom padding
  /// - [popoverAlignment] (AlignmentGeometry): Popup alignment, defaults to `Alignment.topCenter`
  /// - [popoverAnchorAlignment] (AlignmentGeometry?): Anchor alignment for popup positioning
  /// - [canUnselect] (bool): Whether user can deselect items, defaults to true
  /// - [autoClosePopover] (bool?): Whether popup closes after selection, defaults to false
  /// - [enabled] (bool?): Whether multi-select is enabled for interaction
  /// - [valueSelectionHandler] (`SelectValueSelectionHandler<Iterable<T>>?`): Custom selection logic
  /// - [valueSelectionPredicate] (`SelectValueSelectionPredicate<Iterable<T>>?`): Predicate for allowing selection
  /// - [showValuePredicate] (`Predicate<Iterable<T>>?`): Predicate for showing items
  /// - [popup] (SelectPopupBuilder): Required builder for popup content
  /// - [itemBuilder] (`SelectValueBuilder<T>`): Required builder for individual chip items
  const MultiSelect({
    super.key,
    this.onChanged,
    this.placeholder,
    this.filled = false,
    this.focusNode,
    this.constraints,
    this.popupConstraints,
    this.popupWidthConstraint = VNLPopoverConstraint.anchorFixedSize,
    required this.value,
    this.disableHoverEffect = false,
    this.borderRadius,
    this.padding,
    this.popoverAlignment = Alignment.topCenter,
    this.popoverAnchorAlignment,
    this.canUnselect = true,
    this.autoClosePopover = false,
    this.enabled,
    this.valueSelectionHandler,
    this.valueSelectionPredicate,
    this.showValuePredicate,
    required this.popup,
    required SelectValueBuilder<T> itemBuilder,
  }) : multiItemBuilder = itemBuilder;

  static Widget _buildItem<T>(
    SelectValueBuilder<T> multiItemBuilder,
    BuildContext context,
    Iterable<T> value,
  ) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    return Wrap(
      spacing: densityGap * 0.5,
      runSpacing: densityGap * 0.5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [for (var value in value) multiItemBuilder(context, value)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Select<Iterable<T>>(
      popup: popup,
      itemBuilder: itemBuilder,
      onChanged: onChanged,
      placeholder: placeholder,
      filled: filled,
      focusNode: focusNode,
      constraints: constraints,
      popupConstraints: popupConstraints,
      popupWidthConstraint: popupWidthConstraint,
      value: value,
      borderRadius: borderRadius,
      padding: padding,
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      disableHoverEffect: disableHoverEffect,
      canUnselect: canUnselect,
      autoClosePopover: autoClosePopover ?? true,
      enabled: enabled,
      showValuePredicate: (test) {
        return test.isNotEmpty && (showValuePredicate?.call(test) ?? true);
      },
      valueSelectionHandler:
          valueSelectionHandler ?? _defaultMultiSelectValueSelectionHandler,
      valueSelectionPredicate:
          valueSelectionPredicate ?? _defaultMultiSelectValueSelectionPredicate,
    );
  }
}

/// Callback type for handling selection changes in select components.
///
/// Returns true if the change was successful, false otherwise.
typedef SelectValueChanged<T> = bool Function(T value, bool selected);

/// Data class holding select dropdown state and configuration.
///
/// Contains selection state, callbacks, and display options for select popups.
class VNLSelectData {
  /// Whether to automatically close the popup after selection.
  final bool? autoClose;

  /// Predicate to check if a value is currently selected.
  final Predicate<Object?> isSelected;

  /// Callback invoked when selection changes.
  final SelectValueChanged<Object?> onChanged;

  /// Whether any items are currently selected.
  final bool hasSelection;

  /// Whether the select is enabled for interaction.
  final bool enabled;

  /// Creates select data.
  const VNLSelectData({
    required this.autoClose,
    required this.isSelected,
    required this.onChanged,
    required this.hasSelection,
    required this.enabled,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VNLSelectData) return false;
    return other.isSelected == isSelected &&
        other.onChanged == onChanged &&
        other.hasSelection == hasSelection &&
        other.autoClose == autoClose &&
        other.enabled == enabled;
  }

  @override
  int get hashCode =>
      Object.hash(isSelected, onChanged, autoClose, hasSelection, enabled);
}

/// Builder function type for creating select item delegates.
///
/// Takes the build context and optional search query, returns a delegate
/// for rendering select items.
typedef SelectItemsBuilder<T> = FutureOr<VNLSelectItemDelegate> Function(
  BuildContext context,
  String? searchQuery,
);

/// A popup widget for displaying selectable items in a dropdown.
///
/// Provides a searchable, scrollable list of items with various display modes.
class SelectPopup<T> extends StatefulWidget {
  /// Builder function for dynamically generating select items.
  final SelectItemsBuilder<T>? builder;

  /// Static list of select items to display.
  final FutureOr<VNLSelectItemDelegate?>? items;

  /// Controller for the search input field.
  final TextEditingController? searchController;

  /// Placeholder widget for the search field.
  final Widget? searchPlaceholder;

  /// Builder for empty state display.
  final WidgetBuilder? emptyBuilder;

  /// Builder for loading state display.
  final WidgetBuilder? loadingBuilder;

  /// Builder for error state display.
  final ErrorWidgetBuilder? errorBuilder;

  /// Blur amount for the popup surface.
  final double? surfaceBlur;

  /// Opacity for the popup surface.
  final double? surfaceOpacity;

  /// Whether to auto-close the popup after selection.
  final bool? autoClose;

  /// Whether selected items can be unselected.
  final bool? canUnselect;

  /// Whether search functionality is enabled.
  final bool enableSearch;

  /// Controller for the items scroll view.
  final ScrollController? scrollController;

  /// Whether the list should shrink-wrap its contents.
  final bool shrinkWrap;

  /// Whether to disable item virtualization.
  final bool disableVirtualization;

  /// Creates a select popup with a dynamic builder.
  const SelectPopup.builder({
    super.key,
    required this.builder,
    this.searchController,
    this.searchPlaceholder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.autoClose,
    this.canUnselect,
    this.enableSearch = true,
    this.errorBuilder,
    this.scrollController,
  })  : items = null,
        shrinkWrap = false,
        disableVirtualization = false;

  /// Creates a select popup with static items.
  const SelectPopup({
    super.key,
    this.items,
    this.searchController,
    this.searchPlaceholder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.autoClose,
    this.canUnselect,
    this.scrollController,
    this.shrinkWrap = true,
  })  : builder = null,
        enableSearch = false,
        disableVirtualization = false;

  /// Creates a select popup without virtualization optimization.
  const SelectPopup.noVirtualization({
    super.key,
    FutureOr<VNLSelectItemList?>? this.items,
    this.searchController,
    this.searchPlaceholder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.surfaceBlur,
    this.surfaceOpacity,
    this.autoClose,
    this.canUnselect,
    this.scrollController,
  })  : builder = null,
        enableSearch = false,
        disableVirtualization = true,
        shrinkWrap = false;

  /// A method used to implement SelectPopupBuilder
  SelectPopup<T> call(BuildContext context) {
    return this;
  }

  @override
  State<SelectPopup<T>> createState() => _SelectPopupState<T>();
}

/// Mixin providing select popup interaction methods.
///
/// Allows widgets to check selection state and update selections.
mixin SelectPopupHandle {
  /// Checks if the given value is currently selected.
  bool isSelected(Object? value);

  /// Updates the selection state for the given value.
  void selectItem(Object? value, bool selected);

  /// Whether any items are currently selected.
  bool get hasSelection;

  /// Retrieves the nearest SelectPopupHandle from the widget tree.
  static SelectPopupHandle of(BuildContext context) {
    return Data.of<SelectPopupHandle>(context);
  }
}

class _SelectPopupState<T> extends State<SelectPopup<T>>
    with SelectPopupHandle {
  late TextEditingController _searchController;
  late ScrollController _scrollController;
  VNLSelectData? _selectData;

  @override
  void initState() {
    super.initState();
    _searchController = widget.searchController ?? TextEditingController();
    _scrollController = widget.scrollController ?? ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // because the controller did not get notified when a scroll position is attached
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant SelectPopup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchController != oldWidget.searchController) {
      _searchController = widget.searchController ?? TextEditingController();
    }
    if (widget.scrollController != oldWidget.scrollController) {
      _scrollController = widget.scrollController ?? ScrollController();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectData = Data.maybeOf<VNLSelectData>(context);
  }

  @override
  bool get hasSelection => _selectData?.hasSelection ?? false;

  @override
  bool isSelected(Object? value) {
    return _selectData?.isSelected(value) ?? false;
  }

  @override
  void selectItem(Object? value, bool selected) {
    _selectData?.onChanged(value, selected);
    if (widget.autoClose ?? _selectData?.autoClose == true) {
      closeOverlay(context, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return VNLSubFocusScope(builder: (context, subFocusScope) {
      return Actions(
        actions: {
          VNLNextItemIntent: CallbackAction<VNLNextItemIntent>(
            onInvoke: (intent) {
              subFocusScope.nextFocus();
              return null;
            },
          ),
          VNLPreviousItemIntent: CallbackAction<VNLPreviousItemIntent>(
            onInvoke: (intent) {
              subFocusScope.nextFocus(TraversalDirection.up);
              return null;
            },
          ),
          VNLCloseMenuIntent: CallbackAction<VNLCloseMenuIntent>(
            onInvoke: (intent) {
              closeOverlay(context);
              return null;
            },
          ),
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) {
              subFocusScope.invokeActionOnFocused(intent);
              return null;
            },
          ),
        },
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.tab): const VNLNextItemIntent(),
            LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.tab):
                const VNLPreviousItemIntent(),
            LogicalKeySet(LogicalKeyboardKey.escape): const VNLCloseMenuIntent(),
            LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
            LogicalKeySet(LogicalKeyboardKey.numpadEnter):
                const ActivateIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowDown): const VNLNextItemIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowUp):
                const VNLPreviousItemIntent(),
          },
          child: Focus(
            autofocus: !widget
                .enableSearch, // autofocus on VNLTextField when search enabled instead
            child: Data<SelectPopupHandle>.inherit(
              data: this,
              child: VNLModalContainer(
                clipBehavior: Clip.hardEdge,
                surfaceBlur: widget.surfaceBlur,
                surfaceOpacity: widget.surfaceOpacity,
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.enableSearch)
                      VNLComponentTheme(
                        data: const VNLFocusOutlineTheme(
                          border: Border.fromBorderSide(BorderSide.none),
                        ),
                        child: VNLTextField(
                          controller: _searchController,
                          border: const Border.fromBorderSide(BorderSide.none),
                          borderRadius: BorderRadius.zero,
                          features: [
                            VNLInputFeature.leading(
                              const Icon(
                                LucideIcons.search,
                              ).iconSmall().iconMutedForeground(),
                            ),
                          ],
                          autofocus: true,
                          placeholder: widget.searchPlaceholder,
                          padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12) *
                              scaling,
                        ),
                      ),
                    Flexible(
                      child: ListenableBuilder(
                        listenable: _searchController,
                        builder: (context, _) {
                          return CachedValueWidget(
                            value: _searchController.text.isEmpty
                                ? null
                                : _searchController.text,
                            builder: (context, searchQuery) {
                              return FutureOrBuilder<VNLSelectItemDelegate?>(
                                future: widget.builder != null
                                    ? widget.builder!.call(context, searchQuery)
                                    : widget.items != null
                                        ? widget.items!
                                        : VNLSelectItemDelegate.empty,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    Widget? loadingBuilder =
                                        widget.loadingBuilder?.call(context);
                                    if (loadingBuilder != null) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          if (widget.enableSearch)
                                            const VNLDivider(),
                                          Flexible(child: loadingBuilder),
                                        ],
                                      );
                                    }
                                    return const SizedBox();
                                  }
                                  if (snapshot.hasError) {
                                    Widget? errorBuilder =
                                        widget.errorBuilder?.call(
                                      context,
                                      snapshot.error!,
                                      snapshot.stackTrace,
                                    );
                                    if (errorBuilder != null) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          if (widget.enableSearch)
                                            const VNLDivider(),
                                          Flexible(child: errorBuilder),
                                        ],
                                      );
                                    }
                                    return const SizedBox();
                                  }
                                  if (snapshot.hasData &&
                                      snapshot.data?.estimatedChildCount != 0) {
                                    var data = snapshot.data!;
                                    return CachedValueWidget(
                                      value: data,
                                      builder: (context, data) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            if (widget.enableSearch)
                                              const VNLDivider(),
                                            Flexible(
                                              child: Stack(
                                                fit: StackFit.passthrough,
                                                children: [
                                                  if (widget
                                                      .disableVirtualization)
                                                    SingleChildScrollView(
                                                      controller:
                                                          _scrollController,
                                                      padding:
                                                          const EdgeInsets.all(
                                                                  4) *
                                                              scaling,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          for (var i = 0;
                                                              i <
                                                                  (data as VNLSelectItemList)
                                                                      .children
                                                                      .length;
                                                              i++)
                                                            data.build(
                                                                context, i),
                                                        ],
                                                      ),
                                                    )
                                                  else
                                                    ListView.builder(
                                                      controller:
                                                          _scrollController,
                                                      padding:
                                                          const EdgeInsets.all(
                                                                  4) *
                                                              scaling,
                                                      itemBuilder: data.build,
                                                      shrinkWrap:
                                                          widget.shrinkWrap,
                                                      itemCount: data
                                                          .estimatedChildCount,
                                                    ),
                                                  ListenableBuilder(
                                                    listenable:
                                                        _scrollController,
                                                    builder: (context, child) {
                                                      return Visibility(
                                                        visible:
                                                            _scrollController
                                                                    .offset >
                                                                0,
                                                        child: Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: VNLHoverActivity(
                                                            hitTestBehavior:
                                                                HitTestBehavior
                                                                    .translucent,
                                                            debounceDuration:
                                                                const Duration(
                                                              milliseconds: 16,
                                                            ),
                                                            onHover: () {
                                                              // decrease scroll offset
                                                              var value =
                                                                  _scrollController
                                                                          .offset -
                                                                      8;
                                                              value =
                                                                  value.clamp(
                                                                0.0,
                                                                _scrollController
                                                                    .position
                                                                    .maxScrollExtent,
                                                              );
                                                              _scrollController
                                                                  .jumpTo(
                                                                value,
                                                              );
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                        vertical:
                                                                            4,
                                                                      ) *
                                                                      scaling,
                                                              child: const Icon(
                                                                RadixIcons
                                                                    .chevronUp,
                                                              ).iconX3Small(),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  ListenableBuilder(
                                                    listenable:
                                                        _scrollController,
                                                    builder: (context, child) {
                                                      return Visibility(
                                                        visible: _scrollController
                                                                .hasClients &&
                                                            _scrollController
                                                                .position
                                                                .hasContentDimensions &&
                                                            _scrollController
                                                                    .offset <
                                                                _scrollController
                                                                    .position
                                                                    .maxScrollExtent,
                                                        child: Positioned(
                                                          bottom: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: VNLHoverActivity(
                                                            hitTestBehavior:
                                                                HitTestBehavior
                                                                    .translucent,
                                                            debounceDuration:
                                                                const Duration(
                                                              milliseconds: 16,
                                                            ),
                                                            onHover: () {
                                                              // increase scroll offset
                                                              var value =
                                                                  _scrollController
                                                                          .offset +
                                                                      8;
                                                              value =
                                                                  value.clamp(
                                                                0.0,
                                                                _scrollController
                                                                    .position
                                                                    .maxScrollExtent,
                                                              );
                                                              _scrollController
                                                                  .jumpTo(
                                                                value,
                                                              );
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                        vertical:
                                                                            4,
                                                                      ) *
                                                                      scaling,
                                                              child: const Icon(
                                                                RadixIcons
                                                                    .chevronDown,
                                                              ).iconX3Small(),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  Widget? emptyBuilder =
                                      widget.emptyBuilder?.call(
                                    context,
                                  );
                                  if (emptyBuilder != null) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        if (widget.enableSearch)
                                          const VNLDivider(),
                                        Flexible(child: emptyBuilder),
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

/// Abstract base class for building select item lists.
///
/// Provides interface for rendering select items with optional caching
/// and change detection.
abstract class VNLSelectItemDelegate with CachedValue {
  /// An empty select item delegate constant.
  static const empty = VNLEmptySelectItem();

  /// Creates a select item delegate.
  const VNLSelectItemDelegate();

  /// Builds a widget for the item at the given index.
  Widget? build(BuildContext context, int index);

  /// Estimated number of children in this delegate.
  int? get estimatedChildCount => null;

  @override
  bool shouldRebuild(covariant VNLSelectItemDelegate oldDelegate);
}

/// An empty select item delegate that renders no items.
class VNLEmptySelectItem extends VNLSelectItemDelegate {
  /// Creates an empty select item.
  const VNLEmptySelectItem();

  @override
  Widget? build(BuildContext context, int index) => null;

  @override
  int get estimatedChildCount => 0;

  @override
  bool shouldRebuild(covariant VNLEmptySelectItem oldDelegate) {
    return false;
  }
}

/// Builder function type for creating select item widgets.
///
/// Takes the build context and item index, returns the widget for that item.
typedef SelectItemWidgetBuilder = Widget Function(
    BuildContext context, int index);

/// A select item delegate that uses a builder function.
///
/// Provides items through a builder function with optional child count.
class VNLSelectItemBuilder extends VNLSelectItemDelegate {
  /// The builder function for creating item widgets.
  final SelectItemWidgetBuilder builder;

  /// The number of children this delegate can build.
  final int? childCount;

  /// Creates a select item builder.
  const VNLSelectItemBuilder({required this.builder, this.childCount});

  @override
  Widget build(BuildContext context, int index) {
    return builder(context, index);
  }

  @override
  int? get estimatedChildCount => childCount;

  @override
  bool shouldRebuild(covariant VNLSelectItemBuilder oldDelegate) {
    return oldDelegate.builder != builder &&
        oldDelegate.childCount != childCount;
  }
}

/// A select item delegate that uses a static list of children.
///
/// [VNLSelectItemList] provides select items from a pre-defined list of widgets.
/// This is the simplest way to create a select dropdown with a fixed set of options.
///
/// Example:
/// ```dart
/// VNLSelectItemList(
///   children: [
///     VNLSelectItem(value: 1, child: Text('Option 1')),
///     VNLSelectItem(value: 2, child: Text('Option 2')),
///     VNLSelectItem(value: 3, child: Text('Option 3')),
///   ],
/// )
/// ```
class VNLSelectItemList extends VNLSelectItemDelegate {
  /// The list of widgets to display as select items.
  final List<Widget> children;

  /// Creates a [VNLSelectItemList] with the specified children.
  const VNLSelectItemList({required this.children});

  @override
  Widget build(BuildContext context, int index) {
    return children[index];
  }

  @override
  int get estimatedChildCount => children.length;

  @override
  bool shouldRebuild(covariant VNLSelectItemList oldDelegate) {
    return !listEquals(oldDelegate.children, children);
  }
}
