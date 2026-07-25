import 'package:flutter/services.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

/// Reactive date input field with integrated date picker and text editing.
///
/// A high-level date input widget that combines text field functionality with
/// date picker integration. Provides automatic state management through the
/// controlled component pattern with support for both dialog and popover modes.
///
/// ## Features
///
/// - **Dual input modes**: Text field editing with date picker integration
/// - **Multiple presentation modes**: Dialog or popover-based date selection
/// - **Flexible date formatting**: Customizable date part ordering and separators
/// - **VNLCalendar integration**: Rich calendar interface with multiple view types
/// - **VNLForm integration**: Automatic validation and form field registration
/// - **Accessibility**: Full screen reader and keyboard navigation support
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = VNLDatePickerController(DateTime.now());
///
/// VNLDateInput(
///   controller: controller,
///   mode: VNLPromptMode.popover,
///   placeholder: Text('Select date'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// DateTime? selectedDate;
///
/// VNLDateInput(
///   initialValue: selectedDate,
///   onChanged: (date) => setState(() => selectedDate = date),
///   mode: VNLPromptMode.dialog,
///   dialogTitle: Text('Choose Date'),
/// )
/// ```
class VNLDateInput extends StatefulWidget with ControlledComponent<DateTime?> {
  @override
  final DateTime? initialValue;
  @override
  final ValueChanged<DateTime?>? onChanged;
  @override
  final bool enabled;
  @override
  final VNLDatePickerController? controller;

  /// Placeholder widget shown when no date is selected.
  final Widget? placeholder;

  /// Presentation mode for date picker (dialog or popover).
  final VNLPromptMode mode;

  /// Initial calendar view to display.
  final VNLCalendarView? initialView;

  /// Alignment of popover relative to anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Alignment of anchor for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Title widget for dialog mode.
  final Widget? dialogTitle;

  /// Initial view type (date, month, or year).
  final VNLCalendarViewType? initialViewType;

  /// Callback to determine date state (enabled/disabled).
  final DateStateBuilder? stateBuilder;

  /// Order of date components in the input display.
  final List<VNLDatePart>? datePartsOrder;

  /// Separator widget between date parts.
  final VNLInputPart? separator;

  /// Custom placeholders for individual date parts.
  final Map<VNLDatePart, Widget>? placeholders;

  /// Creates a [VNLDateInput].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with flexible date picker integration options.
  ///
  /// Parameters:
  /// - [controller] (VNLDatePickerController?, optional): external state controller
  /// - [initialValue] (DateTime?, optional): starting date when no controller
  /// - [onChanged] (`ValueChanged<DateTime?>?`, optional): date change callback
  /// - [enabled] (bool, default: true): whether input is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no date selected
  /// - [mode] (VNLPromptMode, default: dialog): date picker presentation mode
  /// - [initialView] (VNLCalendarView?, optional): starting calendar view
  /// - [popoverAlignment] (AlignmentGeometry?, optional): popover alignment
  /// - [popoverAnchorAlignment] (AlignmentGeometry?, optional): anchor alignment
  /// - [popoverPadding] (EdgeInsetsGeometry?, optional): popover padding
  /// - [dialogTitle] (Widget?, optional): title for dialog mode
  /// - [initialViewType] (VNLCalendarViewType?, optional): calendar view type
  /// - [stateBuilder] (DateStateBuilder?, optional): custom date state builder
  /// - [datePartsOrder] (`List<VNLDatePart>?`, optional): order of date components
  /// - [separator] (VNLInputPart?, optional): separator between date parts
  /// - [placeholders] (`Map<VNLDatePart, Widget>?`, optional): placeholders for date parts
  ///
  /// Example:
  /// ```dart
  /// VNLDateInput(
  ///   controller: controller,
  ///   mode: VNLPromptMode.popover,
  ///   placeholder: Text('Select date'),
  ///   datePartsOrder: [VNLDatePart.month, VNLDatePart.day, VNLDatePart.year],
  /// )
  /// ```
  const VNLDateInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.mode = VNLPromptMode.dialog,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
    this.datePartsOrder,
    this.separator,
    this.placeholders,
  });

  @override
  State<VNLDateInput> createState() => _DateInputState();
}

