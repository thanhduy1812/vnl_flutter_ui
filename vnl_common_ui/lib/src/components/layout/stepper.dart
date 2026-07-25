import 'package:flutter/foundation.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Theme configuration for [VNLStepper] components.
///
/// Defines default values for stepper direction, size, and visual variant.
/// Applied through [VNLComponentTheme] to provide consistent styling across
/// stepper widgets in the application.
///
/// Example:
/// ```dart
/// VNLComponentTheme(
///   data: VNLStepperTheme(
///     direction: Axis.vertical,
///     size: VNLStepSize.large,
///     variant: VNLStepVariant.circle,
///   ),
///   child: MyApp(),
/// );
/// ```
class VNLStepperTheme extends ComponentThemeData {
  /// Layout direction for the stepper.
  final Axis? direction;

  /// Size variant for step indicators.
  final VNLStepSize? size;

  /// Visual variant for step presentation.
  final VNLStepVariant? variant;

  /// Creates a [StepperTheme].
  ///
  /// All parameters are optional and provide default values for
  /// stepper components in the widget tree.
  ///
  /// Parameters:
  /// - [direction] (Axis?): horizontal or vertical layout
  /// - [size] (VNLStepSize?): step indicator size (small, medium, large)
  /// - [variant] (VNLStepVariant?): visual style (circle, circleAlt, line)
  const VNLStepperTheme({this.direction, this.size, this.variant});

