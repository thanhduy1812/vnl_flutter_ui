import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';

import '../../../shadcn_flutter.dart';

/// Reactive controller for managing slider state with value operations.
///
/// Extends [ValueNotifier] to provide state management for slider widgets
/// using [VNLSliderValue] objects that support both single and range slider
/// configurations. Enables programmatic slider value changes and provides
/// convenient methods for common slider operations.
///
/// The controller manages [VNLSliderValue] objects which can represent either
/// single values or dual-thumb range values, providing unified state management
/// for different slider types.
///
/// Example:
/// ```dart
/// final controller = VNLSliderController(VNLSliderValue.single(0.5));
///
/// // React to changes
/// controller.addListener(() {
///   print('VNLSlider value: ${controller.value}');
/// });
///
/// // Programmatic control
/// controller.setValue(0.75);
/// controller.setRange(0.2, 0.8);
/// ```
class VNLSliderController extends ValueNotifier<VNLSliderValue>
    with ComponentController<VNLSliderValue> {
  /// Creates a [VNLSliderController] with the specified initial value.
  ///
  /// The [value] parameter provides the initial slider configuration as a
  /// [VNLSliderValue]. The controller notifies listeners when the value changes
  /// through any method calls or direct value assignment.
  ///
  /// Example:
  /// ```dart
  /// final controller = VNLSliderController(VNLSliderValue.single(0.3));
  /// ```
  VNLSliderController(super.value);

  /// Sets the slider to a single value configuration.
  ///
  /// Converts the slider to single-thumb mode with the specified [value].
  /// The value should be within the slider's min/max bounds.
  void setValue(double value) {
    this.value = VNLSliderValue.single(value);
  }

  /// Sets the slider to a range value configuration.
  ///
  /// Converts the slider to dual-thumb mode with the specified [start] and [end] values.
  /// The values should be within the slider's min/max bounds with start <= end.
  void setRange(double start, double end) {
    value = VNLSliderValue.ranged(start, end);
  }

  /// Returns true if the slider is in single-value mode.
  bool get isSingle => !value.isRanged;

  /// Returns true if the slider is in range mode.
  bool get isRanged => value.isRanged;

  /// Gets the current single value (valid only in single mode).
  ///
  /// Throws an exception if called when the slider is in range mode.
  double get singleValue => value.value;

  /// Gets the current range start value (valid only in range mode).
  ///
  /// Throws an exception if called when the slider is in single mode.
  double get rangeStart => value.start;

  /// Gets the current range end value (valid only in range mode).
  ///
  /// Throws an exception if called when the slider is in single mode.
  double get rangeEnd => value.end;
}

/// Reactive slider with automatic state management and controller support.
///
/// A high-level slider widget that provides automatic state management through
/// the controlled component pattern. Supports both single-value and range sliders
/// with comprehensive customization options for styling, behavior, and interaction.
///
/// ## Features
///
/// - **Single and range modes**: Unified interface for different slider types
/// - **Discrete divisions**: Optional snap-to-value behavior with tick marks
/// - **Keyboard navigation**: Full arrow key support with custom step sizes
/// - **Hint values**: Visual preview of suggested or default values
/// - **Accessibility support**: Screen reader compatibility and semantic labels
/// - **VNLForm integration**: Automatic validation and form field registration
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = VNLSliderController(VNLSliderValue.single(0.5));
///
/// VNLControlledSlider(
///   controller: controller,
///   min: 0.0,
///   max: 100.0,
///   divisions: 100,
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// double currentValue = 50.0;
///
/// VNLControlledSlider(
///   initialValue: VNLSliderValue.single(currentValue),
///   onChanged: (value) => setState(() => currentValue = value.single),
///   min: 0.0,
///   max: 100.0,
/// )
/// ```
class VNLControlledSlider extends StatelessWidget
    with ControlledComponent<VNLSliderValue> {
  @override
  final VNLSliderValue initialValue;
  @override
  final ValueChanged<VNLSliderValue>? onChanged;
  @override
  final VNLSliderController? controller;
  @override
  final bool enabled;

  /// Callback invoked when the user starts changing the slider value.
  ///
  /// Called once when the user begins dragging the slider thumb or interacting
  /// with the slider track. Receives the initial [VNLSliderValue] at the start of
  /// the interaction.
  final ValueChanged<VNLSliderValue>? onChangeStart;

  /// Callback invoked when the user finishes changing the slider value.
  ///
  /// Called once when the user releases the slider thumb or completes the
  /// interaction. Receives the final [VNLSliderValue] at the end of the interaction.
  final ValueChanged<VNLSliderValue>? onChangeEnd;

  /// The minimum value the slider can represent.
  ///
  /// Defaults to `0`. Must be less than [max].
  final double min;

  /// The maximum value the slider can represent.
  ///
  /// Defaults to `1`. Must be greater than [min].
  final double max;

  /// The number of discrete divisions the slider range is divided into.
  ///
  /// If `null`, the slider is continuous. If non-null, the slider will snap to
  /// discrete values in the range `[min, max]`.
  final int? divisions;

  /// An optional hint value displayed on the slider track.
  ///
  /// Provides visual feedback showing a target or reference value. The hint is
  /// typically rendered as a subtle marker on the track.
  final VNLSliderValue? hintValue;

  /// The step size for keyboard increment actions.
  ///
  /// When the user presses the increase key, the slider value will increase by
  /// this amount. If `null`, a default increment is used.
  final double? increaseStep;

  /// The step size for keyboard decrement actions.
  ///
  /// When the user presses the decrease key, the slider value will decrease by
  /// this amount. If `null`, a default decrement is used.
  final double? decreaseStep;

  /// Creates a [VNLControlledSlider].
  ///
  /// A controlled slider that manages its state either through an external
  /// [controller] or internal state with [initialValue]. Use this when you need
  /// programmatic control over the slider value.
  ///
  /// Parameters:
  /// - [controller] (`VNLSliderController?`, optional): External controller for
  ///   managing slider state. If provided, it becomes the source of truth.
  /// - [initialValue] (`VNLSliderValue`, default: `VNLSliderValue.single(0)`): Initial
  ///   value when no controller is provided.
  /// - [onChanged] (`ValueChanged<VNLSliderValue>?`, optional): Called when the
  ///   slider value changes during interaction.
  /// - [onChangeStart] (`ValueChanged<VNLSliderValue>?`, optional): Called when the
  ///   user begins interaction.
  /// - [onChangeEnd] (`ValueChanged<VNLSliderValue>?`, optional): Called when the
  ///   user completes interaction.
  /// - [min] (`double`, default: `0`): Minimum slider value.
  /// - [max] (`double`, default: `1`): Maximum slider value.
  /// - [divisions] (`int?`, optional): Number of discrete divisions. If `null`,
  ///   the slider is continuous.
  /// - [hintValue] (`VNLSliderValue?`, optional): Visual hint marker on the track.
  /// - [increaseStep] (`double?`, optional): Keyboard increment step size.
  /// - [decreaseStep] (`double?`, optional): Keyboard decrement step size.
  /// - [enabled] (`bool`, default: `true`): Whether the slider is interactive.
  ///
  /// Example:
  /// ```dart
  /// final controller = VNLSliderController(VNLSliderValue.single(0.5));
  ///
  /// VNLControlledSlider(
  ///   controller: controller,
  ///   min: 0.0,
  ///   max: 100.0,
  ///   divisions: 100,
  ///   onChanged: (value) => print('Value: $value'),
  /// )
  /// ```
  const VNLControlledSlider({
    super.key,
    this.controller,
    this.initialValue = const VNLSliderValue.single(0),
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.hintValue,
    this.increaseStep,
    this.decreaseStep,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      builder: (context, data) {
        return VNLSlider(
          value: data.value,
          onChanged: data.onChanged,
          onChangeStart: onChangeStart,
          onChangeEnd: onChangeEnd,
          min: min,
          max: max,
          divisions: divisions,
          hintValue: hintValue,
          increaseStep: increaseStep,
          decreaseStep: decreaseStep,
          enabled: data.enabled,
        );
      },
    );
  }
}

