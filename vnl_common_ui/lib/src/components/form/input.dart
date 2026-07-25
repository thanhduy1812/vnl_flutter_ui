import 'dart:async';

import 'package:flutter/services.dart' show Clipboard, LogicalKeyboardKey;
import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Position where an input feature is displayed.
///
/// Determines whether an input feature (icon, button, widget) appears on
/// the leading (left/start) or trailing (right/end) side of the input.
enum VNLInputFeaturePosition {
  /// Display the feature on the leading side.
  leading,

  /// Display the feature on the trailing side.
  trailing,

  /// Display above the editable text.
  above,

  /// Display below the editable text.
  below,
}

/// Adds a hint/info button to the input field with a popover.
///
/// Displays an icon button that shows a popover with additional information
/// when clicked. Optionally supports keyboard shortcuts (F1) to open the hint.
///
/// Example:
/// ```dart
/// VNLTextField(
///   features: [
///     VNLInputHintFeature(
///       popupBuilder: (context) => const Text('Enter your email'),
///       icon: Icon(Icons.help),
///     ),
///   ],
/// )
/// ```
class VNLInputHintFeature extends VNLInputFeature {
  /// Builder for the hint popover content.
  final WidgetBuilder popupBuilder;

  /// Custom icon to display (defaults to info icon).
  final Widget? icon;

  /// Position of the hint button.
  final VNLInputFeaturePosition position;

  /// Whether to enable keyboard shortcut (F1) to show the hint.
  final bool enableShortcuts;

  /// Creates an [VNLInputHintFeature].
  ///
  /// Parameters:
  /// - [popupBuilder] (`WidgetBuilder`, required): Builds the hint content.
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.trailing`):
  ///   Where to place the hint icon.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [enableShortcuts] (`bool`, default: `true`): Enable F1 keyboard shortcut.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputHintFeature({
    super.visibility,
    super.skipFocusTraversal,
    required this.popupBuilder,
    this.position = VNLInputFeaturePosition.trailing,
    this.icon,
    this.enableShortcuts = true,
  });

  @override
  InputFeatureState createState() => _InputHintFeatureState();
}

class _InputHintFeatureState extends InputFeatureState<VNLInputHintFeature> {
  final _popoverController = VNLPopoverController();
  void _showPopup(BuildContext context) {
    _popoverController.show(
      context: context,
      builder: feature.popupBuilder,
      alignment: AlignmentDirectional.topCenter,
      anchorAlignment: AlignmentDirectional.bottomCenter,
    );
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == VNLInputFeaturePosition.trailing) {
      yield Builder(builder: (context) {
        return VNLIconButton.text(
          icon: feature.icon ?? const Icon(LucideIcons.info),
          onPressed: () => _showPopup(context),
          density: VNLButtonDensity.compact,
        );
      });
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == VNLInputFeaturePosition.leading) {
      yield VNLIconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.info),
        onPressed: () => _showPopup(context),
        density: VNLButtonDensity.compact,
      );
    }
  }

  @override
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts() sync* {
    if (feature.enableShortcuts) {
      yield const MapEntry(
        SingleActivator(LogicalKeyboardKey.f1),
        VNLInputShowHintIntent(),
      );
    }
  }

  @override
  Iterable<MapEntry<Type, Action<Intent>>> buildActions() sync* {
    if (feature.enableShortcuts) {
      yield MapEntry(
        VNLInputShowHintIntent,
        CallbackContextAction<VNLInputShowHintIntent>(
          onInvoke: (intent, [context]) {
            if (context == null) {
              throw FlutterError(
                  'CallbackContextAction was invoked without a valid BuildContext. '
                  'This likely indicates a problem in the action system. '
                  'Context must not be null when invoking VNLInputShowHintIntent.');
            }
            _showPopup(context);
            return true;
          },
        ),
      );
    }
  }
}

/// Intent to show an input hint popover.
///
/// Used in keyboard shortcut actions to trigger the hint display.
class VNLInputShowHintIntent extends Intent {
  /// Creates an [VNLInputShowHintIntent].
  const VNLInputShowHintIntent();
}

/// Mode for password visibility toggling.
///
/// Determines whether the password visibility toggle holds (shows while pressed)
/// or toggles (switches state on each press).
enum VNLPasswordPeekMode {
  /// Show password only while button is held down.
  hold,

  /// VNLToggle password visibility on each press.
  toggle,
}

/// Adds a password visibility toggle feature to the input field.
///
/// Provides a button that allows users to toggle between showing and hiding
/// password text. Supports both hold-to-reveal and toggle modes.
///
/// Example:
/// ```dart
/// VNLTextField(
///   obscureText: true,
///   features: [
///     VNLInputPasswordToggleFeature(
///       mode: VNLPasswordPeekMode.toggle,
///     ),
///   ],
/// )
/// ```
class VNLInputPasswordToggleFeature extends VNLInputFeature {
  /// The mode for password peeking behavior.
  final VNLPasswordPeekMode mode;