  /// Creates a copy of this theme with optionally overridden properties.
  VNLStepperTheme copyWith({
    ValueGetter<Axis?>? direction,
    ValueGetter<VNLStepSize?>? size,
    ValueGetter<VNLStepVariant?>? variant,
  }) {
    return VNLStepperTheme(
      direction: direction == null ? this.direction : direction(),
      size: size == null ? this.size : size(),
      variant: variant == null ? this.variant : variant(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLStepperTheme &&
        other.direction == direction &&
        other.size == size &&
        other.variant == variant;
  }

  @override
  int get hashCode => Object.hash(direction, size, variant);
}

/// Represents the state of an individual step in a stepper.
///
/// Currently supports failed state indication, with potential for
/// expansion to include additional states like completed, active, etc.
enum VNLStepState {
  /// Indicates a step has failed validation or encountered an error.
  failed,
}

/// Immutable value representing the current state of a stepper.
///
/// Contains the current active step index and a map of step states
/// for any steps that have special states (like failed). Used by
/// [VNLStepperController] to track and notify about stepper state changes.
///
/// Example:
/// ```dart
/// final value = VNLStepperValue(
///   currentStep: 2,
///   stepStates: {1: VNLStepState.failed},
/// );
/// ```
class VNLStepperValue {
  /// Map of step indices to their special states.
  final Map<int, VNLStepState> stepStates;

  /// Index of the currently active step (0-based).
  final int currentStep;

  /// Creates a [VNLStepperValue].
  ///
  /// Parameters:
  /// - [stepStates] (`Map<int, VNLStepState>`, required): step states by index
  /// - [currentStep] (int, required): currently active step index
  VNLStepperValue({
    required this.stepStates,
    required this.currentStep,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLStepperValue &&
        mapEquals(other.stepStates, stepStates) &&
        other.currentStep == currentStep;
  }

  @override
  int get hashCode => Object.hash(stepStates, currentStep);

  @override
  String toString() {
    return 'VNLStepperValue{stepStates: $stepStates, currentStep: $currentStep}';
  }
}

/// Represents a single step in a stepper component.
///
/// Contains the step's title, optional content builder for step details,
/// and an optional custom icon. The content builder is called when
/// the step becomes active to show step-specific content.
///
/// Example:
/// ```dart
/// VNLStep(
///   title: Text('Personal Info'),
///   icon: Icon(Icons.person),
///   contentBuilder: (context) => PersonalInfoForm(),
/// );
/// ```
class VNLStep {
  /// The title widget displayed for this step.
  final Widget title;

  /// Optional builder for step content shown when active.
  final WidgetBuilder? contentBuilder;

  /// Optional custom icon for the step indicator.
  final Widget? icon;

  /// Creates a [VNLStep].
  ///
  /// The [title] is required and typically contains the step name or description.
  /// The [contentBuilder] is called when this step becomes active to show
  /// detailed content. The [icon] replaces the default step number/checkmark.
  ///
  /// Parameters:
  /// - [title] (Widget, required): step title or label
  /// - [contentBuilder] (WidgetBuilder?): builds content when step is active
  /// - [icon] (Widget?): custom icon for step indicator
  ///
  /// Example:
  /// ```dart
  /// VNLStep(
  ///   title: Text('Account Setup'),
  ///   icon: Icon(Icons.account_circle),
  ///   contentBuilder: (context) => AccountSetupForm(),
  /// );
  /// ```
  const VNLStep({
    required this.title,
    this.contentBuilder,
    this.icon,
  });
}

/// Function type for building size-appropriate step content.
///
/// Takes a [BuildContext] and child widget, returns a styled widget
/// with appropriate sizing applied.
typedef StepSizeBuilder = Widget Function(BuildContext context, Widget child);

/// Defines the size variants available for step indicators.
///
/// Each size includes both a numeric size value and a builder function
/// that applies appropriate text and icon styling. Sizes scale with
/// the theme's scaling factor.
///
/// Example:
/// ```dart
/// VNLStepper(
///   size: VNLStepSize.large,
///   steps: mySteps,
///   controller: controller,
/// );
/// ```
enum VNLStepSize {
  /// Small step indicators with compact text and icons.
  small(_smallSize, kSmallStepIndicatorSize),

  /// Medium step indicators with normal text and icons (default).
  medium(_mediumSize, kMediumStepIndicatorSize),

  /// Large step indicators with larger text and icons.
  large(_largeSize, kLargeStepIndicatorSize);

  /// The numeric size value for the step indicator.
  final double size;

  /// Builder function that applies size-appropriate styling.
  final StepSizeBuilder wrapper;

  const VNLStepSize(this.wrapper, this.size);
}

/// Applies small text and icon sizing to the child widget.
Widget _smallSize(BuildContext context, Widget child) {
  return child.small().iconSmall();
}

/// Applies normal text and icon sizing to the child widget.
Widget _mediumSize(BuildContext context, Widget child) {
  return child.normal().iconMedium();
}

/// Applies large text and icon sizing to the child widget.
Widget _largeSize(BuildContext context, Widget child) {
  return child.large().iconLarge();
}

/// Abstract base class for step visual presentation variants.
///
/// Defines how steps are rendered and connected to each other. Three built-in
/// variants are provided: circle (default), circleAlt (alternative layout),
/// and line (minimal design). Custom variants can be created by extending
/// this class.
///
/// Example:
/// ```dart
/// VNLStepper(
///   variant: VNLStepVariant.circle,
///   steps: mySteps,
///   controller: controller,
/// );
/// ```
abstract class VNLStepVariant {
  /// Circle variant with numbered indicators and connecting lines.
  static const VNLStepVariant circle = _StepVariantCircle();

  /// Alternative circle variant with centered step names.
  static const VNLStepVariant circleAlt = _StepVariantCircleAlternative();

  /// Minimal line variant with progress bars as step indicators.
  static const VNLStepVariant line = _StepVariantLine();

  /// Creates a [VNLStepVariant].
  const VNLStepVariant();

  /// Builds the stepper widget using this variant's visual style.
  ///
  /// Implementations should create the appropriate layout using the
  /// provided [VNLStepProperties] which contains step data, current state,
  /// and sizing information.
  Widget build(BuildContext context, VNLStepProperties properties);
}

class _StepVariantCircle extends VNLStepVariant {
  const _StepVariantCircle();

  @override
  Widget build(BuildContext context, VNLStepProperties properties) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    if (properties.direction == Axis.horizontal) {
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        Widget childWidget = Data.inherit(
          data: VNLStepNumberData(stepIndex: i),
          child: Row(
            children: [
              properties[i]?.icon ?? const VNLStepNumber(),
              Gap(densityGap),
              properties.size
                  .wrapper(context, properties[i]?.title ?? const SizedBox()),
              if (i != properties.steps.length - 1) ...[
                Gap(densityGap),
                Expanded(
                  child: AnimatedBuilder(
                      animation: properties.state,
                      builder: (context, child) {
                        return VNLDivider(
                          thickness: 2 * scaling,
                          color: properties.hasFailure &&
                                  properties.state.value.currentStep <= i
                              ? theme.colorScheme.destructive
                              : properties.state.value.currentStep >= i
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.border,
                        );
                      }),
                ),
                Gap(densityGap),
              ],
            ],
          ),
        );
        children.add(
          i == properties.steps.length - 1
              ? childWidget
              : Expanded(
                  child: childWidget,
                ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
          AnimatedBuilder(
              animation: properties.state,
              builder: (context, child) {
                var current = properties.state.value.currentStep;
                return Flexible(
                    child: IndexedStack(
                  index: current < 0 || current >= properties.steps.length
                      ? properties.steps.length // will show the placeholder
                      : current,
                  children: [
                    for (int i = 0; i < properties.steps.length; i++)
                      properties[i]?.contentBuilder?.call(context) ??
                          const SizedBox(),
                    const SizedBox(), // for placeholder
                  ],
                ));
              }),
        ],
      );
    } else {
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        children.add(
          Data.inherit(
            data: VNLStepNumberData(stepIndex: i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    properties.steps[i].icon ?? const VNLStepNumber(),
                    Gap(densityGap),
                    properties.size.wrapper(context, properties.steps[i].title),
                  ],
                ),
                Gap(densityGap),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: densityGap * 2,
                  ),
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        top: 0,
                        start: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: properties.size.size,
                          child: i == properties.steps.length - 1
                              ? null
                              : AnimatedBuilder(
                                  animation: properties.state,
                                  builder: (context, child) {
                                    return VNLVerticalDivider(
                                      thickness: 2 * scaling,
                                      color: properties.hasFailure &&
                                              properties.state.value
                                                      .currentStep <=
                                                  i
                                          ? theme.colorScheme.destructive
                                          : properties.state.value
                                                      .currentStep >=
                                                  i
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.border,
                                    );
                                  }),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: properties.state,
                          child:
                              properties.steps[i].contentBuilder?.call(context),
                          builder: (context, child) {
                            return AnimatedCrossFade(
                              firstChild: Container(
                                height: 0,
                              ),
                              secondChild: Container(
                                margin: EdgeInsets.only(
                                  left: properties.size.size,
                                ),
                                child: child!,
                              ),
                              firstCurve: const Interval(0.0, 0.6,
                                  curve: Curves.fastOutSlowIn),
                              secondCurve: const Interval(0.4, 1.0,
                                  curve: Curves.fastOutSlowIn),
                              sizeCurve: Curves.fastOutSlowIn,
                              crossFadeState:
                                  properties.state.value.currentStep == i
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                              duration: kDefaultDuration,
                            );
                          }),
                    ],
                  ),
                ),
                AnimatedBuilder(
                    animation: properties.state,
                    builder: (context, child) {
                      if (i == properties.steps.length - 1) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: densityGap,
                      );
                    }),
              ],
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