/// Represents a slider value, supporting both single and range configurations.
///
/// A [VNLSliderValue] can represent either a single point value or a dual-thumb
/// range with start and end values. Use [VNLSliderValue.single] for single-thumb
/// sliders and [VNLSliderValue.ranged] for range sliders.
///
/// This class provides value interpolation, division rounding, and comparison
/// operations needed for slider animations and discrete value snapping.
///
/// Example:
/// ```dart
/// // Single value slider
/// final single = VNLSliderValue.single(0.5);
/// print(single.value); // 0.5
///
/// // Range slider
/// final range = VNLSliderValue.ranged(0.2, 0.8);
/// print(range.start); // 0.2
/// print(range.end);   // 0.8
/// ```
class VNLSliderValue {
  /// Linearly interpolates between two [VNLSliderValue] objects.
  ///
  /// Returns `null` if either [a] or [b] is `null`, or if the values have
  /// mismatched types (one single, one ranged). Otherwise, interpolates between
  /// the values using the interpolation factor [t] (typically 0.0 to 1.0).
  ///
  /// Parameters:
  /// - [a] (`VNLSliderValue?`, optional): Start value for interpolation.
  /// - [b] (`VNLSliderValue?`, optional): End value for interpolation.
  /// - [t] (`double`, required): Interpolation factor, where 0.0 returns [a]
  ///   and 1.0 returns [b].
  ///
  /// Returns: `VNLSliderValue?` — interpolated value, or `null` if incompatible.
  static VNLSliderValue? lerp(VNLSliderValue? a, VNLSliderValue? b, double t) {
    if (a == null || b == null) return null;
    if (a.isRanged && b.isRanged) {
      return VNLSliderValue.ranged(
        lerpDouble(a.start, b.start, t)!,
        lerpDouble(a.end, b.end, t)!,
      );
    } else if (!a.isRanged && !b.isRanged) {
      return VNLSliderValue.single(lerpDouble(a.value, b.value, t)!);
    }
    return null;
  }

  final double?
      _start; // if start is null, it means its not ranged slider, its a single value slider
  // if its a single value slider, then the trackbar is clickable and the thumb can be dragged
  // if its a ranged slider, then the trackbar is not clickable and the thumb can be dragged
  final double _end;

  /// Creates a single-value [VNLSliderValue] with the specified [value].
  ///
  /// Use this constructor for standard single-thumb sliders. The slider will
  /// have one draggable thumb and a clickable track.
  ///
  /// Parameters:
  /// - [value] (`double`, required): The slider value position.
  ///
  /// Example:
  /// ```dart
  /// final slider = VNLSliderValue.single(0.75);
  /// ```
  const VNLSliderValue.single(double value)
      : _start = null,
        _end = value;

