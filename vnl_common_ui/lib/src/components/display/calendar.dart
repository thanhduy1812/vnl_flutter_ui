import 'package:flutter/foundation.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Theme configuration for calendar widgets.
///
/// Provides styling options for calendar components, including arrow icon colors
/// for navigation buttons and other visual elements.
class VNLCalendarTheme extends ComponentThemeData {
  /// Color of navigation arrow icons.
  final Color? arrowIconColor;

  /// Creates a [CalendarTheme].
  ///
  /// Parameters:
  /// - [arrowIconColor] (`Color?`, optional): Color for navigation arrow icons.
  const VNLCalendarTheme({this.arrowIconColor});

  /// Creates a copy of this theme with the given fields replaced.
  VNLCalendarTheme copyWith({ValueGetter<Color?>? arrowIconColor}) {
    return VNLCalendarTheme(
        arrowIconColor:
            arrowIconColor == null ? this.arrowIconColor : arrowIconColor());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLCalendarTheme && other.arrowIconColor == arrowIconColor;
  }

  @override
  int get hashCode => arrowIconColor.hashCode;
}

/// Defines the different view types available in calendar components.
///
/// Specifies what granularity of time selection is displayed.
enum VNLCalendarViewType {
  /// Shows individual days in a month grid.
  date,

  /// Shows months in a year grid.
  month,

  /// Shows years in a decade grid.
  year,
}

/// Represents the interactive state of a date in the calendar.
///
/// Controls whether a specific date can be selected or interacted with.
enum VNLDateState {
  /// Date cannot be selected or clicked.
  disabled,

  /// Date is fully interactive and selectable.
  enabled,
}

/// Callback function type for determining the state of calendar dates.
///
/// Takes a [DateTime] and returns a [VNLDateState] to control whether
/// that date should be enabled or disabled for user interaction.
typedef DateStateBuilder = VNLDateState Function(DateTime date);

/// Selection modes available for calendar components.
///
/// Determines how users can select dates in calendar widgets.
enum VNLCalendarSelectionMode {
  /// No date selection allowed (display only).
  none,

  /// Only one date can be selected at a time.
  single,

  /// Two dates can be selected to form a date range.
  range,

  /// Multiple individual dates can be selected.
  multi,
}

/// A date picker dialog that provides comprehensive date selection capabilities.
///
/// Displays a modal dialog containing a calendar interface with support for
/// different view types (date, month, year), selection modes (single, range, multi),
/// and customizable date states. Includes navigation controls and responsive layouts.
///
/// Features:
/// - Multiple view types: date grid, month grid, year grid
/// - Various selection modes: single date, date range, multiple dates
/// - Navigation arrows with keyboard support
/// - Customizable date state validation
/// - Dual-calendar layout for range selection
/// - Theme integration and localization support
///
/// Example:
/// ```dart
/// VNLDatePickerDialog(
///   initialViewType: VNLCalendarViewType.date,
///   selectionMode: VNLCalendarSelectionMode.single,
///   initialValue: VNLCalendarValue.single(DateTime.now()),
///   onChanged: (value) => print('Selected: $value'),
/// )
/// ```
class VNLDatePickerDialog extends StatefulWidget {
  /// The initial view type to display (date, month, or year grid).
  final VNLCalendarViewType initialViewType;

  /// The initial calendar view position (month/year to display).
  final VNLCalendarView? initialView;

  /// The selection mode determining how dates can be selected.
  final VNLCalendarSelectionMode selectionMode;

  /// Alternative view mode for display purposes.
  final VNLCalendarSelectionMode? viewMode;

  /// The initially selected date value(s).
  final VNLCalendarValue? initialValue;

  /// Callback invoked when the selected date(s) change.
  final ValueChanged<VNLCalendarValue?>? onChanged;

  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;

  /// Creates a [VNLDatePickerDialog] with comprehensive date selection options.
  ///
  /// Configures the dialog's initial state, selection behavior, and callbacks
  /// for handling date changes and validation.
  ///
  /// Parameters:
  /// - [initialViewType] (VNLCalendarViewType, required): Starting view (date/month/year)
  /// - [initialView] (VNLCalendarView?, optional): Initial calendar view position
  /// - [selectionMode] (VNLCalendarSelectionMode, required): How dates can be selected
  /// - [viewMode] (VNLCalendarSelectionMode?, optional): Alternative view mode for display
  /// - [initialValue] (VNLCalendarValue?, optional): Pre-selected date(s)
  /// - [onChanged] (`ValueChanged<VNLCalendarValue>?`, optional): Called when selection changes
  /// - [stateBuilder] (DateStateBuilder?, optional): Custom date state validation
  ///
  /// Example:
  /// ```dart
  /// VNLDatePickerDialog(
  ///   initialViewType: VNLCalendarViewType.date,
  ///   selectionMode: VNLCalendarSelectionMode.range,
  ///   onChanged: (value) => handleDateChange(value),
  ///   stateBuilder: (date) => date.isBefore(DateTime.now())
  ///     ? VNLDateState.disabled
  ///     : VNLDateState.enabled,
  /// )
  /// ```
  const VNLDatePickerDialog({
    super.key,
    required this.initialViewType,
    this.initialView,
    required this.selectionMode,
    this.viewMode,
    this.initialValue,
    this.onChanged,
    this.stateBuilder,
  });

  @override
  State<VNLDatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<VNLDatePickerDialog> {
  late VNLCalendarView _view;
  late VNLCalendarView _alternateView;
  late VNLCalendarValue? _value;
  late VNLCalendarViewType _viewType;
  late int _yearSelectStart;
  bool _alternate = false;

  @override
  void initState() {
    super.initState();
    _view =
        widget.initialView ?? widget.initialValue?.view ?? VNLCalendarView.now();
    _alternateView = _view.next;
    _value = widget.initialValue;
    _viewType = widget.initialViewType;
    // _yearSelectStart = round year every 16 years so that it can fit 4x4 grid
    _yearSelectStart = (_view.year ~/ 16) * 16;
  }

  @override
  void didUpdateWidget(covariant VNLDatePickerDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialView != oldWidget.initialView ||
        widget.initialValue != oldWidget.initialValue) {
      _view =
          widget.initialView ?? widget.initialValue?.view ?? VNLCalendarView.now();
      _alternateView = _view.next;
      _yearSelectStart = (_view.year ~/ 16) * 16;
    }
    if (widget.initialValue != oldWidget.initialValue) {
      _value = widget.initialValue;
    }
    if (widget.initialViewType != oldWidget.initialViewType) {
      _viewType = widget.initialViewType;
    }
  }

  String getHeaderText(VNLookLocalizations localizations, VNLCalendarView view,
      VNLCalendarViewType viewType) {
    if (viewType == VNLCalendarViewType.date) {
      return '${localizations.getMonth(view.month)} ${view.year}';
    }
    if (viewType == VNLCalendarViewType.month) {
      return '${view.year}';
    }
    return localizations.datePickerSelectYear;
  }