/// Represents a date with nullable components (year, month, day).
///
/// Useful for date input scenarios where individual date parts may be
/// missing or incomplete. Can convert to [DateTime] when all parts are present.
///
/// Example:
/// ```dart
/// final date = VNLNullableDate(year: 2024, month: 1, day: 15);
/// print(date.nullableDate); // DateTime(2024, 1, 15)
/// ```
class VNLNullableDate {
  /// The year component (nullable).
  final int? year;

  /// The month component (nullable).
  final int? month;

  /// The day component (nullable).
  final int? day;

  /// Creates a [VNLNullableDate].
  ///
  /// Parameters:
  /// - [year] (`int?`, optional): Year value.
  /// - [month] (`int?`, optional): Month value (1-12).
  /// - [day] (`int?`, optional): Day value (1-31).
  VNLNullableDate({this.year, this.month, this.day});

  @override
  String toString() {
    return 'VNLNullableDate{year: $year, month: $month, day: $day}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLNullableDate && other.year == year && other.month == month && other.day == day;
  }

  @override
  int get hashCode => Object.hash(year, month, day);

  /// Creates a copy with specified parts replaced.
  ///
  /// Parameters:
  /// - [year] (`ValueGetter<int?>?`, optional): New year value.
  /// - [month] (`ValueGetter<int?>?`, optional): New month value.
  /// - [day] (`ValueGetter<int?>?`, optional): New day value.
  ///
  /// Returns: A new [VNLNullableDate] with updated parts.
  VNLNullableDate copyWith({
    ValueGetter<int?>? year,
    ValueGetter<int?>? month,
    ValueGetter<int?>? day,
  }) {
    return VNLNullableDate(
      year: year == null ? this.year : year(),
      month: month == null ? this.month : month(),
      day: day == null ? this.day : day(),
    );
  }

  /// Converts to [DateTime], using 1 for missing parts (month/day) to avoid year shift.
  ///
  /// Returns: A [DateTime] instance (may be invalid if parts are null/0).
  DateTime get date {
    return DateTime(year ?? 0, month ?? 1, day ?? 1);
  }

  /// Converts to [DateTime] only if all parts are present.
  ///
  /// Returns: A [DateTime] if complete, otherwise null.
  DateTime? get nullableDate {
    if (year == null || month == null || day == null) {
      return null;
    }
    return date;
  }

  /// Converts to [DateTime] with default values if any part is null.
  ///
  /// Parameters:
  /// - [defaultYear] (`int`, optional): Default year value (0-9999).
  /// - [defaultMonth] (`int`, optional): Default month value (1-12).
  /// - [defaultDay] (`int`, optional): Default day value (1-31).
  ///
  /// Returns: A [DateTime] instance with non-null parts.
  DateTime? getDateTime(
      {int? defaultYear = 0, int? defaultMonth = 1, int? defaultDay = 1}) {
    int? year = this.year ?? defaultYear;
    int? month = this.month ?? defaultMonth;
    int? day = this.day ?? defaultDay;
    if (year == null || month == null || day == null) {
      return null;
    }
    return DateTime(year, month, day);
  }

  /// Retrieves the value of a specific date part.
  ///
  /// Parameters:
  /// - [part] (`VNLDatePart`, required): The date part to retrieve.
  ///
  /// Returns: The value of the specified part, or null if not set.
  int? operator [](VNLDatePart part) {
    switch (part) {
      case VNLDatePart.year:
        return year;
      case VNLDatePart.month:
        return month;
      case VNLDatePart.day:
        return day;
    }
  }

  /// Converts to a map of date parts.
  ///
  /// Returns: A `Map<VNLDatePart, int>` with non-null parts.
  Map<VNLDatePart, int> toMap() {
    return {
      if (year != null) VNLDatePart.year: year!,
      if (month != null) VNLDatePart.month: month!,
      if (day != null) VNLDatePart.day: day!,
    };
  }
}