class _StepVariantCircleAlternative extends VNLStepVariant {
  const _StepVariantCircleAlternative();
  @override
  Widget build(BuildContext context, VNLStepProperties properties) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final steps = properties.steps;
    if (properties.direction == Axis.horizontal) {
      List<Widget> children = [];
      for (int i = 0; i < steps.length; i++) {
        children.add(
          Data.inherit(
              data: VNLStepNumberData(stepIndex: i),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        i == 0
                            ? const Spacer()
                            : Expanded(
                                child: AnimatedBuilder(
                                    animation: properties.state,
                                    builder: (context, child) {
                                      return VNLDivider(
                                        thickness: 2 * scaling,
                                        color: properties.hasFailure &&
                                                properties.state.value
                                                        .currentStep <=
                                                    i - 1
                                            ? theme.colorScheme.destructive
                                            : properties.state.value
                                                        .currentStep >=
                                                    i - 1
                                                ? theme.colorScheme.primary
                                                : theme.colorScheme.border,
                                      );
                                    }),
                              ),
                        Gap(densityGap * 0.5),
                        steps[i].icon ?? const VNLStepNumber(),
                        Gap(densityGap * 0.5),
                        i == steps.length - 1
                            ? const Spacer()
                            : Expanded(
                                child: AnimatedBuilder(
                                    animation: properties.state,
                                    builder: (context, child) {
                                      return VNLDivider(
                                        thickness: 2 * scaling,
                                        color: properties.hasFailure &&
                                                properties.state.value
                                                        .currentStep <=
                                                    i
                                            ? theme.colorScheme.destructive
                                            : properties.state.value
                                                        .currentStep >=
                                                    i
                                                ? theme.colorScheme.primary
                                                : theme.colorScheme.border,
                                      );
                                    }),
                              ),
                      ],
                    ),
                    Gap(densityGap * 0.5),
                    Center(
                      child: DefaultTextStyle.merge(
                        textAlign: TextAlign.center,
                        child: properties.size.wrapper(
                          context,
                          steps[i].title,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
          AnimatedBuilder(
              animation: properties.state,
              builder: (context, child) {
                var current = properties.state.value.currentStep;
                return Flexible(
                    child: IndexedStack(
                  index: current < 0 || current >= properties.steps.length
                      ? properties.steps.length // will show the placeholder
                      : current,
                  children: [
                    for (int i = 0; i < properties.steps.length; i++)
                      properties[i]?.contentBuilder?.call(context) ??
                          const SizedBox(),
                    const SizedBox(), // for placeholder
                  ],
                ));
              }),
        ],
      );
    } else {
      // it's just the same as circle variant
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        children.add(
          Data.inherit(
            data: VNLStepNumberData(stepIndex: i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    properties.steps[i].icon ?? const VNLStepNumber(),
                    Gap(densityGap),
                    properties.size.wrapper(context, properties.steps[i].title),
                  ],
                ),
                Gap(densityGap),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: densityGap * 2,
                  ),
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        top: 0,
                        start: 0,
                        bottom: 0,
                        child: SizedBox(
                          width: properties.size.size,
                          child: i == properties.steps.length - 1
                              ? null
                              : AnimatedBuilder(
                                  animation: properties.state,
                                  builder: (context, child) {
                                    return VNLVerticalDivider(
                                      thickness: 2 * scaling,
                                      color: properties.hasFailure &&
                                              properties.state.value
                                                      .currentStep <=
                                                  i
                                          ? theme.colorScheme.destructive
                                          : properties.state.value
                                                      .currentStep >=
                                                  i
                                              ? theme.colorScheme.primary
                                              : theme.colorScheme.border,
                                    );
                                  }),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: properties.state,
                          child:
                              properties.steps[i].contentBuilder?.call(context),
                          builder: (context, child) {
                            return AnimatedCrossFade(
                              firstChild: Container(
                                height: 0,
                              ),
                              secondChild: Container(
                                margin: EdgeInsets.only(
                                  left: properties.size.size,
                                ),
                                child: child!,
                              ),
                              firstCurve: const Interval(0.0, 0.6,
                                  curve: Curves.fastOutSlowIn),
                              secondCurve: const Interval(0.4, 1.0,
                                  curve: Curves.fastOutSlowIn),
                              sizeCurve: Curves.fastOutSlowIn,
                              crossFadeState:
                                  properties.state.value.currentStep == i
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                              duration: kDefaultDuration,
                            );
                          }),
                    ],
                  ),
                ),
                AnimatedBuilder(
                    animation: properties.state,
                    builder: (context, child) {
                      if (i == properties.steps.length - 1) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: 8 * scaling,
                      );
                    }),
              ],
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

