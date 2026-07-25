import '../../../shadcn_flutter.dart';

/// Theme configuration for [VNLDatePicker] widget styling and behavior.
///
/// Defines the visual properties and default behaviors for date picker components
/// including presentation modes, calendar views, and popover positioning. Applied
/// globally through [VNLComponentTheme] or per-instance for customization.
///
/// Supports comprehensive customization of date picker appearance, initial views,
/// and interaction modes to match application design requirements.
class VNLDatePickerTheme extends ComponentThemeData {
  /// Default interaction mode for date picker triggers.
  ///
  /// Determines whether date selection opens a popover or modal dialog.
  /// When null, uses framework default prompt mode behavior.
  final VNLPromptMode? mode;

  /// Initial calendar view to display when date picker opens.
  ///
  /// Specifies the default time period view (month, year, decade, etc.)
  /// shown when the calendar interface first appears. When null, uses
  /// framework default initial view.
  final VNLCalendarView? initialView;

  /// Initial calendar view type for date picker interface.
  ///
  /// Determines the layout style and interaction pattern of the calendar
  /// (grid, list, compact, etc.). When null, uses framework default view type.
  final VNLCalendarViewType? initialViewType;

  /// Alignment point on the popover for anchor attachment.
  ///
  /// Determines where the date picker popover positions itself relative
  /// to the anchor widget. When null, uses framework default alignment.
  final AlignmentGeometry? popoverAlignment;

  /// Alignment point on the anchor widget for popover positioning.
  ///
  /// Specifies which part of the trigger widget the popover should align to.
  /// When null, uses framework default anchor alignment.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Internal padding applied to the date picker popover content.
  ///
  /// Controls spacing around the calendar interface within the popover
  /// container. When null, uses framework default padding.
  final EdgeInsetsGeometry? popoverPadding;

  /// Creates a [DatePickerTheme].
  ///
  /// All parameters are optional and fall back to framework defaults when null.
  /// The theme can be applied globally or to specific date picker instances.
  const VNLDatePickerTheme({
    this.mode,
    this.initialView,
    this.initialViewType,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
  });