  /// Position of the toggle button.
  final VNLInputFeaturePosition position;

  /// Icon to display when password is hidden.
  final Widget? icon;

  /// Icon to display when password is shown.
  final Widget? iconShow;

  /// Creates an [VNLInputPasswordToggleFeature].
  ///
  /// Parameters:
  /// - [mode] (`VNLPasswordPeekMode`, default: `VNLPasswordPeekMode.toggle`):
  ///   VNLToggle or hold behavior.
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.trailing`):
  ///   Where to place the toggle.
  /// - [icon] (`Widget?`, optional): Custom icon for hidden state.
  /// - [iconShow] (`Widget?`, optional): Custom icon for visible state.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputPasswordToggleFeature({
    super.visibility,
    this.icon,
    this.iconShow,
    this.mode = VNLPasswordPeekMode.toggle,
    this.position = VNLInputFeaturePosition.trailing,
    super.skipFocusTraversal,
  });

  @override
  InputFeatureState createState() => _InputPasswordToggleFeatureState();
}

class _InputPasswordToggleFeatureState
    extends InputFeatureState<VNLInputPasswordToggleFeature> {
  bool? _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      if (_obscureText == null) {
        _obscureText = true;
      } else {
        _obscureText = null;
      }
    });
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == VNLInputFeaturePosition.trailing) {
      yield _buildIconButton();
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == VNLInputFeaturePosition.leading) {
      yield _buildIconButton();
    }
  }

  Widget _buildIcon() {
    if (_obscureText == true || input.obscureText) {
      return feature.icon ?? const Icon(LucideIcons.eye);
    }
    return feature.iconShow ?? const Icon(LucideIcons.eyeOff);
  }

  Widget _buildIconButton() {
    if (feature.mode == VNLPasswordPeekMode.hold) {
      return VNLIconButton.text(
        icon: _buildIcon(),
        onTapDown: (_) {
          setState(() {
            _obscureText = null;
          });
        },
        onTapUp: (_) {
          setState(() {
            _obscureText = true;
          });
        },
        enabled: true,
        density: VNLButtonDensity.compact,
      );
    }
    return VNLIconButton.text(
      icon: _buildIcon(),
      onPressed: _toggleObscureText,
      density: VNLButtonDensity.compact,
    );
  }

  @override
  VNLTextField interceptInput(VNLTextField input) {
    return input.copyWith(
      obscureText: () => _obscureText ?? false,
    );
  }
}

/// Adds a clear button to the input field.
///
/// Provides a button that clears all text from the input when pressed.
/// Commonly used to improve user experience by offering quick text removal.
///
/// Example:
/// ```dart
/// VNLTextField(
///   features: [
///     VNLInputClearFeature(
///       position: VNLInputFeaturePosition.trailing,
///     ),
///   ],
/// )
/// ```
class VNLInputClearFeature extends VNLInputFeature {
  /// Position of the clear button.
  final VNLInputFeaturePosition position;

  /// Custom icon for the clear button.
  final Widget? icon;