class _StepVariantLine extends VNLStepVariant {
  const _StepVariantLine();

  @override
  Widget build(BuildContext context, VNLStepProperties properties) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final steps = properties.steps;
    if (properties.direction == Axis.horizontal) {
      List<Widget> children = [];
      for (int i = 0; i < steps.length; i++) {
        children.add(
          Expanded(
            child: Data.inherit(
              data: VNLStepNumberData(stepIndex: i),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                      animation: properties.state,
                      builder: (context, child) {
                        return VNLDivider(
                          thickness: 3 * scaling,
                          color: properties.hasFailure &&
                                  properties.state.value.currentStep <= i
                              ? theme.colorScheme.destructive
                              : properties.state.value.currentStep >= i
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.border,
                        );
                      }),
                  Gap(densityGap),
                  properties.size.wrapper(
                    context,
                    steps[i].title,
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ).gap(densityGap * 2),
          ),
          AnimatedBuilder(
              animation: properties.state,
              builder: (context, child) {
                var current = properties.state.value.currentStep;
                return Flexible(
                    child: IndexedStack(
                  index: current < 0 || current >= properties.steps.length
                      ? properties.steps.length // will show the placeholder
                      : current,
                  children: [
                    for (int i = 0; i < properties.steps.length; i++)
                      properties[i]?.contentBuilder?.call(context) ??
                          const SizedBox(),
                    const SizedBox(), // for placeholder
                  ],
                ));
              }),
        ],
      );
    } else {
      List<Widget> children = [];
      for (int i = 0; i < properties.steps.length; i++) {
        children.add(
          Data.inherit(
            data: VNLStepNumberData(stepIndex: i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedBuilder(
                          animation: properties.state,
                          builder: (context, child) {
                            return VNLVerticalDivider(
                              thickness: 3 * scaling,
                              color: properties.hasFailure &&
                                      properties.state.value.currentStep <= i
                                  ? theme.colorScheme.destructive
                                  : properties.state.value.currentStep >= i
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.border,
                            );
                          }),
                      Gap(densityGap * 2),
                      properties.size
                          .wrapper(context, properties.steps[i].title)
                          .withPadding(vertical: densityGap),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: densityGap * 2,
                  ),
                  child: AnimatedBuilder(
                      animation: properties.state,
                      child: properties.steps[i].contentBuilder?.call(context),
                      builder: (context, child) {
                        return AnimatedCrossFade(
                          firstChild: Container(
                            height: 0,
                          ),
                          secondChild: Container(
                            child: child!,
                          ),
                          firstCurve: const Interval(0.0, 0.6,
                              curve: Curves.fastOutSlowIn),
                          secondCurve: const Interval(0.4, 1.0,
                              curve: Curves.fastOutSlowIn),
                          sizeCurve: Curves.fastOutSlowIn,
                          crossFadeState:
                              properties.state.value.currentStep == i
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          duration: kDefaultDuration,
                        );
                      }),
                ),
                AnimatedBuilder(
                    animation: properties.state,
                    builder: (context, child) {
                      if (i == properties.steps.length - 1) {
                        return const SizedBox();
                      }
                      return SizedBox(
                        height: 8 * scaling,
                      );
                    }),
              ],
            ),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }
  }
}

