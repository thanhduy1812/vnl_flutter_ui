import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Extension methods for [VNLookLocalizations] to provide additional formatting and utility functions.
extension ShadcnLocalizationsExtensions on VNLookLocalizations {
  /// The order of date parts for the current locale.
  ///
  /// Default is [VNLDatePart.month], [VNLDatePart.day], [VNLDatePart.year].
  List<VNLDatePart> get datePartsOrder => const [
        VNLDatePart.month,
        VNLDatePart.day,
        VNLDatePart.year,
      ];

  /// The abbreviation for the year component (e.g., 'YYYY').
  String get dateYearAbbreviation => 'YYYY';

  /// The abbreviation for the month component (e.g., 'MM').
  String get dateMonthAbbreviation => 'MM';

  /// The abbreviation for the day component (e.g., 'DD').
  String get dateDayAbbreviation => 'DD';

  /// Gets the abbreviation for a specific [VNLDatePart].
  String getDatePartAbbreviation(VNLDatePart part) {
    switch (part) {
      case VNLDatePart.year:
        return dateYearAbbreviation;
      case VNLDatePart.month:
        return dateMonthAbbreviation;
      case VNLDatePart.day:
        return dateDayAbbreviation;
    }
  }

  /// Formats a [DateTime] object into a string.
  ///
  /// [showDate] - Whether to include the date part.
  /// [showTime] - Whether to include the time part.
  /// [showSeconds] - Whether to include seconds in the time part.
  /// [use24HourFormat] - Whether to use 24-hour format for time.
  String formatDateTime(DateTime dateTime,
      {bool showDate = true,
      bool showTime = true,
      bool showSeconds = false,
      bool use24HourFormat = true}) {
    String result = '';
    if (showDate) {
      result += '${getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    }
    if (showTime) {
      if (use24HourFormat) {
        if (result.isNotEmpty) {
          result += ' ';
        }
        result += '${dateTime.hour}:${dateTime.minute}';
        if (showSeconds) {
          result += ':${dateTime.second}';
        }
      } else {
        if (result.isNotEmpty) {
          result += ' ';
        }
        int hour = dateTime.hour;
        if (hour > 12) {
          hour -= 12;
          result += '$hour:${dateTime.minute} $timePM';
        } else {
          result += '$hour:${dateTime.minute} $timeAM';
        }
      }
    }
    return result;
  }

  /// Formats a [TimeOfDay] object into a string.
  ///
  /// [use24HourFormat] - Whether to use 24-hour format.
  /// [showSeconds] - Whether to include seconds.
  String formatTimeOfDay(TimeOfDay time,
      {bool use24HourFormat = true, bool showSeconds = false}) {
    String result = '';
    if (use24HourFormat) {
      result +=
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      if (showSeconds) {
        result += ':${time.second.toString().padLeft(2, '0')}';
      }
    } else {
      int hour = time.hour;
      if (hour > 12) {
        hour -= 12;
        if (showSeconds) {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')} $timePM';
        } else {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $timePM';
        }
      } else {
        if (showSeconds) {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')} $timeAM';
        } else {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $timeAM';
        }
      }
    }
    return result;
  }

  /// Formats a number as a string, removing decimal point if it's an integer.
  String formatNumber(double value) {
    // if the value is an integer, return it as an integer
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  /// Gets the localized label for a [VNLColorPickerMode].
  String getColorPickerMode(VNLColorPickerMode mode) {
    switch (mode) {
      case VNLColorPickerMode.rgb:
        return colorPickerTabRGB;
      case VNLColorPickerMode.hsv:
        return colorPickerTabHSV;
      case VNLColorPickerMode.hsl:
        return colorPickerTabHSL;
      case VNLColorPickerMode.hex:
        return colorPickerTabHEX;
    }
  }

  /// Gets the abbreviated weekday name for a given weekday index (1-7).
  String getAbbreviatedWeekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return abbreviatedMonday;
      case DateTime.tuesday:
        return abbreviatedTuesday;
      case DateTime.wednesday:
        return abbreviatedWednesday;
      case DateTime.thursday:
        return abbreviatedThursday;
      case DateTime.friday:
        return abbreviatedFriday;
      case DateTime.saturday:
        return abbreviatedSaturday;
      case DateTime.sunday:
        return abbreviatedSunday;
      default:
        throw ArgumentError.value(weekday, 'weekday');
    }
  }