  /// Creates a range [VNLSliderValue] with start and end positions.
  ///
  /// Use this constructor for dual-thumb range sliders. The slider will have
  /// two draggable thumbs but a non-clickable track.
  ///
  /// Parameters:
  /// - [_start] (`double`, required): The start position of the range.
  /// - [_end] (`double`, required): The end position of the range.
  ///
  /// Example:
  /// ```dart
  /// final range = VNLSliderValue.ranged(0.2, 0.8);
  /// ```
  const VNLSliderValue.ranged(double this._start, this._end);

  /// Whether this is a range slider value (dual-thumb).
  ///
  /// Returns `true` if created with [VNLSliderValue.ranged], `false` if created
  /// with [VNLSliderValue.single].
  bool get isRanged => _start != null;

  /// The start position of the slider value.
  ///
  /// For ranged sliders, returns the actual start position. For single-value
  /// sliders, returns the same as [value].
  double get start => _start ?? _end;

  /// The end position of the slider value.
  ///
  /// For ranged sliders, returns the end position. For single-value sliders,
  /// returns the same as [value].
  double get end => _end;

  /// The value position for single-value sliders.
  ///
  /// Always returns the end position. For single-value sliders, this is the
  /// primary value. For ranged sliders, this returns the end of the range.
  double get value => _end;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLSliderValue && other._start == _start && other._end == _end;
  }

  @override
  int get hashCode => _start.hashCode ^ _end.hashCode;

  /// Rounds the slider value to discrete divisions.
  ///
  /// Snaps the value(s) to the nearest division point based on the specified
  /// number of [divisions]. Useful for creating discrete stepped sliders.
  ///
  /// Parameters:
  /// - [divisions] (`int`, required): Number of discrete steps.
  ///
  /// Returns: `VNLSliderValue` — rounded value.
  ///
  /// Example:
  /// ```dart
  /// final value = VNLSliderValue.single(0.333);
  /// final rounded = value.roundToDivisions(10);
  /// // Results in VNLSliderValue.single(0.3)
  /// ```
  VNLSliderValue roundToDivisions(int divisions) {
    if (!isRanged) {
      return VNLSliderValue.single((_end * divisions).round() / divisions);
    }
    return VNLSliderValue.ranged((_start! * divisions).round() / divisions,
        (_end * divisions).round() / divisions);
  }
}

/// Theme for [VNLSlider].
class VNLSliderTheme extends ComponentThemeData {
  /// Height of the track.
  final double? trackHeight;

  /// Color of the inactive track.
  final Color? trackColor;

  /// Color of the active portion of the track.
  final Color? valueColor;

  /// Color of the inactive track when disabled.
  final Color? disabledTrackColor;

  /// Color of the active track when disabled.
  final Color? disabledValueColor;

  /// Background color of the thumb.
  final Color? thumbColor;

  /// Border color of the thumb.
  final Color? thumbBorderColor;

  /// Border color of the thumb when focused.
  final Color? thumbFocusedBorderColor;

  /// Size of the thumb.
  final double? thumbSize;

  /// Creates a [SliderTheme].
  const VNLSliderTheme({
    this.trackHeight,
    this.trackColor,
    this.valueColor,
    this.disabledTrackColor,
    this.disabledValueColor,
    this.thumbColor,
    this.thumbBorderColor,
    this.thumbFocusedBorderColor,
    this.thumbSize,
  });