/// Default small step indicator size in logical pixels.
const kSmallStepIndicatorSize = 36.0;

/// Default medium step indicator size in logical pixels.
const kMediumStepIndicatorSize = 40.0;

/// Default large step indicator size in logical pixels.
const kLargeStepIndicatorSize = 44.0;

/// Contains properties and state information for stepper rendering.
///
/// Used internally by [VNLStepVariant] implementations to build the
/// appropriate stepper layout. Provides access to step data, current
/// state, sizing configuration, and layout direction.
///
/// Also includes utility methods like [hasFailure] to check for failed
/// steps and array-style access to individual steps.
class VNLStepProperties {
  /// Size configuration for step indicators.
  final VNLStepSize size;

  /// List of steps in the stepper.
  final List<VNLStep> steps;

  /// Listenable state containing current step and step states.
  final ValueListenable<VNLStepperValue> state;

  /// Layout direction for the stepper.
  final Axis direction;

  /// Creates [VNLStepProperties].
  const VNLStepProperties({
    required this.size,
    required this.steps,
    required this.state,
    required this.direction,
  });

  /// Safely accesses a step by index, returning null if out of bounds.
  VNLStep? operator [](int index) {
    if (index < 0 || index >= steps.length) {
      return null;
    }
    return steps[index];
  }

  /// Returns true if any step has a failed state.
  bool get hasFailure => state.value.stepStates.containsValue(VNLStepState.failed);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLStepProperties &&
        other.size == size &&
        listEquals(other.steps, steps) &&
        other.state == state &&
        other.direction == direction;
  }

  @override
  int get hashCode => Object.hash(size, steps, state, direction);
}

/// Controller for managing stepper state and navigation.
///
/// Extends [ValueNotifier] to provide reactive state updates when
/// the current step changes or step states are modified. Includes
/// methods for navigation (next/previous), direct step jumping,
/// and setting individual step states.
///
/// The controller should be disposed when no longer needed to prevent
/// memory leaks.
///
/// Example:
/// ```dart
/// final controller = VNLStepperController(currentStep: 0);
///
/// // Navigate to next step
/// controller.nextStep();
///
/// // Mark step as failed
/// controller.setStatus(1, VNLStepState.failed);
///
/// // Jump to specific step
/// controller.jumpToStep(3);
///
/// // Don't forget to dispose
/// controller.dispose();
/// ```
class VNLStepperController extends ValueNotifier<VNLStepperValue> {
  /// Creates a [VNLStepperController].
  ///
  /// Parameters:
  /// - [stepStates] (`Map<int, VNLStepState>?`): initial step states (default: empty)
  /// - [currentStep] (int?): initial active step index (default: 0)
  ///
  /// Example:
  /// ```dart
  /// final controller = VNLStepperController(
  ///   currentStep: 1,
  ///   stepStates: {0: VNLStepState.failed},
  /// );
  /// ```
  VNLStepperController({
    Map<int, VNLStepState>? stepStates,
    int? currentStep,
  }) : super(VNLStepperValue(
          stepStates: stepStates ?? {},
          currentStep: currentStep ?? 0,
        ));

  /// Advances to the next step.
  ///
  /// Increments the current step index by 1. Does not validate
  /// if the next step exists - callers should check bounds.
  ///
  /// Example:
  /// ```dart
  /// if (controller.value.currentStep < steps.length - 1) {
  ///   controller.nextStep();
  /// }
  /// ```
  void nextStep() {
    value = VNLStepperValue(
      stepStates: value.stepStates,
      currentStep: value.currentStep + 1,
    );
  }

  /// Returns to the previous step.
  ///
  /// Decrements the current step index by 1. Does not validate
  /// if the previous step exists - callers should check bounds.
  ///
  /// Example:
  /// ```dart
  /// if (controller.value.currentStep > 0) {
  ///   controller.previousStep();
  /// }
  /// ```
  void previousStep() {
    value = VNLStepperValue(
      stepStates: value.stepStates,
      currentStep: value.currentStep - 1,
    );
  }