  /// Creates an [VNLInputClearFeature].
  ///
  /// Parameters:
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.trailing`):
  ///   Where to place the clear button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputClearFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.position = VNLInputFeaturePosition.trailing,
    this.icon,
  });

  @override
  InputFeatureState createState() => _InputClearFeatureState();
}

class _InputClearFeatureState extends InputFeatureState<VNLInputClearFeature> {
  void _clear() {
    controller.text = '';
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == VNLInputFeaturePosition.trailing) {
      yield VNLIconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.x),
        onPressed: _clear,
        density: VNLButtonDensity.compact,
      );
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == VNLInputFeaturePosition.leading) {
      yield VNLIconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.x),
        onPressed: _clear,
        density: VNLButtonDensity.compact,
      );
    }
  }
}

/// Adds a revalidate button to the input field.
///
/// Provides a button that triggers form validation when pressed.
/// Useful for manually triggering validation after user input.
///
/// Example:
/// ```dart
/// VNLTextField(
///   features: [
///     VNLInputRevalidateFeature(),
///   ],
/// )
/// ```
class VNLInputRevalidateFeature extends VNLInputFeature {
  /// Position of the revalidate button.
  final VNLInputFeaturePosition position;

  /// Custom icon for the revalidate button.
  final Widget? icon;

  /// Creates an [VNLInputRevalidateFeature].
  ///
  /// Parameters:
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.trailing`):
  ///   Where to place the revalidate button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputRevalidateFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.position = VNLInputFeaturePosition.trailing,
    this.icon,
  });

  @override
  InputFeatureState createState() => _InputRevalidateFeatureState();
}

class _InputRevalidateFeatureState
    extends InputFeatureState<VNLInputRevalidateFeature> {
  void _revalidate() {
    var formFieldHandle = Data.maybeFind<FormFieldHandle>(context);
    if (formFieldHandle != null) {
      formFieldHandle.revalidate();
    }
  }

  Widget _buildIcon() {
    return VNLFormPendingBuilder(
      builder: (context, futures, _) {
        if (futures.isEmpty) {
          return VNLIconButton.text(
            icon: feature.icon ?? const Icon(LucideIcons.refreshCw),
            onPressed: _revalidate,
            density: VNLButtonDensity.compact,
          );
        }

        var futureAll = Future.wait(futures.values);
        return FutureBuilder(
          future: futureAll,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return VNLIconButton.text(
                icon: RepeatedAnimationBuilder(
                  start: 0.0,
                  end: 360.0,
                  duration: const Duration(seconds: 1),
                  child: feature.icon ?? const Icon(LucideIcons.refreshCw),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: degToRad(value),
                      child: child,
                    );
                  },
                ),
                onPressed: null,
                density: VNLButtonDensity.compact,
              );
            }
            return VNLIconButton.text(
              icon: feature.icon ?? const Icon(LucideIcons.refreshCw),
              onPressed: _revalidate,
              density: VNLButtonDensity.compact,
            );
          },
        );
      },
    );
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == VNLInputFeaturePosition.trailing) {
      yield _buildIcon();
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == VNLInputFeaturePosition.leading) {
      yield _buildIcon();
    }
  }
}

/// A callback that provides suggestions based on a query string.
///
/// Parameters:
/// - [query] (`String`): The current input text to generate suggestions for.
///
/// Returns: `FutureOr<Iterable<String>>` — The list of suggestion strings.
typedef SuggestionBuilder = FutureOr<Iterable<String>> Function(String query);

/// Adds autocomplete functionality to the input field.
///
/// Displays a popover with suggestions as the user types. Suggestions are
/// provided by the [querySuggestions] callback and can be selected to fill
/// the input.
///
/// Example:
/// ```dart
/// VNLTextField(
///   features: [
///     VNLInputAutoCompleteFeature(
///       querySuggestions: (query) async {
///         return ['apple', 'apricot', 'avocado']
///             .where((s) => s.startsWith(query));
///       },
///       child: const Text('Fruits'),
///     ),
///   ],
/// )
/// ```
class VNLInputAutoCompleteFeature extends VNLInputFeature {
  /// Callback to provide suggestions for a given query.
  final SuggestionBuilder querySuggestions;

  /// Child widget displayed in the suggestion list.
  final Widget child;

  /// Constraints for the popover size.
  final BoxConstraints? popoverConstraints;