  /// Returns a copy of this theme with the given fields replaced.
  VNLSliderTheme copyWith({
    ValueGetter<double?>? trackHeight,
    ValueGetter<Color?>? trackColor,
    ValueGetter<Color?>? valueColor,
    ValueGetter<Color?>? disabledTrackColor,
    ValueGetter<Color?>? disabledValueColor,
    ValueGetter<Color?>? thumbColor,
    ValueGetter<Color?>? thumbBorderColor,
    ValueGetter<Color?>? thumbFocusedBorderColor,
    ValueGetter<double?>? thumbSize,
  }) {
    return VNLSliderTheme(
      trackHeight: trackHeight == null ? this.trackHeight : trackHeight(),
      trackColor: trackColor == null ? this.trackColor : trackColor(),
      valueColor: valueColor == null ? this.valueColor : valueColor(),
      disabledTrackColor: disabledTrackColor == null
          ? this.disabledTrackColor
          : disabledTrackColor(),
      disabledValueColor: disabledValueColor == null
          ? this.disabledValueColor
          : disabledValueColor(),
      thumbColor: thumbColor == null ? this.thumbColor : thumbColor(),
      thumbBorderColor:
          thumbBorderColor == null ? this.thumbBorderColor : thumbBorderColor(),
      thumbFocusedBorderColor: thumbFocusedBorderColor == null
          ? this.thumbFocusedBorderColor
          : thumbFocusedBorderColor(),
      thumbSize: thumbSize == null ? this.thumbSize : thumbSize(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLSliderTheme &&
        other.trackHeight == trackHeight &&
        other.trackColor == trackColor &&
        other.valueColor == valueColor &&
        other.disabledTrackColor == disabledTrackColor &&
        other.disabledValueColor == disabledValueColor &&
        other.thumbColor == thumbColor &&
        other.thumbBorderColor == thumbBorderColor &&
        other.thumbFocusedBorderColor == thumbFocusedBorderColor &&
        other.thumbSize == thumbSize;
  }

  @override
  int get hashCode => Object.hash(
      trackHeight,
      trackColor,
      valueColor,
      disabledTrackColor,
      disabledValueColor,
      thumbColor,
      thumbBorderColor,
      thumbFocusedBorderColor,
      thumbSize);
}

/// Intent for increasing the slider value via keyboard shortcuts.
///
/// Used with Flutter's shortcuts and actions system to handle keyboard
/// input for incrementing slider values. Typically bound to arrow keys.
class VNLIncreaseSliderValue extends Intent {
  /// Creates an [VNLIncreaseSliderValue] intent.
  const VNLIncreaseSliderValue();
}

/// Intent for decreasing the slider value via keyboard shortcuts.
///
/// Used with Flutter's shortcuts and actions system to handle keyboard
/// input for decrementing slider values. Typically bound to arrow keys.
class VNLDecreaseSliderValue extends Intent {
  /// Creates a [VNLDecreaseSliderValue] intent.
  const VNLDecreaseSliderValue();
}

/// A Material Design slider widget for selecting values or ranges.
///
/// A highly customizable slider supporting both single-value and range
/// selection modes. Provides keyboard navigation, discrete divisions,
/// hint values, and comprehensive theming options.
///
/// Unlike [VNLControlledSlider], this widget is uncontrolled and requires
/// explicit value management through [onChanged]. For a controlled
/// alternative with automatic state management, use [VNLControlledSlider].
///
/// Example:
/// ```dart
/// VNLSlider(
///   value: VNLSliderValue.single(0.5),
///   min: 0.0,
///   max: 1.0,
///   divisions: 10,
///   onChanged: (newValue) {
///     setState(() => value = newValue);
///   },
/// )
/// ```
class VNLSlider extends StatefulWidget {
  /// The current value of the slider.
  ///
  /// Can be either a single value or a range. The slider's visual state
  /// reflects this value.
  final VNLSliderValue value;

  /// Callback invoked when the slider value changes.
  ///
  /// Called repeatedly during slider interaction as the user drags the thumb
  /// or clicks the track. Receives the new [VNLSliderValue].
  final ValueChanged<VNLSliderValue>? onChanged;

  /// Callback invoked when the user starts changing the slider value.
  ///
  /// Called once when interaction begins. Receives the initial [VNLSliderValue].
  final ValueChanged<VNLSliderValue>? onChangeStart;

  /// Callback invoked when the user finishes changing the slider value.
  ///
  /// Called once when interaction ends. Receives the final [VNLSliderValue].
  final ValueChanged<VNLSliderValue>? onChangeEnd;

  /// The minimum value the slider can represent.
  ///
  /// Defaults to `0`. Must be less than [max].
  final double min;

  /// The maximum value the slider can represent.
  ///
  /// Defaults to `1`. Must be greater than [min].
  final double max;

  /// The number of discrete divisions the slider range is divided into.
  ///
  /// If `null`, the slider is continuous. If specified, the slider snaps to
  /// discrete values.
  final int? divisions;

  /// An optional hint value displayed on the slider track.
  ///
  /// Renders as a visual marker showing a target or reference position.
  final VNLSliderValue? hintValue;

  /// The step size for keyboard increment actions.
  ///
  /// Used when the user triggers increase actions via keyboard. If `null`,
  /// a default step is calculated based on the slider range.
  final double? increaseStep;

  /// The step size for keyboard decrement actions.
  ///
  /// Used when the user triggers decrease actions via keyboard. If `null`,
  /// a default step is calculated based on the slider range.
  final double? decreaseStep;

  /// Whether the slider is interactive.
  ///
  /// When `false` or `null` with no [onChanged] callback, the slider is
  /// displayed in a disabled state and does not respond to user input.
  final bool? enabled;

  /// Creates a [VNLSlider].
  ///
  /// Parameters:
  /// - [value] (`VNLSliderValue`, required): Current slider value.
  /// - [onChanged] (`ValueChanged<VNLSliderValue>?`, optional): Value change callback.
  /// - [onChangeStart] (`ValueChanged<VNLSliderValue>?`, optional): Interaction start callback.
  /// - [onChangeEnd] (`ValueChanged<VNLSliderValue>?`, optional): Interaction end callback.
  /// - [min] (`double`, default: `0`): Minimum value.
  /// - [max] (`double`, default: `1`): Maximum value.
  /// - [divisions] (`int?`, optional): Number of discrete divisions.
  /// - [hintValue] (`VNLSliderValue?`, optional): Visual hint marker.
  /// - [increaseStep] (`double?`, optional): Keyboard increment step.
  /// - [decreaseStep] (`double?`, optional): Keyboard decrement step.
  /// - [enabled] (`bool?`, optional): Whether interactive.
  ///
  /// Example:
  /// ```dart
  /// VNLSlider(
  ///   value: VNLSliderValue.ranged(0.2, 0.8),
  ///   min: 0.0,
  ///   max: 1.0,
  ///   onChanged: (value) => print('Range: ${value.start}-${value.end}'),
  /// )
  /// ```
  const VNLSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.hintValue,
    this.increaseStep,
    this.decreaseStep,
    this.enabled = true,
  }) : assert(min <= max);

  @override
  State<VNLSlider> createState() => _SliderState();
}