  @override
  Widget build(BuildContext context) {
    VNLookLocalizations localizations = VNLookLocalizations.of(context);
    final theme = Theme.of(context);
    final compTheme = VNLComponentTheme.maybeOf<VNLCalendarTheme>(context);
    final arrowColor =
        styleValue(themeValue: compTheme?.arrowIconColor, defaultValue: null);
    final viewMode = widget.viewMode ?? widget.selectionMode;
    if (widget.selectionMode == VNLCalendarSelectionMode.range) {
      return IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VNLOutlineButton(
                        density: VNLButtonDensity.icon,
                        onPressed: () {
                          setState(() {
                            switch (_viewType) {
                              case VNLCalendarViewType.date:
                                _view = _view.previous;
                                _alternateView = _alternateView.previous;
                                break;
                              case VNLCalendarViewType.month:
                                _view = _view.previousYear;
                                break;
                              case VNLCalendarViewType.year:
                                _yearSelectStart -= 16;
                                break;
                            }
                          });
                        },
                        child: Icon(LucideIcons.arrowLeft, color: arrowColor)
                            .iconXSmall(),
                      ),
                      SizedBox(
                        width: theme.scaling * 16,
                      ),
                      Expanded(
                        child: VNLGhostButton(
                          enabled: _viewType != VNLCalendarViewType.year,
                          onPressed: () {
                            _alternate = false;
                            switch (_viewType) {
                              case VNLCalendarViewType.date:
                                setState(() {
                                  _viewType = VNLCalendarViewType.month;
                                });
                                break;
                              case VNLCalendarViewType.month:
                                setState(() {
                                  _viewType = VNLCalendarViewType.year;
                                });
                                break;
                              default:
                                break;
                            }
                          },
                          child: Text(getHeaderText(
                                  localizations, _view, _viewType))
                              .foreground()
                              .small()
                              .medium()
                              .center(),
                        ).sized(height: theme.scaling * 32),
                      ),
                      if (_viewType == VNLCalendarViewType.date &&
                          viewMode == VNLCalendarSelectionMode.range)
                        SizedBox(
                          width: theme.scaling * 32,
                        ),
                      SizedBox(
                        width: theme.scaling * 16,
                      ),
                      if (_viewType != VNLCalendarViewType.date ||
                          viewMode != VNLCalendarSelectionMode.range)
                        VNLOutlineButton(
                          density: VNLButtonDensity.icon,
                          onPressed: () {
                            setState(() {
                              switch (_viewType) {
                                case VNLCalendarViewType.date:
                                  _view = _view.next;
                                  break;
                                case VNLCalendarViewType.month:
                                  _view = _view.nextYear;
                                  break;
                                case VNLCalendarViewType.year:
                                  _yearSelectStart += 16;
                                  break;
                              }
                            });
                          },
                          child: Icon(LucideIcons.arrowRight, color: arrowColor)
                              .iconXSmall(),
                        ),
                    ],
                  ),
                ),
                if (_viewType == VNLCalendarViewType.date &&
                    viewMode == VNLCalendarSelectionMode.range)
                  Gap(theme.density.baseGap * theme.scaling * 2),
                if (_viewType == VNLCalendarViewType.date &&
                    viewMode == VNLCalendarSelectionMode.range)
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: theme.scaling * (32 + 16),
                        ),
                        Expanded(
                          child: VNLGhostButton(
                            onPressed: () {
                              _alternate = true;
                              switch (_viewType) {
                                case VNLCalendarViewType.date:
                                  setState(() {
                                    _viewType = VNLCalendarViewType.month;
                                  });
                                  break;
                                case VNLCalendarViewType.month:
                                  setState(() {
                                    _viewType = VNLCalendarViewType.year;
                                  });
                                  break;
                                default:
                                  break;
                              }
                            },
                            child: Text(getHeaderText(
                                    localizations, _alternateView, _viewType))
                                .foreground()
                                .small()
                                .medium()
                                .center(),
                          ).sized(height: theme.scaling * 32),
                        ),
                        SizedBox(
                          width: theme.scaling * 16,
                        ),
                        VNLOutlineButton(
                          density: VNLButtonDensity.icon,
                          onPressed: () {
                            setState(() {
                              switch (_viewType) {
                                case VNLCalendarViewType.date:
                                  _view = _view.next;
                                  _alternateView = _alternateView.next;
                                  break;
                                case VNLCalendarViewType.month:
                                  _view = _view.nextYear;
                                  break;
                                case VNLCalendarViewType.year:
                                  _yearSelectStart += 16;
                                  break;
                              }
                            });
                          },
                          child: Icon(LucideIcons.arrowRight, color: arrowColor)
                              .iconXSmall(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Gap(theme.density.baseGap * theme.scaling * 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: viewMode == VNLCalendarSelectionMode.range
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: [
                buildView(
                  context,
                  _yearSelectStart,
                  _view,
                  _viewType,
                  widget.selectionMode,
                  (value) {
                    setState(() {
                      if (!_alternate) {
                        _view = value;
                        _alternateView = value.next;
                      } else {
                        _view = value.previous;
                        _alternateView = value;
                      }
                      switch (_viewType) {
                        case VNLCalendarViewType.date:
                          break;
                        case VNLCalendarViewType.month:
                          _viewType = VNLCalendarViewType.date;
                          break;
                        case VNLCalendarViewType.year:
                          _viewType = VNLCalendarViewType.month;
                          break;
                      }
                    });
                  },
                ),
                if (_viewType == VNLCalendarViewType.date &&
                    viewMode == VNLCalendarSelectionMode.range)
                  Gap(theme.density.baseGap * theme.scaling * 2),
                if (_viewType == VNLCalendarViewType.date &&
                    viewMode == VNLCalendarSelectionMode.range)
                  buildView(
                    context,
                    _yearSelectStart,
                    _alternateView,
                    _viewType,
                    widget.selectionMode,
                    (value) {},
                  ),
              ],
            ),
          ],
        ),
      );
    }
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              VNLOutlineButton(
                density: VNLButtonDensity.icon,
                onPressed: () {
                  setState(() {
                    switch (_viewType) {
                      case VNLCalendarViewType.date:
                        _view = _view.previous;
                        break;
                      case VNLCalendarViewType.month:
                        _view = _view.previousYear;
                        break;
                      case VNLCalendarViewType.year:
                        _yearSelectStart -= 16;
                        break;
                    }
                  });
                },
                child:
                    Icon(LucideIcons.arrowLeft, color: arrowColor).iconXSmall(),
              ),
              SizedBox(
                width: theme.scaling * 16,
              ),
              Expanded(
                child: VNLGhostButton(
                  enabled: _viewType != VNLCalendarViewType.year,
                  onPressed: () {
                    switch (_viewType) {
                      case VNLCalendarViewType.date:
                        setState(() {
                          _viewType = VNLCalendarViewType.month;
                        });
                        break;
                      case VNLCalendarViewType.month:
                        setState(() {
                          _viewType = VNLCalendarViewType.year;
                        });
                        break;
                      default:
                        break;
                    }
                  },
                  child: Text(getHeaderText(localizations, _view, _viewType))
                      .foreground()
                      .small()
                      .medium()
                      .center(),
                ).sized(height: theme.scaling * 32),
              ),
              SizedBox(
                width: theme.scaling * 16,
              ),
              VNLOutlineButton(
                density: VNLButtonDensity.icon,
                onPressed: () {
                  setState(() {
                    switch (_viewType) {
                      case VNLCalendarViewType.date:
                        _view = _view.next;
                        break;
                      case VNLCalendarViewType.month:
                        _view = _view.nextYear;
                        break;
                      case VNLCalendarViewType.year:
                        _yearSelectStart += 16;
                        break;
                    }
                  });
                },
                child: Icon(LucideIcons.arrowRight, color: arrowColor)
                    .iconXSmall(),
              ),
            ],
          ),
          Gap(theme.density.baseGap * theme.scaling * 2),
          buildView(
            context,
            _yearSelectStart,
            _view,
            _viewType,
            widget.selectionMode,
            (value) {
              setState(() {
                _view = value;
                switch (_viewType) {
                  case VNLCalendarViewType.date:
                    break;
                  case VNLCalendarViewType.month:
                    _viewType = VNLCalendarViewType.date;
                    break;
                  case VNLCalendarViewType.year:
                    _viewType = VNLCalendarViewType.month;
                    break;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildView(
      BuildContext context,
      int yearSelectStart,
      VNLCalendarView view,
      VNLCalendarViewType viewType,
      VNLCalendarSelectionMode selectionMode,
      ValueChanged<VNLCalendarView> onViewChanged) {
    if (viewType == VNLCalendarViewType.year) {
      return VNLYearCalendar(
        value: view.year,
        yearSelectStart: yearSelectStart,
        calendarValue: _value,
        stateBuilder: widget.stateBuilder,
        onChanged: (value) {
          setState(() {
            onViewChanged(view.copyWith(year: () => value));
          });
        },
      );
    }
    if (viewType == VNLCalendarViewType.month) {
      return VNLMonthCalendar(
        value: view,
        onChanged: onViewChanged,
        stateBuilder: widget.stateBuilder,
        calendarValue: _value,
      );
    }
    return VNLCalendar(
      value: _value,
      view: view,
      stateBuilder: widget.stateBuilder,
      onChanged: (value) {
        setState(() {
          _value = value;
          widget.onChanged?.call(value);
        });
      },
      selectionMode: selectionMode,
    );
  }
}

/// Abstract base class representing calendar selection values.
///
/// Provides a unified interface for different types of calendar selections including
/// single dates, date ranges, and multiple date collections. Handles date lookup
/// operations and conversion between different selection types.
///
/// Subclasses include:
/// - [VNLSingleCalendarValue]: Represents a single selected date
/// - [VNLRangeCalendarValue]: Represents a date range with start and end
/// - [VNLMultiCalendarValue]: Represents multiple individual selected dates
///
/// The class provides factory constructors for easy creation and conversion
/// methods to transform between different selection types as needed.
///
/// Example:
/// ```dart
/// // Create different value types
/// final single = VNLCalendarValue.single(DateTime.now());
/// final range = VNLCalendarValue.range(startDate, endDate);
/// final multi = VNLCalendarValue.multi([date1, date2, date3]);
///
/// // Check if a date is selected
/// final lookup = value.lookup(2024, 3, 15);
/// final isSelected = lookup != CalendarValueLookup.none;
/// ```
abstract class VNLCalendarValue {
  /// Looks up whether the specified date is part of this calendar value.
  ///
  /// Returns a [CalendarValueLookup] indicating the relationship of the
  /// queried date to this value (none, selected, start, end, or inRange).
  CalendarValueLookup lookup(int year, [int? month = 1, int? day = 1]);

  /// Creates a base calendar value.
  const VNLCalendarValue();

  /// Factory constructor to create a single date value.
  static VNLSingleCalendarValue single(DateTime date) {
    return VNLSingleCalendarValue(date);
  }

  /// Factory constructor to create a date range value.
  static VNLRangeCalendarValue range(DateTime start, DateTime end) {
    return VNLRangeCalendarValue(start, end);
  }

  /// Factory constructor to create a multi-date value.
  static VNLMultiCalendarValue multi(List<DateTime> dates) {
    return VNLMultiCalendarValue(dates);
  }

  /// Converts this value to a single calendar value.
  VNLSingleCalendarValue toSingle();

  /// Converts this value to a range calendar value.
  VNLRangeCalendarValue toRange();

  /// Converts this value to a multi calendar value.
  VNLMultiCalendarValue toMulti();

  /// Returns the calendar view associated with this value.
  VNLCalendarView get view;
}

DateTime _convertNecessarry(DateTime from, int year, [int? month, int? date]) {
  if (month == null) {
    return DateTime(from.year);
  }
  if (date == null) {
    return DateTime(from.year, from.month);
  }
  return DateTime(from.year, from.month, from.day);
}

/// VNLCalendar value representing a single selected date.
///
/// Encapsulates a single [DateTime] selection and provides lookup functionality
/// to determine if a given date matches the selected date. Used primarily
/// with [VNLCalendarSelectionMode.single].
///
/// Example:
/// ```dart
/// final singleValue = VNLSingleCalendarValue(DateTime(2024, 3, 15));
/// final lookup = singleValue.lookup(2024, 3, 15);
/// print(lookup == CalendarValueLookup.selected); // true
/// ```
class VNLSingleCalendarValue extends VNLCalendarValue {
  /// The selected date.
  final DateTime date;

  /// Creates a single calendar value with the specified date.
  VNLSingleCalendarValue(this.date);

  @override
  CalendarValueLookup lookup(int year, [int? month, int? day]) {
    DateTime current = _convertNecessarry(date, year, month, day);
    if (current.isAtSameMomentAs(DateTime(year, month ?? 1, day ?? 1))) {
      return CalendarValueLookup.selected;
    }
    return CalendarValueLookup.none;
  }

  @override
  VNLCalendarView get view => date.toCalendarView();

  @override
  String toString() {
    return 'VNLSingleCalendarValue($date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLSingleCalendarValue && other.date == date;
  }

  @override
  int get hashCode => date.hashCode;

  @override
  VNLSingleCalendarValue toSingle() {
    return this;
  }

  @override
  VNLRangeCalendarValue toRange() {
    return VNLCalendarValue.range(date, date);
  }

  @override
  VNLMultiCalendarValue toMulti() {
    return VNLCalendarValue.multi([date]);
  }
}

/// VNLCalendar value representing a date range selection.
///
/// Encapsulates a date range with start and end dates. Provides lookup
/// functionality to determine if a date is the start, end, within the range,
/// or outside. Used with [VNLCalendarSelectionMode.range].
///
/// The range is automatically normalized so start is always before or equal to end.
class VNLRangeCalendarValue extends VNLCalendarValue {
  /// The start date of the range (always <= end).
  final DateTime start;

  /// The end date of the range (always >= start).
  final DateTime end;

  /// Creates a range calendar value with the specified start and end dates.
  ///
  /// Automatically normalizes the range so [start] is before [end].
  VNLRangeCalendarValue(DateTime start, DateTime end)
      : start = start.isBefore(end) ? start : end,
        end = start.isBefore(end) ? end : start;

  @override
  CalendarValueLookup lookup(int year, [int? month, int? day]) {
    DateTime start = _convertNecessarry(this.start, year, month, day);
    DateTime end = _convertNecessarry(this.end, year, month, day);
    DateTime current = DateTime(year, month ?? 1, day ?? 1);
    if (current.isAtSameMomentAs(start) && current.isAtSameMomentAs(end)) {
      return CalendarValueLookup.selected;
    }
    if (current.isAtSameMomentAs(start)) {
      return CalendarValueLookup.start;
    }
    if (current.isAtSameMomentAs(end)) {
      return CalendarValueLookup.end;
    }
    if (current.isAfter(start) && current.isBefore(end)) {
      return CalendarValueLookup.inRange;
    }
    return CalendarValueLookup.none;
  }

  @override
  VNLCalendarView get view => start.toCalendarView();

  @override
  String toString() {
    return 'RangedCalendarValue($start, $end)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLRangeCalendarValue &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  VNLSingleCalendarValue toSingle() {
    return VNLCalendarValue.single(start);
  }

  @override
  VNLRangeCalendarValue toRange() {
    return this;
  }

  @override
  VNLMultiCalendarValue toMulti() {
    List<DateTime> dates = [];
    for (DateTime date = start;
        date.isBefore(end);
        date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }
    dates.add(end);
    return VNLCalendarValue.multi(dates);
  }
}

/// VNLCalendar value representing multiple selected dates.
///
/// Encapsulates a list of individually selected dates. Provides lookup
/// functionality to determine if a date is among the selected dates.
/// Used with [VNLCalendarSelectionMode.multi].
class VNLMultiCalendarValue extends VNLCalendarValue {
  /// The list of selected dates.
  final List<DateTime> dates;

  /// Creates a multi calendar value with the specified list of dates.
  VNLMultiCalendarValue(this.dates);

  @override
  CalendarValueLookup lookup(int year, [int? month, int? day]) {
    DateTime current = DateTime(year, month ?? 1, day ?? 1);
    if (dates.any((element) => _convertNecessarry(element, year, month, day)
        .isAtSameMomentAs(current))) {
      return CalendarValueLookup.selected;
    }
    return CalendarValueLookup.none;
  }

  @override
  VNLCalendarView get view =>
      dates.firstOrNull?.toCalendarView() ?? VNLCalendarView.now();

  @override
  String toString() {
    return 'VNLMultiCalendarValue($dates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLMultiCalendarValue && listEquals(other.dates, dates);
  }

  @override
  int get hashCode => dates.hashCode;

  @override
  VNLSingleCalendarValue toSingle() {
    return VNLCalendarValue.single(dates.first);
  }

  @override
  VNLRangeCalendarValue toRange() {
    assert(dates.isNotEmpty, 'Cannot convert empty list to range');
    DateTime min = dates
        .reduce((value, element) => value.isBefore(element) ? value : element);
    DateTime max = dates
        .reduce((value, element) => value.isAfter(element) ? value : element);
    return VNLCalendarValue.range(min, max);
  }

  @override
  VNLMultiCalendarValue toMulti() {
    return this;
  }
}

/// Result type for calendar value lookup operations.
///
/// Indicates the relationship between a queried date and the current calendar selection.
enum CalendarValueLookup {
  /// Date is not part of any selection.
  none,

  /// Date is directly selected (single mode or exact match).
  selected,

  /// Date is the start of a selected range.
  start,

  /// Date is the end of a selected range.
  end,

  /// Date falls within a selected range but is not start/end.
  inRange
}

/// Represents a specific month and year view in calendar navigation.
///
/// Provides immutable representation of a calendar's current viewing position
/// with navigation methods to move between months and years. Used to control
/// which month/year combination is displayed in calendar grids.
///
/// Key Features:
/// - **Navigation Methods**: [next], [previous], [nextYear], [previousYear]
/// - **Factory Constructors**: [now()], [fromDateTime()]
/// - **Validation**: Ensures month values stay within 1-12 range
/// - **Immutable**: All navigation returns new VNLCalendarView instances
///
/// Example:
/// ```dart
/// // Create views for different dates
/// final current = VNLCalendarView.now();
/// final specific = VNLCalendarView(2024, 3); // March 2024
/// final fromDate = VNLCalendarView.fromDateTime(someDateTime);
///
/// // Navigate between months
/// final nextMonth = current.next;
/// final prevMonth = current.previous;
/// final nextYear = current.nextYear;
/// ```
class VNLCalendarView {
  /// The year component of this view.
  final int year;

  /// The month component of this view (1-12).
  final int month;

  /// Creates a [VNLCalendarView] for the specified year and month.
  ///
  /// Parameters:
  /// - [year] (int): Four-digit year value
  /// - [month] (int): Month number (1-12, where 1 = January)
  ///
  /// Throws [AssertionError] if month is not between 1 and 12.
  ///
  /// Example:
  /// ```dart
  /// final view = VNLCalendarView(2024, 3); // March 2024
  /// ```
  VNLCalendarView(this.year, this.month) {
    assert(month >= 1 && month <= 12, 'Month must be between 1 and 12');
  }

  /// Creates a [VNLCalendarView] for the current month and year.
  ///
  /// Uses [DateTime.now()] to determine the current date and extracts
  /// the year and month components.
  ///
  /// Example:
  /// ```dart
  /// final currentView = VNLCalendarView.now();
  /// ```
  factory VNLCalendarView.now() {
    DateTime now = DateTime.now();
    return VNLCalendarView(now.year, now.month);
  }

  /// Creates a [VNLCalendarView] from an existing [DateTime].
  ///
  /// Extracts the year and month components from the provided [DateTime]
  /// and creates a corresponding calendar view.
  ///
  /// Parameters:
  /// - [dateTime] (DateTime): Date to extract year and month from
  ///
  /// Example:
  /// ```dart
  /// final birthday = DateTime(1995, 7, 15);
  /// final view = VNLCalendarView.fromDateTime(birthday); // July 1995
  /// ```
  factory VNLCalendarView.fromDateTime(DateTime dateTime) {
    return VNLCalendarView(dateTime.year, dateTime.month);
  }

  /// Returns a view for the next month.
  ///
  /// Advances to the next month, rolling over to January of the next year
  /// if the current month is December.
  VNLCalendarView get next {
    if (month == 12) {
      return VNLCalendarView(year + 1, 1);
    }
    return VNLCalendarView(year, month + 1);
  }

  /// Returns a view for the previous month.
  ///
  /// Moves back to the previous month, rolling back to December of the previous
  /// year if the current month is January.
  VNLCalendarView get previous {
    if (month == 1) {
      return VNLCalendarView(year - 1, 12);
    }
    return VNLCalendarView(year, month - 1);
  }

  /// Returns a view for the next year with the same month.
  VNLCalendarView get nextYear {
    return VNLCalendarView(year + 1, month);
  }

  /// Returns a view for the previous year with the same month.
  VNLCalendarView get previousYear {
    return VNLCalendarView(year - 1, month);
  }

  @override
  String toString() {
    return 'VNLCalendarView($year, $month)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLCalendarView && other.year == year && other.month == month;
  }

  @override
  int get hashCode => year.hashCode ^ month.hashCode;

  /// Creates a copy of this view with the given fields replaced.
  VNLCalendarView copyWith({
    ValueGetter<int>? year,
    ValueGetter<int>? month,
  }) {
    return VNLCalendarView(
      year == null ? this.year : year(),
      month == null ? this.month : month(),
    );
  }
}

/// Extension methods on [DateTime] for calendar operations.
extension CalendarDateTime on DateTime {
  /// Converts this DateTime to a VNLCalendarView.
  VNLCalendarView toCalendarView() {
    return VNLCalendarView.fromDateTime(this);
  }

  /// Converts this DateTime to a single VNLCalendarValue.
  VNLCalendarValue toCalendarValue() {
    return VNLCalendarValue.single(this);
  }
}

/// A highly customizable calendar widget supporting multiple selection modes.
///
/// Displays a grid-based calendar interface allowing users to view and select dates
/// with comprehensive support for single selection, range selection, and multiple
/// date selection. Includes built-in date validation, state management, and theme integration.
///
/// Key Features:
/// - **Selection Modes**: Single date, date range, multiple dates, or display-only
/// - **Date Validation**: Custom date state builder for enabling/disabling dates
/// - **Interactive Grid**: Touch/click support with visual feedback
/// - **Theme Integration**: Follows shadcn_flutter design system
/// - **Accessibility**: Screen reader and keyboard navigation support
/// - **Customizable Appearance**: Themed colors, spacing, and visual states
///
/// The calendar automatically handles date logic, leap years, month boundaries,
/// and provides consistent visual feedback for different selection states.
///
/// Selection Behavior:
/// - **Single**: Click to select one date, click again to deselect
/// - **Range**: Click start date, then end date to form range
/// - **Multi**: Click multiple dates to build selection set
/// - **None**: Display-only mode with no interaction
///
/// Example:
/// ```dart
/// VNLCalendar(
///   view: VNLCalendarView.now(),
///   selectionMode: VNLCalendarSelectionMode.range,
///   value: VNLCalendarValue.range(startDate, endDate),
///   onChanged: (value) => setState(() => selectedDates = value),
///   stateBuilder: (date) => date.isBefore(DateTime.now())
///     ? VNLDateState.disabled
///     : VNLDateState.enabled,
/// )
/// ```
class VNLCalendar extends StatefulWidget {
  /// The current date for highlighting purposes (defaults to DateTime.now()).
  final DateTime? now;

  /// The currently selected date value(s).
  final VNLCalendarValue? value;

  /// The month and year view to display in the calendar.
  final VNLCalendarView view;

  /// The selection mode determining how dates can be selected.
  final VNLCalendarSelectionMode selectionMode;

  /// Callback invoked when the selected date(s) change.
  final ValueChanged<VNLCalendarValue?>? onChanged;

  /// Legacy function to determine if a date should be enabled.
  final bool Function(DateTime date)? isDateEnabled;

  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;

  /// Creates a [VNLCalendar] widget with flexible date selection capabilities.
  ///
  /// Configures the calendar's view, selection behavior, and interaction handling
  /// with comprehensive options for customization and validation.
  ///
  /// Parameters:
  /// - [view] (VNLCalendarView, required): Month/year to display in calendar grid
  /// - [selectionMode] (VNLCalendarSelectionMode, required): How dates can be selected
  /// - [now] (DateTime?, optional): Current date for highlighting, defaults to DateTime.now()
  /// - [value] (VNLCalendarValue?, optional): Currently selected date(s)
  /// - [onChanged] (`ValueChanged<VNLCalendarValue>?`, optional): Called when selection changes
  /// - [isDateEnabled] (bool Function(DateTime)?, optional): Legacy date validation function
  /// - [stateBuilder] (DateStateBuilder?, optional): Custom date state validation
  ///
  /// The [view] parameter determines which month and year are shown in the calendar grid.
  /// Use [VNLCalendarView.now()] for current month or [VNLCalendarView(year, month)] for specific dates.
  ///
  /// The [stateBuilder] takes precedence over [isDateEnabled] when both are provided.
  ///
  /// Example:
  /// ```dart
  /// VNLCalendar(
  ///   view: VNLCalendarView(2024, 3), // March 2024
  ///   selectionMode: VNLCalendarSelectionMode.single,
  ///   onChanged: (value) => print('Selected: ${value?.toString()}'),
  ///   stateBuilder: (date) => date.weekday == DateTime.sunday
  ///     ? VNLDateState.disabled
  ///     : VNLDateState.enabled,
  /// )
  /// ```
  const VNLCalendar({
    super.key,
    this.now,
    this.value,
    required this.view,
    required this.selectionMode,
    this.onChanged,
    this.isDateEnabled,
    this.stateBuilder,
  });

  @override
  State<VNLCalendar> createState() => _CalendarState();
}

class _CalendarState extends State<VNLCalendar> {
  late VNLCalendarGridData _gridData;

  @override
  void initState() {
    super.initState();
    _gridData =
        VNLCalendarGridData(month: widget.view.month, year: widget.view.year);
  }

  @override
  void didUpdateWidget(covariant VNLCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view.year != widget.view.year ||
        oldWidget.view.month != widget.view.month) {
      _gridData =
          VNLCalendarGridData(month: widget.view.month, year: widget.view.year);
    }
  }

  void _handleTap(DateTime date) {
    var calendarValue = widget.value;
    if (widget.selectionMode == VNLCalendarSelectionMode.none) {
      return;
    }
    if (widget.selectionMode == VNLCalendarSelectionMode.single) {
      if (calendarValue is VNLSingleCalendarValue &&
          date.isAtSameMomentAs(calendarValue.date)) {
        widget.onChanged?.call(null);
        return;
      }
      widget.onChanged?.call(VNLCalendarValue.single(date));
      return;
    }
    if (widget.selectionMode == VNLCalendarSelectionMode.multi) {
      if (calendarValue == null) {
        widget.onChanged?.call(VNLCalendarValue.single(date));
        return;
      }
      final lookup = calendarValue.lookup(date.year, date.month, date.day);
      if (lookup == CalendarValueLookup.none) {
        var multi = calendarValue.toMulti();
        (multi).dates.add(date);
        widget.onChanged?.call(multi);
        return;
      } else {
        var multi = calendarValue.toMulti();
        (multi).dates.remove(date);
        if (multi.dates.isEmpty) {
          widget.onChanged?.call(null);
          return;
        }
        widget.onChanged?.call(multi);
        return;
      }
    }
    if (widget.selectionMode == VNLCalendarSelectionMode.range) {
      if (calendarValue == null) {
        widget.onChanged?.call(VNLCalendarValue.single(date));
        return;
      }
      if (calendarValue is VNLMultiCalendarValue) {
        calendarValue = calendarValue.toRange();
      }
      if (calendarValue is VNLSingleCalendarValue) {
        DateTime selectedDate = calendarValue.date;
        if (date.isAtSameMomentAs(selectedDate)) {
          widget.onChanged?.call(null);
          return;
        }
        widget.onChanged?.call(VNLCalendarValue.range(selectedDate, date));
        return;
      }
      if (calendarValue is VNLRangeCalendarValue) {
        DateTime start = calendarValue.start;
        DateTime end = calendarValue.end;
        if (date.isBefore(start)) {
          widget.onChanged?.call(VNLCalendarValue.range(date, end));
          return;
        }
        if (date.isAfter(end)) {
          widget.onChanged?.call(VNLCalendarValue.range(start, date));
          return;
        }
        if (date.isAtSameMomentAs(start)) {
          widget.onChanged?.call(null);
          return;
        }
        if (date.isAtSameMomentAs(end)) {
          widget.onChanged?.call(VNLCalendarValue.single(end));
          return;
        }
        widget.onChanged?.call(VNLCalendarValue.range(start, date));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VNLCalendarGrid(
      data: _gridData,
      itemBuilder: (item) {
        DateTime date = item.date;
        CalendarValueLookup lookup =
            widget.value?.lookup(date.year, date.month, date.day) ??
                CalendarValueLookup.none;
        VNLCalendarItemType type = VNLCalendarItemType.none;
        switch (lookup) {
          case CalendarValueLookup.none:
            if (widget.now != null && widget.now!.isAtSameMomentAs(date)) {
              type = VNLCalendarItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = VNLCalendarItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = VNLCalendarItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = VNLCalendarItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = VNLCalendarItemType.inRange;
            break;
        }
        Widget calendarItem = VNLCalendarItem(
          type: type,
          indexAtRow: item.indexInRow,
          rowCount: 7,
          onTap: () {
            _handleTap(date);
          },
          state: widget.stateBuilder?.call(date) ?? VNLDateState.enabled,
          child: Text('${date.day}'),
        );
        if (item.fromAnotherMonth) {
          return Opacity(
            opacity: 0.5,
            child: calendarItem,
          );
        }
        return calendarItem;
      },
    );
  }
}

/// A calendar widget that displays months in a year grid.
///
/// Shows a 4x3 grid of months for year selection. Used as part of the calendar
/// navigation when users want to select a different month.
class VNLMonthCalendar extends StatelessWidget {
  /// The current calendar view (year to display).
  final VNLCalendarView value;

  /// Callback invoked when a month is selected.
  final ValueChanged<VNLCalendarView> onChanged;

  /// The current date for highlighting purposes.
  final DateTime? now;

  /// The currently selected calendar value.
  final VNLCalendarValue? calendarValue;

  /// Builder function to determine the state of each month.
  final DateStateBuilder? stateBuilder;

  /// Creates a month selection calendar.
  const VNLMonthCalendar({
    super.key,
    required this.value,
    required this.onChanged,
    this.now,
    this.calendarValue,
    this.stateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // same as VNLCalendar, but instead of showing date
    // it shows month in a 4x3 grid
    VNLookLocalizations localizations = VNLookLocalizations.of(context);
    List<Widget> rows = [];
    List<Widget> months = [];
    for (int i = 1; i <= 12; i++) {
      DateTime date = DateTime(value.year, i);
      VNLCalendarItemType type = VNLCalendarItemType.none;
      if (calendarValue != null) {
        final lookup = calendarValue!.lookup(date.year, date.month);
        switch (lookup) {
          case CalendarValueLookup.none:
            if (now != null &&
                DateTime(now!.year, now!.month).isAtSameMomentAs(date)) {
              type = VNLCalendarItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = VNLCalendarItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = VNLCalendarItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = VNLCalendarItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = VNLCalendarItemType.inRange;
            break;
        }
      } else {
        if (now != null &&
            DateTime(now!.year, now!.month).isAtSameMomentAs(date)) {
          type = VNLCalendarItemType.today;
        }
      }
      months.add(
        VNLCalendarItem(
          key: ValueKey(date),
          type: type,
          indexAtRow: (i - 1) % 4,
          rowCount: 4,
          onTap: () {
            onChanged(value.copyWith(month: () => i));
          },
          width: theme.scaling * 56,
          state: stateBuilder?.call(date) ?? VNLDateState.enabled,
          child: Text(localizations.getAbbreviatedMonth(i)),
        ),
      );
    }
    for (int i = 0; i < months.length; i += 4) {
      rows.add(Gap(theme.density.baseGap * theme.scaling));
      rows.add(Row(
        children: months.sublist(i, i + 4),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}

/// A calendar widget that displays years in a grid.
///
/// Shows a 4x4 grid of years for year selection. Used as part of the calendar
/// navigation when users want to select a different year.
class VNLYearCalendar extends StatelessWidget {
  /// The starting year for the grid display.
  final int yearSelectStart;

  /// The currently selected year value.
  final int value;

  /// Callback invoked when a year is selected.
  final ValueChanged<int> onChanged;

  /// The current date for highlighting purposes.
  final DateTime? now;

  /// The currently selected calendar value.
  final VNLCalendarValue? calendarValue;

  /// Builder function to determine the state of each year.
  final DateStateBuilder? stateBuilder;

  /// Creates a year selection calendar.
  const VNLYearCalendar({
    super.key,
    required this.yearSelectStart,
    required this.value,
    required this.onChanged,
    this.now,
    this.calendarValue,
    this.stateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // same as VNLCalendar, but instead of showing date
    // it shows year in a 4x4 grid
    List<Widget> rows = [];
    List<Widget> years = [];
    for (int i = yearSelectStart; i < yearSelectStart + 16; i++) {
      DateTime date = DateTime(i);
      VNLCalendarItemType type = VNLCalendarItemType.none;
      if (calendarValue != null) {
        final lookup = calendarValue!.lookup(date.year);
        switch (lookup) {
          case CalendarValueLookup.none:
            if (now != null && now!.year == date.year) {
              type = VNLCalendarItemType.today;
            }
            break;
          case CalendarValueLookup.selected:
            type = VNLCalendarItemType.selected;
            break;
          case CalendarValueLookup.start:
            type = VNLCalendarItemType.startRangeSelected;
            break;
          case CalendarValueLookup.end:
            type = VNLCalendarItemType.endRangeSelected;
            break;
          case CalendarValueLookup.inRange:
            type = VNLCalendarItemType.inRange;
            break;
        }
      } else {
        if (now != null && now!.year == date.year) {
          type = VNLCalendarItemType.today;
        }
      }
      years.add(
        VNLCalendarItem(
          key: ValueKey(date),
          type: type,
          indexAtRow: (i - yearSelectStart) % 4,
          rowCount: 4,
          onTap: () {
            onChanged(i);
          },
          width: theme.scaling * 56,
          state: stateBuilder?.call(date) ?? VNLDateState.enabled,
          child: Text('$i'),
        ),
      );
    }
    for (int i = 0; i < years.length; i += 4) {
      rows.add(Gap(theme.density.baseGap * theme.scaling));
      rows.add(Row(
        children: years.sublist(i, i + 4),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}

/// Visual states for individual calendar date items.
///
/// Defines the different visual appearances and behaviors that calendar date cells
/// can have based on their selection state and position within ranges.
enum VNLCalendarItemType {
  /// Normal unselected date.
  none,

  /// Current date highlighted.
  today,

  /// Single selected date or exact range boundary.
  selected,

  /// Date within a selected range but not start/end.
  inRange,

  /// Range start boundary in other months (same as startRangeSelected).
  startRange,

  /// Range end boundary in other months (same as endRangeSelected).
  endRange,

  /// Range start boundary in current month.
  startRangeSelected,

  /// Range end boundary in current month.
  endRangeSelected,

  /// Range start boundary in short ranges.
  startRangeSelectedShort,

  /// Range end boundary in short ranges (typically 2-day ranges).
  endRangeSelectedShort,

  /// Middle dates in short ranges (typically 2-day ranges).
  inRangeSelectedShort,
}

/// Individual calendar date cell with interactive behavior and visual states.
///
/// Represents a single date item within a calendar grid, handling touch interactions,
/// visual state management, and theme integration. Supports different visual states
/// for selection, ranges, and special dates like today.
///
/// Key Features:
/// - **Visual States**: Multiple appearance modes based on selection status
/// - **Interactive**: Touch/click handling with callbacks
/// - **Responsive Sizing**: Configurable width/height with theme scaling
/// - **Accessibility**: Screen reader support and focus management
/// - **State Management**: Enabled/disabled states with visual feedback
/// - **Range Support**: Special styling for range start/end/middle positions
///
/// The item automatically applies appropriate button styling based on its [type]
/// and handles edge cases for range visualization at row boundaries.
///
/// Example:
/// ```dart
/// VNLCalendarItem(
///   type: VNLCalendarItemType.selected,
///   indexAtRow: 2,
///   rowCount: 7,
///   state: VNLDateState.enabled,
///   onTap: () => handleDateTap(date),
///   child: Text('15'),
/// )
/// ```
class VNLCalendarItem extends StatelessWidget {
  /// The widget to display as the date content.
  final Widget child;

  /// The visual state type for this calendar item.
  final VNLCalendarItemType type;

  /// Callback invoked when the item is tapped.
  final VoidCallback? onTap;

  /// The position of this item in its row (0-indexed).
  final int indexAtRow;

  /// The total number of items per row.
  final int rowCount;

  /// Optional fixed width for the item.
  final double? width;

  /// Optional fixed height for the item.
  final double? height;

  /// The interaction state of this date (enabled/disabled).
  final VNLDateState state;

  /// Creates a calendar item with the specified properties.
  const VNLCalendarItem({
    super.key,
    required this.child,
    required this.type,
    required this.indexAtRow,
    required this.rowCount,
    this.onTap,
    this.width,
    this.height,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var type = this.type;
    if ((indexAtRow == 0 || indexAtRow == rowCount - 1) &&
        (type == VNLCalendarItemType.startRangeSelected ||
            type == VNLCalendarItemType.endRangeSelected ||
            type == VNLCalendarItemType.startRangeSelectedShort ||
            type == VNLCalendarItemType.endRangeSelectedShort)) {
      type = VNLCalendarItemType.selected;
    }
    switch (type) {
      case VNLCalendarItemType.none:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLGhostButton(
            density: VNLButtonDensity.compact,
            alignment: Alignment.center,
            enabled: state == VNLDateState.enabled,
            onPressed: onTap,
            child: child,
          ),
        );
      case VNLCalendarItemType.today:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLSecondaryButton(
            density: VNLButtonDensity.compact,
            alignment: Alignment.center,
            enabled: state == VNLDateState.enabled,
            onPressed: onTap,
            child: child,
          ),
        );
      case VNLCalendarItemType.selected:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLPrimaryButton(
            density: VNLButtonDensity.compact,
            alignment: Alignment.center,
            enabled: state == VNLDateState.enabled,
            onPressed: onTap,
            child: child,
          ),
        );
      case VNLCalendarItemType.inRange:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLButton(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == VNLDateState.enabled,
            style: const VNLButtonStyle(
              variance: VNLButtonVariance.secondary,
              density: VNLButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: indexAtRow == 0
                      ? BorderRadius.only(
                          topLeft: Radius.circular(theme.radiusMd),
                          bottomLeft: Radius.circular(theme.radiusMd),
                        )
                      : indexAtRow == rowCount - 1
                          ? BorderRadius.only(
                              topRight: Radius.circular(theme.radiusMd),
                              bottomRight: Radius.circular(theme.radiusMd),
                            )
                          : BorderRadius.zero,
                );
              },
            ),
            child: child,
          ),
        );
      case VNLCalendarItemType.startRange:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLButton(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == VNLDateState.enabled,
            style: const VNLButtonStyle(
              variance: VNLButtonVariance.secondary,
              density: VNLButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    bottomLeft: Radius.circular(theme.radiusMd),
                  ),
                );
              },
            ),
            child: child,
          ),
        );
      case VNLCalendarItemType.endRange:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLButton(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == VNLDateState.enabled,
            style: const VNLButtonStyle(
              variance: VNLButtonVariance.secondary,
              density: VNLButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(theme.radiusMd),
                    bottomRight: Radius.circular(theme.radiusMd),
                  ),
                );
              },
            ),
            child: child,
          ),
        );
      case VNLCalendarItemType.startRangeSelected:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: width ?? theme.scaling * 32,
                height: height ?? theme.scaling * 32,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    bottomLeft: Radius.circular(theme.radiusMd),
                  ),
                ),
              ),
              VNLPrimaryButton(
                density: VNLButtonDensity.compact,
                alignment: Alignment.center,
                enabled: state == VNLDateState.enabled,
                onPressed: onTap,
                child: child,
              ),
            ],
          ),
        );
      case VNLCalendarItemType.endRangeSelected:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                width: width ?? theme.scaling * 32,
                height: height ?? theme.scaling * 32,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(theme.radiusMd),
                    bottomRight: Radius.circular(theme.radiusMd),
                  ),
                ),
              ),
              VNLPrimaryButton(
                density: VNLButtonDensity.compact,
                alignment: Alignment.center,
                enabled: state == VNLDateState.enabled,
                onPressed: onTap,
                child: child,
              ),
            ],
          ),
        );
      case VNLCalendarItemType.startRangeSelectedShort:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLButton(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == VNLDateState.enabled,
            style: const VNLButtonStyle(
              variance: VNLButtonVariance.primary,
              density: VNLButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    bottomLeft: Radius.circular(theme.radiusMd),
                  ),
                );
              },
            ),
            child: child,
          ),
        );
      case VNLCalendarItemType.endRangeSelectedShort:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLButton(
            alignment: Alignment.center,
            onPressed: onTap,
            enabled: state == VNLDateState.enabled,
            style: const VNLButtonStyle(
              variance: VNLButtonVariance.primary,
              density: VNLButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(theme.radiusMd),
                    bottomRight: Radius.circular(theme.radiusMd),
                  ),
                );
              },
            ),
            child: child,
          ),
        );
      case VNLCalendarItemType.inRangeSelectedShort:
        return SizedBox(
          width: width ?? theme.scaling * 32,
          height: height ?? theme.scaling * 32,
          child: VNLButton(
            alignment: Alignment.center,
            enabled: state == VNLDateState.enabled,
            onPressed: onTap,
            style: const VNLButtonStyle(
              variance: VNLButtonVariance.primary,
              density: VNLButtonDensity.compact,
            ).copyWith(
              decoration: (context, states, value) {
                return (value as BoxDecoration).copyWith(
                  borderRadius: BorderRadius.zero,
                );
              },
            ),
            child: child,
          ),
        );
    }
  }
}