  /// Width constraint for the popover.
  final VNLPopoverConstraint? popoverWidthConstraint;

  /// Anchor alignment for the popover.
  final AlignmentDirectional? popoverAnchorAlignment;

  /// VNLPopover alignment relative to the anchor.
  final AlignmentDirectional? popoverAlignment;

  /// Autocomplete mode (e.g., popover or inline).
  final VNLAutoCompleteMode mode;

  /// Creates an [VNLInputAutoCompleteFeature].
  ///
  /// Parameters:
  /// - [querySuggestions] (`SuggestionBuilder`, required): Provides suggestions.
  /// - [child] (`Widget`, required): Content for suggestion items.
  /// - [popoverConstraints] (`BoxConstraints?`, optional): Size constraints.
  /// - [popoverWidthConstraint] (`VNLPopoverConstraint?`, optional): Width constraint.
  /// - [popoverAnchorAlignment] (`AlignmentDirectional?`, optional): Anchor alignment.
  /// - [popoverAlignment] (`AlignmentDirectional?`, optional): VNLPopover alignment.
  /// - [mode] (`VNLAutoCompleteMode`, required): Autocomplete display mode.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputAutoCompleteFeature({
    super.visibility,
    super.skipFocusTraversal,
    required this.querySuggestions,
    required this.child,
    this.popoverConstraints,
    this.popoverWidthConstraint,
    this.popoverAnchorAlignment,
    this.popoverAlignment,
    this.mode = VNLAutoCompleteMode.replaceWord,
  });

  @override
  InputFeatureState createState() => _AutoCompleteFeatureState();
}

class _AutoCompleteFeatureState
    extends InputFeatureState<VNLInputAutoCompleteFeature> {
  final GlobalKey _key = GlobalKey();
  final ValueNotifier<FutureOr<Iterable<String>>?> _suggestions =
      ValueNotifier(null);

  @override
  void onTextChanged(String text) {
    _suggestions.value = feature.querySuggestions(text);
  }

  @override
  Widget wrap(Widget child) {
    return ListenableBuilder(
      listenable: _suggestions,
      builder: (context, child) {
        var suggestions = _suggestions.value;
        if (suggestions is Future<Iterable<String>>) {
          return FutureBuilder(
            future: suggestions,
            builder: (context, snapshot) {
              return VNLAutoComplete(
                key: _key,
                suggestions:
                    snapshot.hasData ? snapshot.requireData.toList() : const [],
                popoverConstraints: feature.popoverConstraints,
                popoverWidthConstraint: feature.popoverWidthConstraint,
                popoverAnchorAlignment: feature.popoverAnchorAlignment,
                popoverAlignment: feature.popoverAlignment,
                mode: feature.mode,
                child: child!,
              );
            },
          );
        }
        return VNLAutoComplete(
          key: _key,
          suggestions: suggestions == null ? const [] : suggestions.toList(),
          popoverConstraints: feature.popoverConstraints,
          popoverWidthConstraint: feature.popoverWidthConstraint,
          popoverAnchorAlignment: feature.popoverAnchorAlignment,
          popoverAlignment: feature.popoverAlignment,
          mode: feature.mode,
          child: child!,
        );
      },
      child: child,
    );
  }
}

/// Adds spinner controls (increment/decrement) to numeric input fields.
///
/// Provides up/down buttons to adjust numeric values in fixed steps.
/// Optionally supports gesture-based adjustments (e.g., drag to change value).
///
/// Example:
/// ```dart
/// VNLTextField(
///   keyboardType: TextInputType.number,
///   features: [
///     VNLInputSpinnerFeature(
///       step: 5.0,
///       enableGesture: true,
///     ),
///   ],
/// )
/// ```
class VNLInputSpinnerFeature extends VNLInputFeature {
  /// The amount to increment or decrement on each step.
  final double step;

  /// Whether to enable gesture-based value adjustment.
  final bool enableGesture;

  /// Default value when the input is invalid or empty.
  final double? invalidValue;

  /// Minimum allowed value.
  final double? min;

  /// Maximum allowed value.
  final double? max;