class _DateInputState extends State<VNLDateInput> {
  late ComponentController<VNLNullableDate> _controller;

  VNLNullableDate _convertToDateTime(List<String?> values) {
    Map<VNLDatePart, String?> parts = {};
    var datePartsOrder = widget.datePartsOrder ?? VNLookLocalizations.of(context).datePartsOrder;
    for (int i = 0; i < values.length; i++) {
      parts[datePartsOrder[i]] = values[i];
    }
    String? yearString = parts[VNLDatePart.year];
    String? monthString = parts[VNLDatePart.month];
    String? dayString = parts[VNLDatePart.day];
    int? year = yearString == null || yearString.isEmpty ? null : int.tryParse(yearString);
    int? month = monthString == null || monthString.isEmpty ? null : int.tryParse(monthString);
    int? day = dayString == null || dayString.isEmpty ? null : int.tryParse(dayString);
    return VNLNullableDate(year: year, month: month, day: day);
  }

  List<String?> _convertFromDateTime(VNLNullableDate? value) {
    var datePartsOrder = widget.datePartsOrder ?? VNLookLocalizations.of(context).datePartsOrder;
    if (value == null) {
      return datePartsOrder.map((part) => null).toList();
    }
    var validDateTime = value.getDateTime(
      defaultYear: datePartsOrder.contains(VNLDatePart.year) ? null : 0,
      defaultMonth: datePartsOrder.contains(VNLDatePart.month) ? null : 1,
      defaultDay: datePartsOrder.contains(VNLDatePart.day) ? null : 1,
    );
    if (validDateTime == null) {
      return datePartsOrder.map((part) => null).toList();
    }
    return datePartsOrder.map((part) {
      switch (part) {
        case VNLDatePart.year:
          return validDateTime.year.toString();
        case VNLDatePart.month:
          return validDateTime.month.toString();
        case VNLDatePart.day:
          return validDateTime.day.toString();
      }
    }).toList();
  }

  double _getWidth(VNLDatePart part) {
    switch (part) {
      case VNLDatePart.year:
        return 60;
      case VNLDatePart.month:
        return 40;
      case VNLDatePart.day:
        return 40;
    }
  }

  Widget _getPlaceholder(VNLDatePart part) {
    var localizations = VNLookLocalizations.of(context);
    return Text(localizations.getDatePartAbbreviation(part));
  }

  int _getLength(VNLDatePart part) {
    switch (part) {
      case VNLDatePart.year:
        return 4;
      case VNLDatePart.month:
        return 2;
      case VNLDatePart.day:
        return 2;
    }
  }

  VNLNullableDate _convertToNullableDate(DateTime? value) {
    if (value == null) {
      return VNLNullableDate();
    }
    return VNLNullableDate(year: value.year, month: value.month, day: value.day);
  }

  DateTime? _convertFromNullableDate(VNLNullableDate value) {
    return value.getDateTime();
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller == null
        ? VNLComponentValueController<VNLNullableDate>(_convertToNullableDate(widget.initialValue))
        : VNLConvertedController<DateTime?, VNLNullableDate>(
            widget.controller!,
            BiDirectionalConvert(_convertToNullableDate, _convertFromNullableDate),
          );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var datePartsOrder = widget.datePartsOrder ?? VNLookLocalizations.of(context).datePartsOrder;
    return FormattedObjectInput<VNLNullableDate>(
      popupBuilder: (context, controller) {
        return VNLSurfaceCard(
          child: VNLDatePickerDialog(
            initialViewType: widget.initialViewType ?? VNLCalendarViewType.date,
            selectionMode: VNLCalendarSelectionMode.single,
            initialValue: controller.value == null ? null : VNLCalendarValue.single(controller.value!.date),
            initialView: widget.initialView ?? VNLCalendarView.now(),
            stateBuilder: widget.stateBuilder,
            onChanged: (value) {
              var date = value?.toSingle().date;
              controller.value = VNLNullableDate(
                year: date?.year,
                month: date?.month,
                day: date?.day,
              );
            },
          ),
        );
      },
      popoverIcon: const Icon(LucideIcons.calendarDays),
      converter: BiDirectionalConvert(_convertFromDateTime, _convertToDateTime),
      controller: _controller,
      initialValue: _convertToNullableDate(widget.initialValue),
      onChanged: (value) {
        widget.onChanged?.call(value == null ? null : _convertFromNullableDate(value));
      },
      parts: datePartsOrder
          .map(
            (part) {
              return VNLInputPart.editable(
                  length: _getLength(part),
                  width: _getWidth(part),
                  placeholder: widget.placeholders?[part] ?? _getPlaceholder(part),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ]);
            },
          )
          .joinSeparator(const VNLInputPart.static('/'))
          .toList(),
    );
  }
}