class _SliderState extends State<VNLSlider>
    with FormValueSupplier<VNLSliderValue, VNLSlider> {
  late VNLSliderValue
      _currentValue; // used for the thumb position (not the trackbar)
  late VNLSliderValue _externalValue;
  // trackbar position uses the widget.value
  bool _dragging = false;
  bool _moveStart = false;

  bool _focusing = false;
  bool _focusingEnd = false;

  bool get enabled => widget.enabled ?? widget.onChanged != null;

  @override
  void initState() {
    super.initState();
    _externalValue = widget.value;
    _setCurrentValueFromExternal();
    formValue = _currentValue;
  }

  void _dispatchValueChangeStart(VNLSliderValue value) {
    if (!enabled) return;
    if (widget.divisions != null) {
      value = value.roundToDivisions(widget.divisions!);
    }
    widget.onChangeStart?.call(value);
  }

  void _dispatchValueChange(VNLSliderValue value) {
    if (!enabled) return;
    if (widget.divisions != null) {
      value = value.roundToDivisions(widget.divisions!);
    }
    if (value != widget.value) {
      widget.onChanged?.call(value);
    }
  }

  void _dispatchValueChangeEnd(VNLSliderValue value) {
    if (!enabled) return;
    if (widget.divisions != null) {
      value = value.roundToDivisions(widget.divisions!);
    }
    if (value != widget.value) {
      widget.onChangeEnd?.call(value);
    }
  }

  @override
  void didUpdateWidget(covariant VNLSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _externalValue = widget.value;
      if (!_dragging) {
        _setCurrentValueFromExternal();
        formValue = _currentValue;
      }
    }
  }

  void _setCurrentValueFromExternal() {
    if (_externalValue.isRanged) {
      var start =
          (_externalValue.start - widget.min) / (widget.max - widget.min);
      var end = (_externalValue.end - widget.min) / (widget.max - widget.min);
      var newStart = min(start, end);
      var newEnd = max(start, end);
      _currentValue = VNLSliderValue.ranged(newStart, newEnd);
    } else {
      var value =
          (_externalValue.value - widget.min) / (widget.max - widget.min);
      _currentValue = VNLSliderValue.single(value);
    }
  }

  void _scheduleExternalSync() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_currentValue == _externalValue) return;
      setState(() {
        _setCurrentValueFromExternal();
      });
    });
  }

  @override
  void didReplaceFormValue(VNLSliderValue value) {
    widget.onChanged?.call(value);
    widget.onChangeEnd?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    return Container(
      constraints: BoxConstraints(
        minWidth: 20 * scaling,
        minHeight: 16 * scaling,
        maxHeight: 16 * scaling,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: densityGap * 0.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTapDown: !enabled
                  ? null
                  : widget.value.isRanged
                      ? (details) {
                          // _moveStart to true if the tap is closer to the start thumb
                          double offset = details.localPosition.dx;
                          double newValue = offset / constraints.maxWidth;
                          double start = _currentValue.start;
                          double end = _currentValue.end;
                          if (widget.divisions != null) {
                            start = (start * widget.divisions!).round() /
                                widget.divisions!;
                            end = (end * widget.divisions!).round() /
                                widget.divisions!;
                          }
                          _moveStart =
                              (start - newValue).abs() < (end - newValue).abs();
                          // find the closest thumb and move it to the tap position
                          if (_moveStart) {
                            if (widget.divisions != null) {
                              double deltaValue = newValue - start;
                              if (deltaValue >= 0 &&
                                  deltaValue < 0.5 / widget.divisions!) {
                                newValue += 0.5 / widget.divisions!;
                              } else if (deltaValue < 0 &&
                                  deltaValue > -0.5 / widget.divisions!) {
                                newValue -= 0.5 / widget.divisions!;
                              }
                            }
                            VNLSliderValue newSliderValue =
                                VNLSliderValue.ranged(newValue, widget.value.end);
                            _dispatchValueChangeStart(newSliderValue);
                            _dispatchValueChange(newSliderValue);
                            _dispatchValueChangeEnd(newSliderValue);
                            setState(() {
                              _currentValue = VNLSliderValue.ranged(newValue, end);
                            });
                            _scheduleExternalSync();
                          } else {
                            if (widget.divisions != null) {
                              double deltaValue = newValue - end;
                              if (deltaValue >= 0 &&
                                  deltaValue < 0.5 / widget.divisions!) {
                                newValue += 0.5 / widget.divisions!;
                              } else if (deltaValue < 0 &&
                                  deltaValue > -0.5 / widget.divisions!) {
                                newValue -= 0.5 / widget.divisions!;
                              }
                            }
                            VNLSliderValue newSliderValue = VNLSliderValue.ranged(
                                widget.value.start, newValue);
                            _dispatchValueChangeStart(newSliderValue);
                            _dispatchValueChange(newSliderValue);
                            _dispatchValueChangeEnd(newSliderValue);
                            setState(() {
                              _currentValue =
                                  VNLSliderValue.ranged(start, newValue);
                            });
                            _scheduleExternalSync();
                          }
                        }
                      : (details) {
                          double offset = details.localPosition.dx;
                          double newValue = offset / constraints.maxWidth;
                          newValue = newValue.clamp(0, 1);
                          if (widget.divisions != null) {
                            double deltaValue = newValue - _currentValue.value;
                            if (deltaValue >= 0 &&
                                deltaValue < 0.5 / widget.divisions!) {
                              newValue += 0.5 / widget.divisions!;
                            } else if (deltaValue < 0 &&
                                deltaValue > -0.5 / widget.divisions!) {
                              newValue -= 0.5 / widget.divisions!;
                            }
                            newValue = (newValue * widget.divisions!).round() /
                                widget.divisions!;
                          }
                          VNLSliderValue newSliderValue = VNLSliderValue.single(
                              newValue * (widget.max - widget.min) +
                                  widget.min);
                          _dispatchValueChangeStart(newSliderValue);
                          _dispatchValueChange(newSliderValue);
                          _dispatchValueChangeEnd(newSliderValue);
                          setState(() {
                            _currentValue = VNLSliderValue.single(newValue);
                          });
                          _scheduleExternalSync();
                        },
              onHorizontalDragStart: !enabled
                  ? null
                  : (details) {
                      _dragging = true;
                      if (_currentValue.isRanged) {
                        // change _moveStart to true if the tap is closer to the start thumb
                        double offset = details.localPosition.dx;
                        double newValue = offset / constraints.maxWidth;
                        double start = _currentValue.start;
                        double end = _currentValue.end;
                        if (widget.divisions != null) {
                          start = (start * widget.divisions!).round() /
                              widget.divisions!;
                          end = (end * widget.divisions!).round() /
                              widget.divisions!;
                        }
                        _moveStart =
                            (start - newValue).abs() < (end - newValue).abs();
                        var startValue =
                            start * (widget.max - widget.min) + widget.min;
                        var endValue =
                            end * (widget.max - widget.min) + widget.min;
                        var newStartValue = min(startValue, endValue);
                        var newEndValue = max(startValue, endValue);
                        VNLSliderValue newSliderValue =
                            VNLSliderValue.ranged(newStartValue, newEndValue);
                        _dispatchValueChangeStart(newSliderValue);
                      } else {
                        double value = _currentValue.value;
                        if (widget.divisions != null) {
                          value = (value * widget.divisions!).round() /
                              widget.divisions!;
                        }
                        VNLSliderValue newSliderValue = VNLSliderValue.single(
                            value * (widget.max - widget.min) + widget.min);
                        _dispatchValueChangeStart(newSliderValue);
                      }
                    },
              onHorizontalDragUpdate: !enabled
                  ? null
                  : widget.value.isRanged
                      ? (details) {
                          // drag the closest thumb to the drag position
                          // but use delta to calculate the new value
                          double delta =
                              details.primaryDelta! / constraints.maxWidth;
                          if (_moveStart) {
                            var newStart = _currentValue.start + delta;
                            var newEnd = _currentValue.end;
                            newStart = newStart.clamp(0, 1);
                            newEnd = newEnd.clamp(0, 1);
                            var newInternalSliderValue =
                                VNLSliderValue.ranged(newStart, newEnd);
                            if (newInternalSliderValue == _currentValue) {
                              return;
                            }
                            var sliderStart = newStart;
                            var sliderEnd = newEnd;
                            if (widget.divisions != null) {
                              sliderStart =
                                  (sliderStart * widget.divisions!).round() /
                                      widget.divisions!;
                              sliderEnd =
                                  (sliderEnd * widget.divisions!).round() /
                                      widget.divisions!;
                            }
                            var startSliderValue =
                                sliderStart * (widget.max - widget.min) +
                                    widget.min;
                            var endSliderValue =
                                sliderEnd * (widget.max - widget.min) +
                                    widget.min;
                            var newSliderValue = VNLSliderValue.ranged(
                                min(startSliderValue, endSliderValue),
                                max(startSliderValue, endSliderValue));
                            _dispatchValueChange(newSliderValue);
                            setState(() {
                              _currentValue =
                                  VNLSliderValue.ranged(newStart, newEnd);
                            });
                          } else {
                            var newStart = _currentValue.start;
                            var newEnd = _currentValue.end + delta;
                            newStart = newStart.clamp(0, 1);
                            newEnd = newEnd.clamp(0, 1);
                            var newInternalSliderValue =
                                VNLSliderValue.ranged(newStart, newEnd);
                            if (newInternalSliderValue == _currentValue) {
                              return;
                            }
                            var sliderStart = newStart;
                            var sliderEnd = newEnd;
                            if (widget.divisions != null) {
                              sliderStart =
                                  (sliderStart * widget.divisions!).round() /
                                      widget.divisions!;
                              sliderEnd =
                                  (sliderEnd * widget.divisions!).round() /
                                      widget.divisions!;
                            }
                            var startSliderValue =
                                sliderStart * (widget.max - widget.min) +
                                    widget.min;
                            var endSliderValue =
                                sliderEnd * (widget.max - widget.min) +
                                    widget.min;
                            var newSliderValue = VNLSliderValue.ranged(
                                min(startSliderValue, endSliderValue),
                                max(startSliderValue, endSliderValue));
                            _dispatchValueChange(newSliderValue);
                            setState(() {
                              _currentValue =
                                  VNLSliderValue.ranged(newStart, newEnd);
                            });
                          }
                        }
                      : (details) {
                          double delta =
                              details.primaryDelta! / constraints.maxWidth;
                          double newValue = _currentValue.value + delta;
                          newValue = newValue.clamp(0, 1);
                          var sliderValue = newValue;
                          if (widget.divisions != null) {
                            sliderValue =
                                (sliderValue * widget.divisions!).round() /
                                    widget.divisions!;
                          }
                          var newSliderValue = VNLSliderValue.single(
                              sliderValue * (widget.max - widget.min) +
                                  widget.min);
                          _dispatchValueChange(newSliderValue);
                          setState(() {
                            _currentValue = VNLSliderValue.single(newValue);
                          });
                        },
              onHorizontalDragEnd: !enabled
                  ? null
                  : (details) {
                      _dragging = false;
                      if (_currentValue.isRanged) {
                        var start = _currentValue.start;
                        var end = _currentValue.end;
                        var newStart = min(start, end);
                        var newEnd = max(start, end);
                        _dispatchValueChangeEnd(VNLSliderValue.ranged(
                            (newStart * (widget.max - widget.min) + widget.min),
                            (newEnd * (widget.max - widget.min) + widget.min)));
                      } else {
                        _dispatchValueChangeEnd(VNLSliderValue.single(
                            (_currentValue.value * (widget.max - widget.min) +
                                widget.min)));
                      }
                      setState(() {
                        _setCurrentValueFromExternal();
                      });
                    },
              child: MouseRegion(
                  cursor: !enabled
                      ? SystemMouseCursors.forbidden
                      : (widget.onChanged != null ||
                              widget.onChangeStart != null ||
                              widget.onChangeEnd != null)
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                  child: widget.value.isRanged
                      ? buildRangedSlider(context, constraints, theme)
                      : buildSingleSlider(context, constraints, theme)),
            );
          },
        ),
      ),
    );
  }

  Widget buildSingleSlider(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildTrackBar(context, constraints, theme),
        if (widget.hintValue != null) buildHint(context, constraints, theme),
        buildTrackValue(context, constraints, theme),
        buildThumb(
          context,
          constraints,
          theme,
          _currentValue.value,
          _focusing,
          (focusing) {
            setState(() {
              _focusing = focusing;
            });
          },
          // on increase uses increaseStep or divisions or 1
          // and so decrease
          () {
            var value = _currentValue.value;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.increaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value + step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = VNLSliderValue.single(
                sliderValue * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = VNLSliderValue.single(value);
            });
          },
          () {
            var value = _currentValue.value;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.decreaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value - step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = VNLSliderValue.single(
                sliderValue * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = VNLSliderValue.single(value);
            });
          },
        ),
      ],
    );
  }

  Widget buildHint(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    return AnimatedValueBuilder(
        value: widget.hintValue,
        duration: _dragging ? Duration.zero : kDefaultDuration,
        curve: Curves.easeInOut,
        lerp: VNLSliderValue.lerp,
        builder: (context, hintValue, _) {
          var start = hintValue!.start;
          var end = hintValue.end;
          var newStart = min(start, end);
          var newEnd = max(start, end);
          var left = (newStart - widget.min) /
              (widget.max - widget.min) *
              constraints.maxWidth;
          var right = (1 - (newEnd - widget.min) / (widget.max - widget.min)) *
              constraints.maxWidth;
          return Positioned(
            left: !_isRanged ? 0 : left,
            right: right,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 6 * scaling,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.scaleAlpha(0.2),
                  borderRadius: BorderRadius.circular(theme.radiusSm),
                ),
              ),
            ),
          );
        });
  }

  bool get _isRanged => widget.value.isRanged;

  Widget buildTrackValue(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = VNLComponentTheme.maybeOf<VNLSliderTheme>(context);
    var value = widget.value;
    var start = value.start;
    var end = value.end;
    if (widget.divisions != null) {
      var normalizedStart = (start - widget.min) / (widget.max - widget.min);
      var normalizedEnd = (end - widget.min) / (widget.max - widget.min);
      normalizedStart =
          (normalizedStart * widget.divisions!).round() / widget.divisions!;
      normalizedEnd =
          (normalizedEnd * widget.divisions!).round() / widget.divisions!;
      start = normalizedStart * (widget.max - widget.min) + widget.min;
      end = normalizedEnd * (widget.max - widget.min) + widget.min;
    }
    var newStart = min(start, end);
    var newEnd = max(start, end);

    return AnimatedValueBuilder(
        value: Offset(newStart, newEnd),
        duration: _dragging && widget.divisions == null
            ? Duration.zero
            : kDefaultDuration,
        curve: Curves.easeInOut,
        lerp: Offset.lerp,
        builder: (context, value, _) {
          var newStart = value!.dx;
          var newEnd = value.dy;
          var left = (newStart - widget.min) /
              (widget.max - widget.min) *
              constraints.maxWidth;
          var right = (1 - (newEnd - widget.min) / (widget.max - widget.min)) *
              constraints.maxWidth;
          return Positioned(
            left: !_isRanged ? 0 : left,
            right: right,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: (compTheme?.trackHeight ?? 6) * scaling,
                decoration: BoxDecoration(
                  color: enabled
                      ? (compTheme?.valueColor ?? theme.colorScheme.primary)
                      : (compTheme?.disabledValueColor ??
                          theme.colorScheme.mutedForeground),
                  borderRadius: BorderRadius.circular(theme.radiusSm),
                ),
              ),
            ),
          );
        });
  }

  Widget buildTrackBar(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = VNLComponentTheme.maybeOf<VNLSliderTheme>(context);
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Center(
        child: Container(
          height: (compTheme?.trackHeight ?? 6) * scaling,
          decoration: BoxDecoration(
            color: enabled
                ? (compTheme?.trackColor ??
                    theme.colorScheme.primary.scaleAlpha(0.2))
                : (compTheme?.disabledTrackColor ?? theme.colorScheme.muted),
            borderRadius: BorderRadius.circular(theme.radiusSm),
          ),
        ),
      ),
    );
  }

  Widget buildThumb(
      BuildContext context,
      BoxConstraints constraints,
      ThemeData theme,
      double value,
      bool focusing,
      ValueChanged<bool> onFocusing,
      VoidCallback onIncrease,
      VoidCallback onDecrease) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = VNLComponentTheme.maybeOf<VNLSliderTheme>(context);
    if (widget.divisions != null) {
      value = (value * widget.divisions!).round() / widget.divisions!;
    }
    return AnimatedValueBuilder(
        duration: _dragging && widget.divisions == null
            ? Duration.zero
            : kDefaultDuration,
        curve: Curves.easeInOut,
        lerp: lerpDouble,
        value: value,
        builder: (context, value, _) {
          return Positioned(
            left: value! * constraints.maxWidth - 8 * scaling,
            child: FocusableActionDetector(
              enabled: enabled,
              onShowFocusHighlight: (showHighlight) {
                onFocusing(showHighlight);
              },
              shortcuts: {
                LogicalKeySet(LogicalKeyboardKey.arrowLeft):
                    const VNLDecreaseSliderValue(),
                LogicalKeySet(LogicalKeyboardKey.arrowRight):
                    const VNLIncreaseSliderValue(),
                LogicalKeySet(LogicalKeyboardKey.arrowUp):
                    const VNLIncreaseSliderValue(),
                LogicalKeySet(LogicalKeyboardKey.arrowDown):
                    const VNLDecreaseSliderValue(),
              },
              actions: {
                VNLIncreaseSliderValue: CallbackAction(
                  onInvoke: (e) {
                    onIncrease();
                    return true;
                  },
                ),
                VNLDecreaseSliderValue: CallbackAction(
                  onInvoke: (e) {
                    onDecrease();
                    return true;
                  },
                ),
              },
              child: Container(
                width: (compTheme?.thumbSize ?? 16) * scaling,
                height: (compTheme?.thumbSize ?? 16) * scaling,
                decoration: BoxDecoration(
                  color: compTheme?.thumbColor ?? theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: focusing
                        ? (enabled
                            ? (compTheme?.thumbFocusedBorderColor ??
                                theme.colorScheme.primary)
                            : (compTheme?.disabledValueColor ??
                                theme.colorScheme.mutedForeground))
                        : (enabled
                            ? (compTheme?.thumbBorderColor ??
                                theme.colorScheme.primary.scaleAlpha(0.5))
                            : (compTheme?.disabledValueColor ??
                                theme.colorScheme.mutedForeground)),
                    width: focusing ? 2 * scaling : 1 * scaling,
                    strokeAlign: focusing
                        ? BorderSide.strokeAlignOutside
                        : BorderSide.strokeAlignInside,
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildRangedSlider(
      BuildContext context, BoxConstraints constraints, ThemeData theme) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildTrackBar(context, constraints, theme),
        if (widget.hintValue != null) buildHint(context, constraints, theme),
        buildTrackValue(context, constraints, theme),
        buildThumb(
          context,
          constraints,
          theme,
          min(_currentValue.start, _currentValue.end),
          _focusing,
          (focusing) {
            setState(() {
              _focusing = focusing;
            });
          },
          () {
            var value = _currentValue.start;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.increaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value + step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = VNLSliderValue.ranged(
                sliderValue * (widget.max - widget.min) + widget.min,
                _currentValue.end * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = VNLSliderValue.ranged(value, _currentValue.end);
            });
          },
          () {
            var value = _currentValue.start;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.decreaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value - step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = VNLSliderValue.ranged(
                sliderValue * (widget.max - widget.min) + widget.min,
                _currentValue.end * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = VNLSliderValue.ranged(value, _currentValue.end);
            });
          },
        ),
        buildThumb(
          context,
          constraints,
          theme,
          max(_currentValue.start, _currentValue.end),
          _focusingEnd,
          (focusing) {
            setState(() {
              _focusingEnd = focusing;
            });
          },
          () {
            var value = _currentValue.end;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.increaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value + step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = VNLSliderValue.ranged(
                _currentValue.start * (widget.max - widget.min) + widget.min,
                sliderValue * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = VNLSliderValue.ranged(_currentValue.start, value);
            });
          },
          () {
            var value = _currentValue.end;
            if (widget.divisions != null) {
              value = (value * widget.divisions!).round() / widget.divisions!;
            }
            var step = widget.decreaseStep ?? 1 / (widget.divisions ?? 100);
            value = (value - step).clamp(0, 1);
            var sliderValue = value;
            if (widget.divisions != null) {
              sliderValue =
                  (sliderValue * widget.divisions!).round() / widget.divisions!;
            }
            var newSliderValue = VNLSliderValue.ranged(
                _currentValue.start * (widget.max - widget.min) + widget.min,
                sliderValue * (widget.max - widget.min) + widget.min);
            _dispatchValueChangeStart(newSliderValue);
            _dispatchValueChange(newSliderValue);
            _dispatchValueChangeEnd(newSliderValue);
            setState(() {
              _currentValue = VNLSliderValue.ranged(_currentValue.start, value);
            });
          },
        ),
      ],
    );
  }
}