  /// Creates an [VNLInputSpinnerFeature].
  ///
  /// Parameters:
  /// - [step] (`double`, default: `1.0`): Increment/decrement step size.
  /// - [enableGesture] (`bool`, default: `true`): Enable drag gestures.
  /// - [invalidValue] (`double?`, default: `0.0`): Fallback value for invalid input.
  /// - [min] (`double?`, optional): Minimum allowed value.
  /// - [max] (`double?`, optional): Maximum allowed value.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputSpinnerFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.step = 1.0,
    this.enableGesture = true,
    this.invalidValue = 0.0,
    this.min,
    this.max,
  });

  @override
  InputFeatureState createState() => _InputSpinnerFeatureState();
}

class _InputSpinnerFeatureState extends InputFeatureState<VNLInputSpinnerFeature> {
  double _clampValue(double value) {
    final min = feature.min;
    final max = feature.max;
    if (min != null && value < min) {
      return min;
    }
    if (max != null && value > max) {
      return max;
    }
    return value;
  }

  double? _effectiveValue() {
    final value = double.tryParse(controller.text);
    return value ?? feature.invalidValue;
  }

  bool _canIncrease(double? value) {
    if (value == null) return false;
    final max = feature.max;
    return max == null || value < max;
  }

  bool _canDecrease(double? value) {
    if (value == null) return false;
    final min = feature.min;
    return min == null || value > min;
  }

  void _replaceText(UnaryOperator<String> replacer) {
    var controller = this.controller;
    var text = controller.text;
    var newText = replacer(text);
    if (newText != text) {
      controller.text = newText;
      input.onChanged?.call(newText);
    }
  }

  void _increase() {
    _replaceText((text) {
      var value = double.tryParse(text);
      if (value == null) {
        if (feature.invalidValue != null) {
          return _newText(_clampValue(feature.invalidValue!));
        }
        return text;
      }
      return _newText(_clampValue(value + feature.step));
    });
  }

  String _newText(double value) {
    String newText = value.toString();
    if (newText.contains('.')) {
      while (newText.endsWith('0')) {
        newText = newText.substring(0, newText.length - 1);
      }
      if (newText.endsWith('.')) {
        newText = newText.substring(0, newText.length - 1);
      }
    }
    return newText;
  }

  void _decrease() {
    _replaceText((text) {
      var value = double.tryParse(text);
      if (value == null) {
        if (feature.invalidValue != null) {
          return _newText(_clampValue(feature.invalidValue!));
        }
        return text;
      }
      return _newText(_clampValue(value - feature.step));
    });
  }