/// Represents a time with nullable components (hour, minute, second).
///
/// Useful for time input scenarios where individual time parts may be
/// missing or incomplete. Can convert to [TimeOfDay] when hour and minute are present.
///
/// Example:
/// ```dart
/// final time = VNLNullableTimeOfDay(hour: 14, minute: 30, second: 0);
/// print(time.toTimeOfDay); // TimeOfDay(hour: 14, minute: 30)
/// ```
class VNLNullableTimeOfDay {
  /// The hour component (nullable, 0-23).
  final int? hour;

  /// The minute component (nullable, 0-59).
  final int? minute;

  /// The second component (nullable, 0-59).
  final int? second;

  /// Creates a [VNLNullableTimeOfDay].
  ///
  /// Parameters:
  /// - [hour] (`int?`, optional): Hour value (0-23).
  /// - [minute] (`int?`, optional): Minute value (0-59).
  /// - [second] (`int?`, optional): Second value (0-59).
  VNLNullableTimeOfDay({this.hour, this.minute, this.second});

  @override
  String toString() {
    return 'VNLNullableTimeOfDay{hour: $hour, minute: $minute, second: $second}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLNullableTimeOfDay && other.hour == hour && other.minute == minute && other.second == second;
  }

  @override
  int get hashCode => Object.hash(hour, minute, second);

  /// Creates a copy with specified parts replaced.
  ///
  /// Parameters:
  /// - [hour] (`ValueGetter<int?>?`, optional): New hour value.
  /// - [minute] (`ValueGetter<int?>?`, optional): New minute value.
  /// - [second] (`ValueGetter<int?>?`, optional): New second value.
  ///
  /// Returns: A new [VNLNullableTimeOfDay] with updated parts.
  VNLNullableTimeOfDay copyWith({
    ValueGetter<int?>? hour,
    ValueGetter<int?>? minute,
    ValueGetter<int?>? second,
  }) {
    return VNLNullableTimeOfDay(
      hour: hour == null ? this.hour : hour(),
      minute: minute == null ? this.minute : minute(),
      second: second == null ? this.second : second(),
    );
  }

  /// Converts to [TimeOfDay] if hour and minute are present.
  ///
  /// Returns: A [TimeOfDay] instance, or null if hour, minute or second is null.
  TimeOfDay? get toTimeOfDay {
    if (hour == null || minute == null || second == null) {
      return null;
    }
    return TimeOfDay(hour: hour!, minute: minute!, second: second!);
  }

  /// Converts to [TimeOfDay] with default values if any part is null.
  ///
  /// Parameters:
  /// - [defaultHour] (`int`, optional): Default hour value (0-23).
  /// - [defaultMinute] (`int`, optional): Default minute value (0-59).
  /// - [defaultSecond] (`int`, optional): Default second value (0-59).
  ///
  /// Returns: A [TimeOfDay] instance with non-null parts.
  TimeOfDay? getTimeOfDay(
      {int? defaultHour = 0, int? defaultMinute = 0, int? defaultSecond = 0}) {
    int? hour = this.hour ?? defaultHour;
    int? minute = this.minute ?? defaultMinute;
    int? second = this.second ?? defaultSecond;
    if (hour == null || minute == null || second == null) {
      return null;
    }
    return TimeOfDay(hour: hour, minute: minute, second: second);
  }