/// Data structure representing a complete calendar month grid.
///
/// Contains all the information needed to render a calendar grid including
/// dates from the current month and overflow dates from adjacent months
/// to fill complete weeks.
class VNLCalendarGridData {
  /// The month number (1-12) this grid represents.
  final int month;

  /// The year this grid represents.
  final int year;

  /// The list of calendar grid items including current and adjacent month dates.
  final List<VNLCalendarGridItem> items;

  /// Creates calendar grid data for the specified month and year.
  ///
  /// Automatically calculates and includes dates from previous and next months
  /// to fill complete weeks in the grid.
  factory VNLCalendarGridData({required int month, required int year}) {
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    int daysInMonth = DateTime(year, month == 12 ? 1 : month + 1, 0).day;

    int prevMonthDays = firstDayOfMonth.weekday;
    DateTime prevMonthLastDay =
        firstDayOfMonth.subtract(Duration(days: prevMonthDays));

    List<VNLCalendarGridItem> items = [];

    int itemCount = 0;

    if (prevMonthDays < 7) {
      for (int i = 0; i < prevMonthDays; i++) {
        int currentItemIndex = itemCount++;
        items.add(VNLCalendarGridItem(
          prevMonthLastDay.add(Duration(days: i)),
          currentItemIndex % 7,
          true,
          currentItemIndex ~/ 7,
        ));
      }
    }

    for (int i = 0; i < daysInMonth; i++) {
      int currentItemIndex = itemCount++;
      DateTime currentDay = DateTime(year, month, i + 1);
      items.add(VNLCalendarGridItem(
        currentDay,
        currentItemIndex % 7,
        false,
        currentItemIndex ~/ 7,
      ));
    }

    int remainingDays = (7 - (items.length % 7)) % 7;
    DateTime nextMonthFirstDay = DateTime(year, month + 1, 1);

    if (remainingDays < 7) {
      for (int i = 0; i < remainingDays; i++) {
        int currentItemIndex = itemCount++;
        items.add(VNLCalendarGridItem(
          nextMonthFirstDay.add(Duration(days: i)),
          currentItemIndex % 7,
          true,
          currentItemIndex ~/ 7,
        ));
      }
    }

    return VNLCalendarGridData._(month, year, items);
  }