  Widget _wrapGesture(Widget child) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < 0) {
          _increase();
        } else {
          _decrease();
        }
      },
      child: child,
    );
  }

  Widget _buildButtons() {
    return Builder(builder: (context) {
      final theme = Theme.of(context);
      return ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, child) {
          final currentValue = _effectiveValue();
          final clampedValue =
              currentValue == null ? null : _clampValue(currentValue);
          final canIncrease = _canIncrease(clampedValue);
          final canDecrease = _canDecrease(clampedValue);
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              VNLIconButton.text(
                icon: Transform.translate(
                  offset: Offset(0, -1 * theme.scaling),
                  child: Transform.scale(
                    alignment: Alignment.center,
                    scale: 1.5,
                    child: const Icon(LucideIcons.chevronUp),
                  ),
                ),
                onPressed: canIncrease ? _increase : null,
                density: VNLButtonDensity.compact,
                size: VNLButtonSize.xSmall,
              ),
              VNLIconButton.text(
                icon: Transform.translate(
                  offset: Offset(0, 1 * theme.scaling),
                  child: Transform.scale(
                    alignment: Alignment.center,
                    scale: 1.5,
                    child: const Icon(LucideIcons.chevronDown),
                  ),
                ),
                onPressed: canDecrease ? _decrease : null,
                density: VNLButtonDensity.compact,
                size: VNLButtonSize.xSmall,
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.enableGesture) {
      yield _wrapGesture(_buildButtons());
    } else {
      yield _buildButtons();
    }
  }
}

/// Adds a single increment button to numeric input fields.
///
/// Provides a button that increases the numeric value by a fixed step.
class InputStepperButtonFeature extends VNLInputFeature {
  /// The amount to increment on each press.
  final double step;

  /// Default value when the input is invalid or empty.
  final double? invalidValue;

  /// Minimum allowed value.
  final double? min;

  /// Maximum allowed value.
  final double? max;

  /// Position of the increment button.
  final VNLInputFeaturePosition position;

  /// Custom icon for the increment button.
  final Widget? icon;

  /// Creates an [InputStepperButtonFeature].
  ///
  /// Parameters:
  /// - [step] (`double`, default: `1.0`): Increment step size.
  /// - [invalidValue] (`double?`, default: `0.0`): Fallback value for invalid input.
  /// - [min] (`double?`, optional): Minimum allowed value.
  /// - [max] (`double?`, optional): Maximum allowed value.
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.trailing`):
  ///   Where to place the button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputStepperButtonFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.step = 1.0,
    this.invalidValue = 0.0,
    this.min,
    this.max,
    this.position = VNLInputFeaturePosition.trailing,
    this.icon = const Icon(LucideIcons.plus),
  });

  /// Creates a decrement button feature for numeric inputs.
  ///
  /// Parameters:
  /// - [step] (`double`, default: `-1.0`): Decrement step size.
  /// - [invalidValue] (`double?`, default: `0.0`): Fallback value for invalid input.
  /// - [min] (`double?`, optional): Minimum allowed value.
  /// - [max] (`double?`, optional): Maximum allowed value.
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.trailing`):
  ///   Where to place the button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputStepperButtonFeature.decrement({
    super.visibility,
    super.skipFocusTraversal,
    this.step = -1.0,
    this.invalidValue = 0.0,
    this.min,
    this.max,
    this.position = VNLInputFeaturePosition.trailing,
    this.icon = const Icon(LucideIcons.minus),
  });

  @override
  InputFeatureState createState() => _InputStepperButtonFeatureState();
}

class _InputStepperButtonFeatureState
    extends InputFeatureState<InputStepperButtonFeature> {
  double _clampValue(double value) {
    final min = feature.min;
    final max = feature.max;
    if (min != null && value < min) {
      return min;
    }
    if (max != null && value > max) {
      return max;
    }
    return value;
  }

  double? _effectiveValue() {
    final value = double.tryParse(controller.text);
    return value ?? feature.invalidValue;
  }

  bool _canApplyStep(double? value) {
    if (value == null) return false;
    final step = feature.step;
    final min = feature.min;
    final max = feature.max;
    if (step >= 0) {
      return max == null || value < max;
    }
    return min == null || value > min;
  }

  void _replaceText(UnaryOperator<String> replacer) {
    var controller = this.controller;
    var text = controller.text;
    var newText = replacer(text);
    if (newText != text) {
      controller.text = newText;
      input.onChanged?.call(newText);
    }
  }

  String _newText(double value) {
    String newText = value.toString();
    if (newText.contains('.')) {
      while (newText.endsWith('0')) {
        newText = newText.substring(0, newText.length - 1);
      }
      if (newText.endsWith('.')) {
        newText = newText.substring(0, newText.length - 1);
      }
    }
    return newText;
  }

  void _increase() {
    _replaceText((text) {
      var value = double.tryParse(text);
      if (value == null) {
        if (feature.invalidValue != null) {
          return _newText(_clampValue(feature.invalidValue!));
        }
        return text;
      }
      return _newText(_clampValue(value + feature.step));
    });
  }

  Widget _buildButton() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final currentValue = _effectiveValue();
        final clampedValue =
            currentValue == null ? null : _clampValue(currentValue);
        final canApplyStep = _canApplyStep(clampedValue);
        return AspectRatio(
          aspectRatio: 1,
          child: VNLIconButton.outline(
            icon: feature.icon ?? const Icon(LucideIcons.plus),
            onPressed: canApplyStep ? _increase : null,
            density: VNLButtonDensity.compact,
            size: VNLButtonSize.small,
          ),
        );
      },
    );
  }

  @override
  Iterable<Widget> buildSuffix() sync* {
    if (feature.position == VNLInputFeaturePosition.trailing) {
      yield _buildButton();
    }
  }

  @override
  Iterable<Widget> buildPrefix() sync* {
    if (feature.position == VNLInputFeaturePosition.leading) {
      yield _buildButton();
    }
  }
}