  /// Creates a [VNLNullableTimeOfDay] from a [TimeOfDay].
  ///
  /// Parameters:
  /// - [timeOfDay] (`TimeOfDay?`, optional): The time to convert.
  ///
  /// Returns: A [VNLNullableTimeOfDay] instance, or null if input is null.
  static VNLNullableTimeOfDay? fromTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return null;
    }
    return VNLNullableTimeOfDay(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
      second: timeOfDay.second,
    );
  }

  /// Retrieves the value of a specific time part.
  ///
  /// Parameters:
  /// - [part] (`VNLTimePart`, required): The time part to retrieve.
  ///
  /// Returns: The value of the specified part, or null if not set.
  int? operator [](VNLTimePart part) {
    switch (part) {
      case VNLTimePart.hour:
        return hour;
      case VNLTimePart.minute:
        return minute;
      case VNLTimePart.second:
        return second;
    }
  }

  /// Converts to a map of time parts.
  ///
  /// Returns: A `Map<VNLTimePart, int>` with non-null parts.
  Map<VNLTimePart, int> toMap() {
    return {
      if (hour != null) VNLTimePart.hour: hour!,
      if (minute != null) VNLTimePart.minute: minute!,
      if (second != null) VNLTimePart.second: second!,
    };
  }
}

/// Reactive time input field with formatted text editing and validation.
///
/// A high-level time input widget that provides structured time entry through
/// formatted text fields. Supports hours, minutes, and optional seconds with
/// automatic state management through the controlled component pattern.
///
/// ## Features
///
/// - **Structured time entry**: Separate fields for hours, minutes, and seconds
/// - **Format validation**: Automatic validation and formatting of time components
/// - **Flexible display**: Optional seconds display and customizable separators
/// - **VNLForm integration**: Automatic validation and form field registration
/// - **Keyboard navigation**: Tab navigation between time components
/// - **Accessibility**: Full screen reader support and keyboard input
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = ComponentController<TimeOfDay?>(TimeOfDay.now());
///
/// VNLTimeInput(
///   controller: controller,
///   showSeconds: true,
///   placeholder: Text('Enter time'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// TimeOfDay? selectedTime;
///
/// VNLTimeInput(
///   initialValue: selectedTime,
///   onChanged: (time) => setState(() => selectedTime = time),
///   showSeconds: false,
///   separator: VNLInputPart.text(':'),
/// )
/// ```
class VNLTimeInput extends StatefulWidget with ControlledComponent<TimeOfDay?> {
  @override
  final TimeOfDay? initialValue;
  @override
  final ValueChanged<TimeOfDay?>? onChanged;
  @override
  final bool enabled;
  @override
  final ComponentController<TimeOfDay?>? controller;

  /// Placeholder widget shown when no time is selected.
  final Widget? placeholder;

  /// Whether to show seconds input field.
  final bool showSeconds;

  /// Separator widget between time parts.
  final VNLInputPart? separator;

  /// Custom placeholders for individual time parts.
  final Map<VNLTimePart, Widget>? placeholders;