  /// Gets the full month name for a given month index (1-12).
  String getMonth(int month) {
    switch (month) {
      case DateTime.january:
        return monthJanuary;
      case DateTime.february:
        return monthFebruary;
      case DateTime.march:
        return monthMarch;
      case DateTime.april:
        return monthApril;
      case DateTime.may:
        return monthMay;
      case DateTime.june:
        return monthJune;
      case DateTime.july:
        return monthJuly;
      case DateTime.august:
        return monthAugust;
      case DateTime.september:
        return monthSeptember;
      case DateTime.october:
        return monthOctober;
      case DateTime.november:
        return monthNovember;
      case DateTime.december:
        return monthDecember;
      default:
        throw ArgumentError.value(month, 'month');
    }
  }

  /// Gets the abbreviated month name for a given month index (1-12).
  String getAbbreviatedMonth(int month) {
    switch (month) {
      case DateTime.january:
        return abbreviatedJanuary;
      case DateTime.february:
        return abbreviatedFebruary;
      case DateTime.march:
        return abbreviatedMarch;
      case DateTime.april:
        return abbreviatedApril;
      case DateTime.may:
        return abbreviatedMay;
      case DateTime.june:
        return abbreviatedJune;
      case DateTime.july:
        return abbreviatedJuly;
      case DateTime.august:
        return abbreviatedAugust;
      case DateTime.september:
        return abbreviatedSeptember;
      case DateTime.october:
        return abbreviatedOctober;
      case DateTime.november:
        return abbreviatedNovember;
      case DateTime.december:
        return abbreviatedDecember;
      default:
        throw ArgumentError.value(month, 'month');
    }
  }

  /// Formats a [Duration] into a string.
  ///
  /// [showDays] - Whether to show days.
  /// [showHours] - Whether to show hours.
  /// [showMinutes] - Whether to show minutes.
  /// [showSeconds] - Whether to show seconds.
  String formatDuration(Duration duration,
      {bool showDays = true,
      bool showHours = true,
      bool showMinutes = true,
      bool showSeconds = true}) {
    final days = duration.inDays;
    final hours = duration.inHours % Duration.hoursPerDay;
    final minutes = duration.inMinutes % Duration.minutesPerHour;
    final seconds = duration.inSeconds % Duration.secondsPerMinute;
    final parts = <String>[];
    if (showDays && days > 0) {
      parts.add('${days}d');
    }
    if (showHours && hours > 0) {
      parts.add('${hours}h');
    }
    if (showMinutes && minutes > 0) {
      parts.add('${minutes}m');
    }
    if (showSeconds && seconds > 0) {
      parts.add('${seconds}s');
    }
    return parts.join(' ');
  }

  /// Gets the abbreviation for a [VNLDurationPart].
  String getDurationPartAbbreviation(VNLDurationPart part) {
    switch (part) {
      case VNLDurationPart.day:
        return timeDaysAbbreviation;
      case VNLDurationPart.hour:
        return timeHoursAbbreviation;
      case VNLDurationPart.minute:
        return timeMinutesAbbreviation;
      case VNLDurationPart.second:
        return timeSecondsAbbreviation;
    }
  }

  /// Gets the abbreviation for a [VNLTimePart].
  String getTimePartAbbreviation(VNLTimePart part) {
    switch (part) {
      case VNLTimePart.hour:
        return timeHoursAbbreviation;
      case VNLTimePart.minute:
        return timeMinutesAbbreviation;
      case VNLTimePart.second:
        return timeSecondsAbbreviation;
    }
  }
}