  /// Sets or clears the state of a specific step.
  ///
  /// Parameters:
  /// - [step] (int): zero-based step index to modify
  /// - [state] (VNLStepState?): new state, or null to clear
  ///
  /// Example:
  /// ```dart
  /// // Mark step as failed
  /// controller.setStatus(2, VNLStepState.failed);
  ///
  /// // Clear step state
  /// controller.setStatus(2, null);
  /// ```
  void setStatus(int step, VNLStepState? state) {
    Map<int, VNLStepState> newStates = Map.from(value.stepStates);
    if (state == null) {
      newStates.remove(step);
    } else {
      newStates[step] = state;
    }
    value = VNLStepperValue(
      stepStates: newStates,
      currentStep: value.currentStep,
    );
  }

  /// Jumps directly to the specified step.
  ///
  /// Parameters:
  /// - [step] (int): zero-based step index to navigate to
  ///
  /// Example:
  /// ```dart
  /// // Jump to final step
  /// controller.jumpToStep(steps.length - 1);
  /// ```
  void jumpToStep(int step) {
    value = VNLStepperValue(
      stepStates: value.stepStates,
      currentStep: step,
    );
  }
}

/// A multi-step navigation component with visual progress indication.
///
/// Displays a sequence of steps with customizable visual styles, supporting
/// both horizontal and vertical layouts. Each step can have a title, optional
/// content, and custom icons. The component tracks current step progress and
/// can display failed states.
///
/// Uses a [VNLStepperController] for state management and navigation. VNLSteps are
/// defined using [VNLStep] objects, and visual presentation is controlled by
/// [VNLStepVariant] and [VNLStepSize] configurations.
///
/// The stepper automatically handles step indicators, connecting lines or
/// progress bars, and animated content transitions between steps.
///
/// Example:
/// ```dart
/// final controller = VNLStepperController();
///
/// VNLStepper(
///   controller: controller,
///   direction: Axis.vertical,
///   variant: VNLStepVariant.circle,
///   size: VNLStepSize.medium,
///   steps: [
///     VNLStep(
///       title: Text('Personal Info'),
///       contentBuilder: (context) => PersonalInfoForm(),
///     ),
///     VNLStep(
///       title: Text('Address'),
///       contentBuilder: (context) => AddressForm(),
///     ),
///     VNLStep(
///       title: Text('Confirmation'),
///       contentBuilder: (context) => ConfirmationView(),
///     ),
///   ],
/// );
/// ```
class VNLStepper extends StatelessWidget {
  /// Controller for managing stepper state and navigation.
  final VNLStepperController controller;

  /// List of steps to display in the stepper.
  final List<VNLStep> steps;

  /// Layout direction (horizontal or vertical).
  final Axis? direction;

  /// Size variant for step indicators.
  final VNLStepSize? size;

  /// Visual variant for step presentation.
  final VNLStepVariant? variant;

  /// Creates a [VNLStepper].
  ///
  /// The [controller] and [steps] are required. Other parameters are optional
  /// and will use theme defaults or built-in defaults if not provided.
  ///
  /// Parameters:
  /// - [controller] (VNLStepperController, required): manages state and navigation
  /// - [steps] (`List<VNLStep>`, required): list of steps to display
  /// - [direction] (Axis?): horizontal or vertical layout (default: horizontal)
  /// - [size] (VNLStepSize?): step indicator size (default: medium)
  /// - [variant] (VNLStepVariant?): visual style (default: circle)
  ///
  /// Example:
  /// ```dart
  /// final controller = VNLStepperController(currentStep: 0);
  ///
  /// VNLStepper(
  ///   controller: controller,
  ///   direction: Axis.vertical,
  ///   size: VNLStepSize.large,
  ///   variant: VNLStepVariant.line,
  ///   steps: [
  ///     VNLStep(title: Text('VNLStep 1')),
  ///     VNLStep(title: Text('VNLStep 2')),
  ///     VNLStep(title: Text('VNLStep 3')),
  ///   ],
  /// );
  /// ```
  const VNLStepper({
    super.key,
    required this.controller,
    required this.steps,
    this.direction,
    this.size,
    this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = VNLComponentTheme.maybeOf<VNLStepperTheme>(context);
    final dir = direction ?? compTheme?.direction ?? Axis.horizontal;
    final sz = size ?? compTheme?.size ?? VNLStepSize.medium;
    final varnt = variant ?? compTheme?.variant ?? VNLStepVariant.circle;
    var stepProperties = VNLStepProperties(
        size: sz, steps: steps, state: controller, direction: dir);
    return Data.inherit(
      data: stepProperties,
      child: varnt.build(context, stepProperties),
    );
  }
}

/// Data class providing step index context to descendant widgets.
///
/// Used internally by the stepper to pass the current step index
/// to child widgets like [VNLStepNumber]. Accessible via [Data.maybeOf].
///
/// Example:
/// ```dart
/// final stepData = Data.maybeOf<VNLStepNumberData>(context);
/// final stepIndex = stepData?.stepIndex ?? 0;
/// ```
class VNLStepNumberData {
  /// Zero-based index of the step.
  final int stepIndex;