  /// Creates a [VNLTimeInput].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with structured time component entry.
  ///
  /// Parameters:
  /// - [controller] (`ComponentController<TimeOfDay?>?`, optional): external state controller
  /// - [initialValue] (TimeOfDay?, optional): starting time when no controller
  /// - [onChanged] (`ValueChanged<TimeOfDay?>?`, optional): time change callback
  /// - [enabled] (bool, default: true): whether input is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no time selected
  /// - [showSeconds] (bool, default: false): whether to include seconds input
  /// - [separator] (VNLInputPart?, optional): separator between time components
  /// - [placeholders] (`Map<VNLTimePart, Widget>?`, optional): placeholders for time parts
  ///
  /// Example:
  /// ```dart
  /// VNLTimeInput(
  ///   controller: controller,
  ///   showSeconds: true,
  ///   separator: VNLInputPart.text(':'),
  ///   placeholders: {
  ///     VNLTimePart.hour: Text('HH'),
  ///     VNLTimePart.minute: Text('MM'),
  ///     VNLTimePart.second: Text('SS'),
  ///   },
  /// )
  /// ```
  const VNLTimeInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.showSeconds = false,
    this.separator,
    this.placeholders,
  });

  @override
  State<VNLTimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<VNLTimeInput> {
  late ComponentController<VNLNullableTimeOfDay> _controller;

  VNLNullableTimeOfDay _convertToTimeOfDay(List<String?> values) {
    int? hour = values[0] == null || values[0]!.isEmpty ? null : int.tryParse(values[0]!);
    int? minute = values[1] == null || values[1]!.isEmpty ? null : int.tryParse(values[1]!);
    int? second = widget.showSeconds && values.length > 2
        ? (values[2] == null || values[2]!.isEmpty ? null : int.tryParse(values[2]!))
        : null;
    return VNLNullableTimeOfDay(hour: hour, minute: minute, second: second);
  }

  List<String?> _convertFromTimeOfDay(VNLNullableTimeOfDay? value) {
    if (value == null) {
      return [null, null, if (widget.showSeconds) null];
    }
    final nullableTimeOfDay = value.getTimeOfDay(
      defaultHour: null,
      defaultMinute: null,
      defaultSecond: widget.showSeconds ? null : 0,
    );
    if (nullableTimeOfDay == null) {
      return [null, null, if (widget.showSeconds) null];
    }
    return [
      nullableTimeOfDay.hour.toString(),
      nullableTimeOfDay.minute.toString(),
      if (widget.showSeconds) nullableTimeOfDay.second.toString(),
    ];
  }

  double _getWidth(VNLTimePart part) {
    return 40;
  }

  Widget _getPlaceholder(VNLTimePart part) {
    var localizations = VNLookLocalizations.of(context);
    return Text(localizations.getTimePartAbbreviation(part));
  }

  int _getLength(VNLTimePart part) {
    return 2;
  }

  VNLNullableTimeOfDay _convertToNullableTimeOfDay(TimeOfDay? value) {
    if (value == null) {
      return VNLNullableTimeOfDay();
    }
    return VNLNullableTimeOfDay(
      hour: value.hour,
      minute: value.minute,
      second: widget.showSeconds ? value.second : null,
    );
  }

  TimeOfDay? _convertFromNullableTimeOfDay(VNLNullableTimeOfDay value) {
    return value.getTimeOfDay(
      defaultSecond: widget.showSeconds ? null : 0,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller == null
        ? VNLComponentValueController<VNLNullableTimeOfDay>(_convertToNullableTimeOfDay(widget.initialValue))
        : VNLConvertedController<TimeOfDay?, VNLNullableTimeOfDay>(
            widget.controller!,
            BiDirectionalConvert(_convertToNullableTimeOfDay, _convertFromNullableTimeOfDay),
          );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormattedObjectInput<VNLNullableTimeOfDay>(
      converter: BiDirectionalConvert(_convertFromTimeOfDay, _convertToTimeOfDay),
      controller: _controller,
      initialValue: _convertToNullableTimeOfDay(widget.initialValue),
      onChanged: (value) {
        widget.onChanged?.call(value == null ? null : _convertFromNullableTimeOfDay(value));
      },
      parts: [
        VNLInputPart.editable(
          length: _getLength(VNLTimePart.hour),
          width: _getWidth(VNLTimePart.hour),
          placeholder: widget.placeholders?[VNLTimePart.hour] ?? _getPlaceholder(VNLTimePart.hour),
        ),
        widget.separator ?? const VNLInputPart.static(':'),
        VNLInputPart.editable(
          length: _getLength(VNLTimePart.minute),
          width: _getWidth(VNLTimePart.minute),
          placeholder: widget.placeholders?[VNLTimePart.minute] ?? _getPlaceholder(VNLTimePart.minute),
        ),
        if (widget.showSeconds) ...[
          widget.separator ?? const VNLInputPart.static(':'),
          VNLInputPart.editable(
            length: _getLength(VNLTimePart.second),
            width: _getWidth(VNLTimePart.second),
            placeholder: widget.placeholders?[VNLTimePart.second] ?? _getPlaceholder(VNLTimePart.second),
          ),
        ],
      ],
    );
  }
}

/// Reactive duration input field with formatted text editing and validation.
///
/// A high-level duration input widget that provides structured duration entry through
/// formatted text fields. Supports hours, minutes, and optional seconds with
/// automatic state management through the controlled component pattern.
///
/// ## Features
///
/// - **Structured duration entry**: Separate fields for hours, minutes, and seconds
/// - **Format validation**: Automatic validation and formatting of duration components
/// - **Flexible display**: Optional seconds display and customizable separators
/// - **Large value support**: Handle durations spanning multiple hours or days
/// - **VNLForm integration**: Automatic validation and form field registration
/// - **Keyboard navigation**: Tab navigation between duration components
/// - **Accessibility**: Full screen reader support and keyboard input
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = ComponentController<Duration?>(Duration(hours: 1, minutes: 30));
///
/// VNLDurationInput(
///   controller: controller,
///   showSeconds: true,
///   placeholder: Text('Enter duration'),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// Duration? selectedDuration;
///
/// VNLDurationInput(
///   initialValue: selectedDuration,
///   onChanged: (duration) => setState(() => selectedDuration = duration),
///   showSeconds: false,
///   separator: VNLInputPart.text(':'),
/// )
/// ```
class VNLDurationInput extends StatefulWidget with ControlledComponent<Duration?> {
  @override
  final Duration? initialValue;
  @override
  final ValueChanged<Duration?>? onChanged;
  @override
  final bool enabled;
  @override
  final ComponentController<Duration?>? controller;

  /// Placeholder widget shown when no duration is selected.
  final Widget? placeholder;

  /// Whether to show seconds input field.
  final bool showSeconds;

  /// Separator widget between duration parts.
  final VNLInputPart? separator;

  /// Custom placeholders for individual time parts.
  final Map<VNLTimePart, Widget>? placeholders;

  /// Creates a [VNLDurationInput].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with structured duration component entry.
  ///
  /// Parameters:
  /// - [controller] (`ComponentController<Duration?>?`, optional): external state controller
  /// - [initialValue] (Duration?, optional): starting duration when no controller
  /// - [onChanged] (`ValueChanged<Duration?>?`, optional): duration change callback
  /// - [enabled] (bool, default: true): whether input is interactive
  /// - [placeholder] (Widget?, optional): widget shown when no duration selected
  /// - [showSeconds] (bool, default: false): whether to include seconds input
  /// - [separator] (VNLInputPart?, optional): separator between duration components
  /// - [placeholders] (`Map<VNLTimePart, Widget>?`, optional): placeholders for time parts
  ///
  /// Example:
  /// ```dart
  /// VNLDurationInput(
  ///   controller: controller,
  ///   showSeconds: true,
  ///   separator: VNLInputPart.text(':'),
  ///   placeholders: {
  ///     VNLTimePart.hour: Text('HH'),
  ///     VNLTimePart.minute: Text('MM'),
  ///     VNLTimePart.second: Text('SS'),
  ///   },
  /// )
  /// ```
  const VNLDurationInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.showSeconds = false,
    this.separator,
    this.placeholders,
  });

  @override
  State<VNLDurationInput> createState() => _DurationInputState();
}