/// Adds a copy button to the input field.
///
/// Provides a button that copies the current input text to the clipboard.
/// Useful for allowing users to easily copy generated or displayed content.
///
/// Example:
/// ```dart
/// VNLTextField(
///   controller: TextEditingController(text: 'Copy me!'),
///   features: [
///     VNLInputCopyFeature(),
///   ],
/// )
/// ```
class VNLInputCopyFeature extends VNLInputFeature {
  /// Position of the copy button.
  final VNLInputFeaturePosition position;

  /// Custom icon for the copy button.
  final Widget? icon;

  /// Creates an [VNLInputCopyFeature].
  ///
  /// Parameters:
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.trailing`):
  ///   Where to place the copy button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputCopyFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.position = VNLInputFeaturePosition.trailing,
    this.icon,
  });

  @override
  InputFeatureState createState() => _InputCopyFeatureState();
}

class _InputCopyFeatureState extends InputFeatureState<VNLInputCopyFeature> {
  void _copy() {
    Actions.invoke(context, const VNLTextFieldSelectAllAndCopyIntent());
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == VNLInputFeaturePosition.trailing) {
      yield VNLIconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.copy),
        onPressed: _copy,
        density: VNLButtonDensity.compact,
      );
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == VNLInputFeaturePosition.leading) {
      yield VNLIconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.copy),
        onPressed: _copy,
        density: VNLButtonDensity.compact,
      );
    }
  }
}

/// Adds a custom widget to the leading (left) side of the input field.
///
/// Allows you to place any widget before the input text, such as icons,
/// labels, or other decorative elements.
///
/// Example:
/// ```dart
/// VNLTextField(
///   features: [
///     VNLInputLeadingFeature(
///       Icon(Icons.search),
///     ),
///   ],
/// )
/// ```
class VNLInputLeadingFeature extends VNLInputFeature {
  /// The widget to display on the leading side.
  final Widget prefix;

  /// Creates an [VNLInputLeadingFeature].
  ///
  /// Parameters:
  /// - [prefix] (`Widget`, required): The widget to show before the input.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputLeadingFeature(
    this.prefix, {
    super.visibility,
    super.skipFocusTraversal,
  });

  @override
  InputFeatureState createState() => _InputLeadingFeatureState();
}

class _InputLeadingFeatureState extends InputFeatureState<VNLInputLeadingFeature> {
  @override
  Iterable<Widget> buildLeading() sync* {
    yield feature.prefix;
  }
}

/// Adds a custom widget to the trailing (right) side of the input field.
///
/// Allows you to place any widget after the input text, such as icons,
/// buttons, or other decorative elements.
///
/// Example:
/// ```dart
/// VNLTextField(
///   features: [
///     VNLInputTrailingFeature(
///       Icon(Icons.arrow_forward),
///     ),
///   ],
/// )
/// ```
class VNLInputTrailingFeature extends VNLInputFeature {
  /// The widget to display on the trailing side.
  final Widget suffix;

  /// Creates an [VNLInputTrailingFeature].
  ///
  /// Parameters:
  /// - [suffix] (`Widget`, required): The widget to show after the input.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputTrailingFeature(
    this.suffix, {
    super.visibility,
    super.skipFocusTraversal,
  });

  @override
  InputFeatureState createState() => _InputTrailingFeatureState();
}

/// Adds a custom widget above or below the text input area.
///
/// Use this feature to place helper content inside the input decoration,
/// directly above or below the editable text.
///
/// Example:
/// ```dart
/// VNLTextField(
///   features: [
///     InputAboveBelowFeature(
///       child: Text('Billing email').small().muted(),
///       position: VNLInputFeaturePosition.above,
///     ),
///   ],
/// )
/// ```
class InputAboveBelowFeature extends VNLInputFeature {
  /// Widget shown above or below the editable text.
  final Widget? child;