  /// Creates [VNLStepNumberData].
  const VNLStepNumberData({
    required this.stepIndex,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLStepNumberData && other.stepIndex == stepIndex;
  }

  @override
  int get hashCode => stepIndex.hashCode;

  @override
  String toString() {
    return 'VNLStepNumberData{stepIndex: $stepIndex}';
  }
}

/// VNLStep indicator widget displaying step number, checkmark, or custom icon.
///
/// Renders a circular (or rectangular based on theme) step indicator that
/// shows the step number by default, a checkmark for completed steps,
/// or an X for failed steps. VNLColors and states are automatically managed
/// based on the stepper's current state.
///
/// Must be used within a [VNLStepper] widget tree to access step context.
/// Optionally supports custom icons and click handling.
///
/// Example:
/// ```dart
/// VNLStepNumber(
///   icon: Icon(Icons.star),
///   onPressed: () => print('VNLStep tapped'),
/// );
/// ```
class VNLStepNumber extends StatelessWidget {
  /// Custom icon to display instead of step number.
  final Widget? icon;

  /// Callback invoked when the step indicator is pressed.
  final VoidCallback? onPressed;

  /// Creates a [VNLStepNumber].
  ///
  /// Both parameters are optional. If [icon] is provided, it replaces
  /// the default step number. If [onPressed] is provided, the step
  /// becomes clickable.
  ///
  /// Parameters:
  /// - [icon] (Widget?): custom icon replacing step number
  /// - [onPressed] (VoidCallback?): tap callback for interaction
  ///
  /// Example:
  /// ```dart
  /// VNLStepNumber(
  ///   icon: Icon(Icons.person),
  ///   onPressed: () => jumpToStep(stepIndex),
  /// );
  /// ```
  const VNLStepNumber({
    super.key,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final properties = Data.maybeOf<VNLStepProperties>(context);
    final stepNumberData = Data.maybeOf<VNLStepNumberData>(context);
    assert(properties != null, 'VNLStepNumber must be a descendant of VNLStepper');
    assert(stepNumberData != null,
        'VNLStepNumber must be a descendant of VNLStepNumberData');
    final int stepIndex = stepNumberData!.stepIndex;
    final theme = Theme.of(context);
    return AnimatedBuilder(
        animation: properties!.state,
        builder: (context, child) {
          return properties.size.wrapper(
            context,
            DefaultTextStyle.merge(
              style: TextStyle(
                color: properties.state.value.stepStates[stepIndex] ==
                        VNLStepState.failed
                    ? theme.colorScheme.destructive
                    : theme.colorScheme.primary,
              ).merge(theme.typography.medium),
              child: IconTheme.merge(
                data: IconThemeData(
                  color: properties.state.value.stepStates[stepIndex] ==
                          VNLStepState.failed
                      ? theme.colorScheme.destructive
                      : properties.state.value.currentStep > stepIndex
                          ? theme.colorScheme.background
                          : theme.colorScheme.primary,
                ),
                child: SizedBox(
                  // these sizes are not constant, but the source value is from constant enum value
                  width: properties.size.size * theme.scaling,
                  height: properties.size.size * theme.scaling,
                  child: VNLClickable(
                    enabled: onPressed != null,
                    onPressed: onPressed,
                    mouseCursor: WidgetStatePropertyAll(
                      onPressed != null
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                    ),
                    decoration: WidgetStateProperty.resolveWith(
                      (states) {
                        return BoxDecoration(
                          shape: theme.radius == 0
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          color: properties.state.value.stepStates[stepIndex] ==
                                  VNLStepState.failed
                              ? theme.colorScheme.destructive
                              : properties.state.value.currentStep > stepIndex
                                  ? theme.colorScheme.primary
                                  : properties.state.value.currentStep ==
                                              stepIndex ||
                                          states
                                              .contains(WidgetState.hovered) ||
                                          states.contains(WidgetState.focused)
                                      ? theme.colorScheme.secondary
                                      : theme.colorScheme.background,
                          border: Border.all(
                            color:
                                properties.state.value.stepStates[stepIndex] ==
                                        VNLStepState.failed
                                    ? theme.colorScheme.destructive
                                    : properties.state.value.currentStep >=
                                            stepIndex
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.border,
                            width: 2 * theme.scaling,
                          ),
                        );
                      },
                    ),
                    child: Center(
                      child: properties.state.value.stepStates[stepIndex] ==
                              VNLStepState.failed
                          ? const Icon(
                              Icons.close,
                              color: VNLColors.white,
                            )
                          : properties.state.value.currentStep > stepIndex
                              ? Icon(
                                  Icons.check,
                                  color: theme.colorScheme.background,
                                )
                              : icon ?? Text((stepIndex + 1).toString()),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

/// VNLClickable step title widget with optional subtitle.
///
/// Displays the step title and optional subtitle in a clickable container.
/// Used within stepper layouts to provide interactive step navigation.
/// Supports customizable cross-axis alignment for text positioning.
///
/// Example:
/// ```dart
/// VNLStepTitle(
///   title: Text('Account Setup'),
///   subtitle: Text('Enter your personal details'),
///   onPressed: () => jumpToThisStep(),
/// );
/// ```
class VNLStepTitle extends StatelessWidget {
  /// The main title widget for the step.
  final Widget title;

  /// Optional subtitle widget displayed below the title.
  final Widget? subtitle;

  /// Cross-axis alignment for the title and subtitle.
  final CrossAxisAlignment crossAxisAlignment;

  /// Callback invoked when the title is pressed.
  final VoidCallback? onPressed;

  /// Creates a [VNLStepTitle].
  ///
  /// The [title] is required. The [subtitle], [crossAxisAlignment], and
  /// [onPressed] parameters are optional.
  ///
  /// Parameters:
  /// - [title] (Widget, required): main title content
  /// - [subtitle] (Widget?): optional subtitle below title
  /// - [crossAxisAlignment] (CrossAxisAlignment): text alignment (default: stretch)
  /// - [onPressed] (VoidCallback?): tap callback for interaction
  ///
  /// Example:
  /// ```dart
  /// VNLStepTitle(
  ///   title: Text('Payment Info'),
  ///   subtitle: Text('Credit card details'),
  ///   crossAxisAlignment: CrossAxisAlignment.center,
  ///   onPressed: () => navigateToPayment(),
  /// );
  /// ```
  const VNLStepTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    return VNLClickable(
      mouseCursor: WidgetStatePropertyAll(
          onPressed == null ? MouseCursor.defer : SystemMouseCursors.click),
      onPressed: onPressed,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            title,
            if (subtitle != null) ...[
              Gap(densityGap * 0.25),
              subtitle!.muted().xSmall(),
            ],
          ],
        ),
      ),
    );
  }
}

/// Container widget for step content with optional action buttons.
///
/// Provides consistent padding and layout for step content, with optional
/// action buttons displayed below the main content. Actions are arranged
/// horizontally with appropriate spacing.
///
/// Typically used within step content builders to provide a consistent
/// layout for form content, descriptions, and navigation buttons.
///
/// Example:
/// ```dart
/// VNLStepContainer(
///   child: Column(
///     children: [
///       TextFormField(decoration: InputDecoration(labelText: 'Name')),
///       TextFormField(decoration: InputDecoration(labelText: 'Email')),
///     ],
///   ),
///   actions: [
///     VNLButton(
///       onPressed: controller.previousStep,
///       child: Text('Back'),
///     ),
///     VNLButton(
///       onPressed: controller.nextStep,
///       child: Text('Next'),
///     ),
///   ],
/// );
/// ```
class VNLStepContainer extends StatefulWidget {
  /// The main content widget for the step.
  final Widget child;

  /// List of action widgets (typically buttons) displayed below content.
  final List<Widget> actions;

  /// Creates a [VNLStepContainer].
  ///
  /// The [child] and [actions] parameters are required. Actions can be
  /// an empty list if no buttons are needed.
  ///
  /// Parameters:
  /// - [child] (Widget, required): main step content
  /// - [actions] (`List<Widget>`, required): action buttons or widgets
  ///
  /// Example:
  /// ```dart
  /// VNLStepContainer(
  ///   child: FormFields(),
  ///   actions: [
  ///     VNLButton(onPressed: previousStep, child: Text('Back')),
  ///     VNLButton(onPressed: nextStep, child: Text('Continue')),
  ///   ],
  /// );
  /// ```
  const VNLStepContainer({
    super.key,
    required this.child,
    required this.actions,
  });

  @override
  State<VNLStepContainer> createState() => _StepContainerState();
}

class _StepContainerState extends State<VNLStepContainer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final densityContainerPadding =
        theme.density.baseContainerPadding * scaling;
    if (widget.actions.isEmpty) {
      return widget.child.withPadding(
        vertical: densityContainerPadding,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.child,
        Gap(densityGap * 2),
        Row(
          children: widget.actions,
        ).gap(densityGap),
      ],
    ).withPadding(
      vertical: densityContainerPadding,
    );
  }
}