class _DurationInputState extends State<VNLDurationInput> {
  late ComponentController<VNLNullableTimeOfDay> _controller;

  VNLNullableTimeOfDay _convertToDuration(List<String?> values) {
    int? hours = values[0] == null || values[0]!.isEmpty ? null : int.tryParse(values[0]!);
    int? minutes = values[1] == null || values[1]!.isEmpty ? null : int.tryParse(values[1]!);
    int? seconds = widget.showSeconds && values.length > 2
        ? (values[2] == null || values[2]!.isEmpty ? null : int.tryParse(values[2]!))
        : null;
    return VNLNullableTimeOfDay(hour: hours, minute: minutes, second: seconds);
  }

  List<String?> _convertFromDuration(VNLNullableTimeOfDay? value) {
    if (value == null) {
      return [null, null, if (widget.showSeconds) null];
    }
    final nullableTimeOfDay = value.getTimeOfDay(
      defaultHour: null,
      defaultMinute: null,
      defaultSecond: widget.showSeconds ? null : 0,
    );
    if (nullableTimeOfDay == null) {
      return [null, null, if (widget.showSeconds) null];
    }
    return [
      nullableTimeOfDay.hour.toString(),
      nullableTimeOfDay.minute.toString(),
      if (widget.showSeconds) nullableTimeOfDay.second.toString(),
    ];
  }