  VNLCalendarGridData._(this.month, this.year, this.items);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLCalendarGridData &&
        other.month == month &&
        other.year == year &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode => Object.hash(month, year, items);
}

/// Individual item within a calendar grid representing a single date cell.
///
/// Contains metadata about a date's position and state within the calendar grid.
class VNLCalendarGridItem {
  /// The date this grid item represents.
  final DateTime date;

  /// The index of this item within its row (0-6 for day of week).
  final int indexInRow;

  /// The row index in the calendar grid.
  final int rowIndex;

  /// Whether this date belongs to a different month than the grid's primary month.
  final bool fromAnotherMonth;

  /// Creates a calendar grid item.
  VNLCalendarGridItem(
      this.date, this.indexInRow, this.fromAnotherMonth, this.rowIndex);

  /// Returns true if this item represents today's date.
  bool get isToday {
    DateTime now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLCalendarGridItem &&
        other.date.isAtSameMomentAs(date) &&
        other.indexInRow == indexInRow &&
        other.fromAnotherMonth == fromAnotherMonth &&
        other.rowIndex == rowIndex;
  }

  @override
  int get hashCode => Object.hash(date, indexInRow, fromAnotherMonth, rowIndex);
}

/// Widget that renders a calendar grid using provided data.
///
/// Takes calendar grid data and an item builder to render the visual grid
/// of calendar dates. Handles layout and arrangement of dates in a weekly grid.
class VNLCalendarGrid extends StatelessWidget {
  /// The grid data containing all calendar items to display.
  final VNLCalendarGridData data;