  /// Position of the [child] relative to the editable text.
  final VNLInputFeaturePosition position;

  /// Creates an [InputAboveBelowFeature].
  ///
  /// Parameters:
  /// - [child] (`Widget?`, optional): Widget displayed above or below the input text.
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.below`): Placement.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputAboveBelowFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.child,
    this.position = VNLInputFeaturePosition.below,
  });

  /// Creates an [InputAboveBelowFeature] displayed above the input text.
  ///
  /// Parameters:
  /// - [child] (`Widget?`, optional): Widget displayed above the input text.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputAboveBelowFeature.above(
    this.child, {
    super.visibility,
    super.skipFocusTraversal,
  }) : position = VNLInputFeaturePosition.above;

  /// Creates an [InputAboveBelowFeature] displayed below the input text.
  ///
  /// Parameters:
  /// - [child] (`Widget?`, optional): Widget displayed below the input text.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const InputAboveBelowFeature.below(
    this.child, {
    super.visibility,
    super.skipFocusTraversal,
  }) : position = VNLInputFeaturePosition.below;

  @override
  InputFeatureState createState() => _InputAboveBelowFeatureState();
}

class _InputAboveBelowFeatureState
    extends InputFeatureState<InputAboveBelowFeature> {
  @override
  Iterable<Widget> buildAbove() sync* {
    if (feature.position == VNLInputFeaturePosition.above &&
        feature.child != null) {
      yield feature.child!;
    }
  }

  @override
  Iterable<Widget> buildBelow() sync* {
    if (feature.position == VNLInputFeaturePosition.below &&
        feature.child != null) {
      yield feature.child!;
    }
  }
}

class _InputTrailingFeatureState
    extends InputFeatureState<VNLInputTrailingFeature> {
  @override
  Iterable<Widget> buildTrailing() sync* {
    yield feature.suffix;
  }
}

/// Adds a paste button to the input field.
///
/// Provides a button that pastes content from the clipboard into the input.
/// Useful for improving user experience when entering copied data.
///
/// Example:
/// ```dart
/// VNLTextField(
///   features: [
///     VNLInputPasteFeature(
///       position: VNLInputFeaturePosition.trailing,
///     ),
///   ],
/// )
/// ```
class VNLInputPasteFeature extends VNLInputFeature {
  /// Position of the paste button.
  final VNLInputFeaturePosition position;

  /// Custom icon for the paste button.
  final Widget? icon;

  /// Creates an [VNLInputPasteFeature].
  ///
  /// Parameters:
  /// - [position] (`VNLInputFeaturePosition`, default: `VNLInputFeaturePosition.trailing`):
  ///   Where to place the paste button.
  /// - [icon] (`Widget?`, optional): Custom icon widget.
  /// - [visibility] (`VNLInputFeatureVisibility`, optional): Controls visibility.
  /// - [skipFocusTraversal] (`bool`, optional): Whether to skip in focus order.
  const VNLInputPasteFeature({
    super.visibility,
    super.skipFocusTraversal,
    this.position = VNLInputFeaturePosition.trailing,
    this.icon,
  });

  @override
  InputFeatureState createState() => _InputPasteFeatureState();
}

class _InputPasteFeatureState extends InputFeatureState<VNLInputPasteFeature> {
  void _paste() {
    var clipboardData = Clipboard.getData('text/plain');
    clipboardData.then((value) {
      if (value != null) {
        var text = value.text;
        if (text != null && text.isNotEmpty && context.mounted) {
          Actions.invoke(context, VNLTextFieldAppendTextIntent(text: text));
        }
      }
    });
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == VNLInputFeaturePosition.trailing) {
      yield VNLIconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.clipboard),
        onPressed: _paste,
        density: VNLButtonDensity.compact,
      );
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == VNLInputFeaturePosition.leading) {
      yield VNLIconButton.text(
        icon: feature.icon ?? const Icon(LucideIcons.clipboard),
        onPressed: _paste,
        density: VNLButtonDensity.compact,
      );
    }
  }
}