  double _getWidth(VNLTimePart part) {
    return 40;
  }

  Widget _getPlaceholder(VNLTimePart part) {
    var localizations = VNLookLocalizations.of(context);
    return Text(localizations.getTimePartAbbreviation(part));
  }

  int _getLength(VNLTimePart part) {
    return 2;
  }

  VNLNullableTimeOfDay _convertToNullableTimeOfDay(Duration? value) {
    if (value == null) {
      return VNLNullableTimeOfDay();
    }
    return VNLNullableTimeOfDay(
      hour: value.inHours,
      minute: value.inMinutes % 60,
      second: widget.showSeconds ? value.inSeconds % 60 : null,
    );
  }

  Duration? _convertFromNullableTimeOfDay(VNLNullableTimeOfDay value) {
    if (value.hour == null || value.minute == null || (widget.showSeconds && value.second == null)) {
      return null;
    }
    return Duration(
      hours: value.hour!,
      minutes: value.minute!,
      seconds: widget.showSeconds ? (value.second ?? 0) : 0,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller == null
        ? VNLComponentValueController<VNLNullableTimeOfDay>(_convertToNullableTimeOfDay(widget.initialValue))
        : VNLConvertedController<Duration?, VNLNullableTimeOfDay>(
            widget.controller!,
            BiDirectionalConvert(_convertToNullableTimeOfDay, _convertFromNullableTimeOfDay),
          );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormattedObjectInput<VNLNullableTimeOfDay>(
      converter: BiDirectionalConvert(_convertFromDuration, _convertToDuration),
      controller: _controller,
      initialValue: _convertToNullableTimeOfDay(widget.initialValue),
      onChanged: (value) {
        widget.onChanged?.call(value == null ? null : _convertFromNullableTimeOfDay(value));
      },
      parts: [
        VNLInputPart.editable(
          length: _getLength(VNLTimePart.hour),
          width: _getWidth(VNLTimePart.hour),
          placeholder: widget.placeholders?[VNLTimePart.hour] ?? _getPlaceholder(VNLTimePart.hour),
        ),
        widget.separator ?? const VNLInputPart.static(':'),
        VNLInputPart.editable(
          length: _getLength(VNLTimePart.minute),
          width: _getWidth(VNLTimePart.minute),
          placeholder: widget.placeholders?[VNLTimePart.minute] ?? _getPlaceholder(VNLTimePart.minute),
        ),
        if (widget.showSeconds) ...[
          widget.separator ?? const VNLInputPart.static(':'),
          VNLInputPart.editable(
            length: _getLength(VNLTimePart.second),
            width: _getWidth(VNLTimePart.second),
            placeholder: widget.placeholders?[VNLTimePart.second] ?? _getPlaceholder(VNLTimePart.second),
          ),
        ],
      ],
    );
  }
}