  /// Creates a copy of this theme with specified properties overridden.
  VNLDatePickerTheme copyWith({
    ValueGetter<VNLPromptMode?>? mode,
    ValueGetter<VNLCalendarView?>? initialView,
    ValueGetter<VNLCalendarViewType?>? initialViewType,
    ValueGetter<AlignmentGeometry?>? popoverAlignment,
    ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment,
    ValueGetter<EdgeInsetsGeometry?>? popoverPadding,
  }) {
    return VNLDatePickerTheme(
      mode: mode == null ? this.mode : mode(),
      initialView: initialView == null ? this.initialView : initialView(),
      initialViewType:
          initialViewType == null ? this.initialViewType : initialViewType(),
      popoverAlignment:
          popoverAlignment == null ? this.popoverAlignment : popoverAlignment(),
      popoverAnchorAlignment: popoverAnchorAlignment == null
          ? this.popoverAnchorAlignment
          : popoverAnchorAlignment(),
      popoverPadding:
          popoverPadding == null ? this.popoverPadding : popoverPadding(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VNLDatePickerTheme &&
        other.mode == mode &&
        other.initialView == initialView &&
        other.initialViewType == initialViewType &&
        other.popoverAlignment == popoverAlignment &&
        other.popoverAnchorAlignment == popoverAnchorAlignment &&
        other.popoverPadding == popoverPadding;
  }

  @override
  int get hashCode => Object.hash(
        mode,
        initialView,
        initialViewType,
        popoverAlignment,
        popoverAnchorAlignment,
        popoverPadding,
      );
}

/// A controller for managing the selected date in a [VNLDatePicker].
///
/// [VNLDatePickerController] extends [ValueNotifier] to hold the currently selected
/// date and notify listeners when it changes. Use this to programmatically control
/// the date picker or react to date selection changes.
///
/// Example:
/// ```dart
/// final controller = VNLDatePickerController(DateTime.now());
/// controller.addListener(() {
///   print('Selected date: ${controller.value}');
/// });
/// ```
class VNLDatePickerController extends ValueNotifier<DateTime?>
    with ComponentController<DateTime?> {
  /// Creates a [VNLDatePickerController] with the specified initial date.
  VNLDatePickerController(super.value);
}

/// A controlled date picker widget with comprehensive date selection features.
///
/// [VNLControlledDatePicker] provides a complete date selection interface with
/// customizable presentation modes (popover or modal), calendar views, and
/// flexible positioning. It integrates with [VNLDatePickerController] for
/// programmatic control.
///
/// Features:
/// - Multiple presentation modes (popover, modal)
/// - Various calendar views (month, year, decade)
/// - Custom date state builders
/// - Flexible positioning
/// - Optional placeholder when no date is selected
///
/// Example:
/// ```dart
/// VNLControlledDatePicker(
///   initialValue: DateTime.now(),
///   onChanged: (date) {
///     print('Selected: $date');
///   },
///   placeholder: Text('Select a date'),
/// )
/// ```
class VNLControlledDatePicker extends StatelessWidget
    with ControlledComponent<DateTime?> {
  @override

  /// The initial date value.
  final DateTime? initialValue;

  @override

  /// Called when the selected date changes.
  final ValueChanged<DateTime?>? onChanged;

  @override

  /// Whether the date picker is enabled.
  final bool enabled;

  @override

  /// Optional controller for programmatic access.
  final VNLDatePickerController? controller;

  /// Widget displayed when no date is selected.
  final Widget? placeholder;

  /// Presentation mode (popover or modal).
  final VNLPromptMode? mode;

  /// Initial calendar view to display.
  final VNLCalendarView? initialView;

  /// VNLPopover alignment relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Internal padding for the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Title for the dialog when using modal mode.
  final Widget? dialogTitle;

  /// Initial calendar view type.
  final VNLCalendarViewType? initialViewType;

  /// Builder for customizing date cell states.
  final DateStateBuilder? stateBuilder;

  /// Creates a [VNLControlledDatePicker].
  const VNLControlledDatePicker({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.mode,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<DateTime?>(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return VNLDatePicker(
          enabled: data.enabled,
          value: data.value,
          onChanged: data.onChanged,
          placeholder: placeholder,
          mode: mode,
          initialView: initialView,
          popoverAlignment: popoverAlignment,
          popoverAnchorAlignment: popoverAnchorAlignment,
          popoverPadding: popoverPadding,
          dialogTitle: dialogTitle,
          initialViewType: initialViewType,
          stateBuilder: stateBuilder,
        );
      },
    );
  }
}

/// A date picker widget for selecting dates.
///
/// Provides a date selection interface with calendar view in either
/// popover or dialog mode.
class VNLDatePicker extends StatelessWidget {
  /// The currently selected date value.
  final DateTime? value;

  /// Callback invoked when the selected date changes.
  final ValueChanged<DateTime?>? onChanged;

  /// Placeholder widget shown when no date is selected.
  final Widget? placeholder;

  /// The display mode for the date picker (popover or dialog).
  final VNLPromptMode? mode;

  /// The initial calendar view to display.
  final VNLCalendarView? initialView;

  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Title widget for the dialog mode.
  final Widget? dialogTitle;

  /// The initial calendar view type (date, month, or year).
  final VNLCalendarViewType? initialViewType;

  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;

  /// Whether the date picker is enabled.
  final bool? enabled;

  /// Creates a date picker.
  const VNLDatePicker({
    super.key,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.mode,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    VNLookLocalizations localizations = VNLookLocalizations.of(context);
    final compTheme = VNLComponentTheme.maybeOf<VNLDatePickerTheme>(context);
    final resolvedMode = styleValue(
      widgetValue: mode,
      themeValue: compTheme?.mode,
      defaultValue: VNLPromptMode.dialog,
    );
    final resolvedAlignment = styleValue(
      widgetValue: popoverAlignment,
      themeValue: compTheme?.popoverAlignment,
      defaultValue: Alignment.topLeft,
    );
    final resolvedAnchorAlignment = styleValue(
      widgetValue: popoverAnchorAlignment,
      themeValue: compTheme?.popoverAnchorAlignment,
      defaultValue: Alignment.bottomLeft,
    );
    final resolvedPadding = styleValue(
      widgetValue: popoverPadding,
      themeValue: compTheme?.popoverPadding,
      defaultValue: null,
    );
    final resolvedInitialView = styleValue(
      widgetValue: initialView,
      themeValue: compTheme?.initialView,
      defaultValue: VNLCalendarView.now(),
    );
    final resolvedInitialViewType = styleValue(
      widgetValue: initialViewType,
      themeValue: compTheme?.initialViewType,
      defaultValue: VNLCalendarViewType.date,
    );
    return ObjectFormField(
      dialogTitle: dialogTitle,
      enabled: enabled,
      popoverAlignment: resolvedAlignment,
      popoverAnchorAlignment: resolvedAnchorAlignment,
      popoverPadding: resolvedPadding,
      value: value,
      onChanged: onChanged,
      placeholder: placeholder ?? Text(localizations.placeholderDatePicker),
      trailing: const Icon(LucideIcons.calendarDays),
      builder: (context, value) {
        return Text(localizations.formatDateTime(value, showTime: false));
      },
      mode: resolvedMode,
      editorBuilder: (context, handler) {
        return VNLDatePickerDialog(
          initialView: resolvedInitialView,
          initialViewType: resolvedInitialViewType,
          selectionMode: VNLCalendarSelectionMode.single,
          initialValue: handler.value == null
              ? null
              : VNLCalendarValue.single(handler.value!),
          onChanged: (value) {
            handler.value =
                value == null ? null : (value as VNLSingleCalendarValue).date;
          },
          stateBuilder: stateBuilder,
        );
      },
    );
  }
}

/// Represents a range of dates with a start and end time.
///
/// Immutable value type for representing a continuous period between two dates.
/// Commonly used with date range pickers to specify selected date intervals.
///
/// Example:
/// ```dart
/// final range = VNLDateTimeRange(
///   DateTime(2024, 1, 1),
///   DateTime(2024, 1, 31),
/// );
/// ```
class VNLDateTimeRange {
  /// The start date/time of the range.
  final DateTime start;

  /// The end date/time of the range.
  final DateTime end;

  /// Creates a [VNLDateTimeRange].
  ///
  /// Parameters:
  /// - [start] (`DateTime`, required): The beginning of the range.
  /// - [end] (`DateTime`, required): The end of the range.
  const VNLDateTimeRange(this.start, this.end);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLDateTimeRange && other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() {
    return 'VNLDateTimeRange{start: $start, end: $end}';
  }

  /// Creates a copy of this range with the given fields replaced.
  ///
  /// Parameters:
  /// - [start] (`ValueGetter<DateTime>?`, optional): New start date.
  /// - [end] (`ValueGetter<DateTime>?`, optional): New end date.
  ///
  /// Returns: A new [VNLDateTimeRange] with updated values.
  VNLDateTimeRange copyWith({
    ValueGetter<DateTime>? start,
    ValueGetter<DateTime>? end,
  }) {
    return VNLDateTimeRange(
      start == null ? this.start : start(),
      end == null ? this.end : end(),
    );
  }
}

/// A widget for selecting a date range.
///
/// Provides an interactive date range picker that allows users to select a start
/// and end date. Supports both dialog and popover presentation modes with
/// customizable calendar views and state management.
///
/// Example:
/// ```dart
/// VNLDateRangePicker(
///   value: currentRange,
///   onChanged: (range) => setState(() => currentRange = range),
///   mode: VNLPromptMode.dialog,
/// )
/// ```
class VNLDateRangePicker extends StatelessWidget {
  /// The currently selected date range.
  final VNLDateTimeRange? value;

  /// Callback when the date range changes.
  final ValueChanged<VNLDateTimeRange?>? onChanged;

  /// Placeholder widget shown when no range is selected.
  final Widget? placeholder;

  /// Presentation mode (dialog or popover).
  final VNLPromptMode mode;

  /// Initial calendar view to display.
  final VNLCalendarView? initialView;

  /// Initial view type (date, month, or year).
  final VNLCalendarViewType? initialViewType;

  /// Alignment of popover relative to anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Alignment of anchor for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Title widget for dialog mode.
  final Widget? dialogTitle;

  /// Callback to determine date state (enabled/disabled).
  final DateStateBuilder? stateBuilder;

  /// Creates a [VNLDateRangePicker].
  ///
  /// Parameters:
  /// - [value] (`VNLDateTimeRange?`, required): Current selected range.
  /// - [onChanged] (`ValueChanged<VNLDateTimeRange?>?`, optional): Called when range changes.
  /// - [placeholder] (`Widget?`, optional): Shown when no range selected.
  /// - [mode] (`VNLPromptMode`, default: `VNLPromptMode.dialog`): Presentation mode.
  /// - [initialView] (`VNLCalendarView?`, optional): Starting calendar view.
  /// - [initialViewType] (`VNLCalendarViewType?`, optional): Starting view type.
  /// - [popoverAlignment] (`AlignmentGeometry?`, optional): VNLPopover alignment.
  /// - [popoverAnchorAlignment] (`AlignmentGeometry?`, optional): Anchor alignment.
  /// - [popoverPadding] (`EdgeInsetsGeometry?`, optional): VNLPopover padding.
  /// - [dialogTitle] (`Widget?`, optional): Dialog title.
  /// - [stateBuilder] (`DateStateBuilder?`, optional): Date state callback.
  const VNLDateRangePicker({
    super.key,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.mode = VNLPromptMode.dialog,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    VNLookLocalizations localizations = VNLookLocalizations.of(context);
    return ObjectFormField(
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      popoverPadding: popoverPadding,
      value: value,
      mode: mode,
      onChanged: onChanged,
      dialogTitle: dialogTitle,
      placeholder: placeholder ?? Text(localizations.placeholderDatePicker),
      trailing: const Icon(LucideIcons.calendarRange),
      builder: (context, value) {
        return Text(
          '${localizations.formatDateTime(value.start, showTime: false)} - ${localizations.formatDateTime(value.end, showTime: false)}',
        );
      },
      editorBuilder: (context, handler) {
        VNLDateTimeRange? value = handler.value;
        return LayoutBuilder(
          builder: (context, constraints) {
            return VNLDatePickerDialog(
              initialView: initialView,
              initialViewType: initialViewType ?? VNLCalendarViewType.date,
              selectionMode: VNLCalendarSelectionMode.range,
              viewMode: constraints.biggest.width < 500
                  ? VNLCalendarSelectionMode.single
                  : VNLCalendarSelectionMode.range,
              initialValue: value == null
                  ? null
                  : VNLCalendarValue.range(value.start, value.end),
              onChanged: (value) {
                if (value == null) {
                  handler.value = null;
                } else {
                  final range = value.toRange();
                  handler.value = VNLDateTimeRange(range.start, range.end);
                }
              },
              stateBuilder: stateBuilder,
            );
          },
        );
      },
    );
  }
}