  /// Builder function to create widgets for each grid item.
  final Widget Function(VNLCalendarGridItem item) itemBuilder;

  /// Creates a calendar grid widget.
  const VNLCalendarGrid({
    super.key,
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = VNLookLocalizations.of(context);
    // return GridView.builder(
    //   shrinkWrap: true,
    //   itemCount: data.items.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 7,
    //     mainAxisSpacing: 0,
    //     crossAxisSpacing: 8 * theme.scaling,
    //   ),
    //   itemBuilder: (context, index) {
    //     return SizedBox(
    //       width: theme.scaling * 32,
    //       height: theme.scaling * 32,
    //       child: itemBuilder(data.items[index]),
    //     );
    //   },
    // );
    // do not use GridView because it doesn't support IntrinsicWidth
    List<Widget> rows = [];
    List<Widget> weekDays = [];
    for (int i = 0; i < 7; i++) {
      int weekday = ((i - 1) % 7) + 1;
      weekDays.add(
        Container(
          width: theme.scaling * 32,
          height: theme.scaling * 32,
          alignment: Alignment.center,
          child: Text(localizations.getAbbreviatedWeekday(weekday))
              .muted()
              .xSmall(),
        ),
      );
    }
    rows.add(Row(
      mainAxisSize: MainAxisSize.min,
      children: weekDays,
    ));
    for (int i = 0; i < data.items.length; i += 7) {
      rows.add(Row(
        mainAxisSize: MainAxisSize.min,
        children: data.items.sublist(i, i + 7).map((e) {
          return SizedBox(
            width: theme.scaling * 32,
            height: theme.scaling * 32,
            child: itemBuilder(e),
          );
        }).toList(),
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: theme.density.baseGap * theme.scaling,
      children: rows,
    );
  }
}
