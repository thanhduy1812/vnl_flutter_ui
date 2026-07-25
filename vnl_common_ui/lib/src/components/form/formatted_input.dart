import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Theme configuration for [VNLFormattedInput] widget styling.
///
/// Defines visual properties for formatted input components including
/// height and padding. Applied globally through [VNLComponentTheme] or per-instance.
class VNLFormattedInputTheme extends ComponentThemeData {
  /// The height of the formatted input.
  final double? height;

  /// Internal padding for the formatted input.
  final EdgeInsetsGeometry? padding;

  /// Creates a [FormattedInputTheme].
  const VNLFormattedInputTheme({this.height, this.padding});

  /// Creates a copy of this theme with specified properties overridden.
  VNLFormattedInputTheme copyWith({
    ValueGetter<double?>? height,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return VNLFormattedInputTheme(
      height: height == null ? this.height : height(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLFormattedInputTheme &&
        other.height == height &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(height, padding);
}

/// Abstract base class for parts of a formatted input.
///
/// [VNLInputPart] defines the interface for components that make up a formatted
/// input field, such as static text, editable sections, or custom widgets.
/// Each part can be rendered and may optionally hold a value.
///
/// Example parts:
/// - Static text separators (e.g., "/", "-")
/// - Editable numeric fields (e.g., month, day, year)
/// - Custom widget decorations
abstract class VNLInputPart implements VNLFormattedValuePart {
  /// Creates a static text part.
  const factory VNLInputPart.static(String text) = VNLStaticPart;

  /// Creates an editable input part.
  const factory VNLInputPart.editable({
    required int length,
    bool obscureText,
    List<TextInputFormatter> inputFormatters,
    Widget? placeholder,
    required double width,
  }) = VNLEditablePart;

  /// Creates a custom widget part.
  const factory VNLInputPart.widget(Widget widget) = VNLWidgetPart;

  /// Creates an [VNLInputPart].
  const VNLInputPart();

  /// Builds the widget for this part.
  Widget build(BuildContext context, VNLFormattedInputData data);

  /// A unique key identifying this part.
  Object? get partKey;

  /// Whether this part can hold a value.
  bool get canHaveValue => false;

  @override

  /// The current value of this part, or null if it doesn't hold a value.
  String? get value => null;

  @override

  /// Returns this part.
  VNLInputPart get part => this;

  @override

  /// Creates a copy of this part with the specified value.
  VNLFormattedValuePart withValue(String value) {
    return VNLFormattedValuePart(this, value);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLInputPart && other.partKey == partKey;
  }

  @override
  int get hashCode => partKey.hashCode;
}

/// A part that displays a custom widget.
class VNLWidgetPart extends VNLInputPart {
  /// The widget to display.
  final Widget widget;

  /// Creates a [VNLWidgetPart] with the specified widget.
  const VNLWidgetPart(this.widget);

  @override
  Widget build(BuildContext context, VNLFormattedInputData data) {
    return widget;
  }

  @override
  Object? get partKey => widget.key;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLWidgetPart && other.widget == widget;
  }

  @override
  int get hashCode => widget.hashCode;
}

/// A part that displays static, non-editable text.
class VNLStaticPart extends VNLInputPart {
  /// The static text to display.
  final String text;

  /// Creates a [VNLStaticPart] with the specified static text.
  ///
  /// Parameters:
  /// - [text] (`String`, required): The immutable text content to display.
  ///
  /// Example:
  /// ```dart
  /// const VNLStaticPart('/')
  /// ```
  const VNLStaticPart(this.text);

  @override
  Widget build(BuildContext context, VNLFormattedInputData data) {
    return _StaticPartWidget(text: text);
  }

  @override
  String get partKey => text;

  @override
  String toString() {
    return 'VNLStaticPart{text: $text}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLStaticPart && other.text == text;
  }

  @override
  int get hashCode => text.hashCode;
}

class _StaticPartWidget extends StatefulWidget {
  final String text;
  const _StaticPartWidget({required this.text});

  @override
  State<_StaticPartWidget> createState() => _StaticPartWidgetState();
}

class _StaticPartWidgetState extends State<_StaticPartWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text).muted().base().center();
  }
}

/// A part that represents an editable input field section.
///
/// [VNLEditablePart] defines a user-editable portion of a formatted input,
/// such as a date component, time segment, or numeric field. Each editable
/// part can have a fixed length, input formatters, and optional obscuring.
///
/// Example:
/// ```dart
/// VNLEditablePart(
///   length: 2,
///   width: 40.0,
///   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
///   placeholder: Text('MM'),
/// )
/// ```
class VNLEditablePart extends VNLInputPart {
  /// The maximum length of text this part can hold.
  final int length;

  /// Whether to obscure the text (e.g., for passwords).
  final bool obscureText;

  /// Input formatters to apply to this part.
  final List<TextInputFormatter> inputFormatters;

  /// The width of this input part.
  final double width;

  /// Optional placeholder widget to display when empty.
  final Widget? placeholder;

  /// Creates an [VNLEditablePart] with the specified configuration.
  const VNLEditablePart({
    required this.length,
    this.obscureText = false,
    this.inputFormatters = const [],
    this.placeholder,
    required this.width,
  });

  @override
  Object? get partKey => null;

  @override
  bool get canHaveValue => true;

  @override
  Widget build(BuildContext context, VNLFormattedInputData data) {
    return _EditablePartWidget(
      data: data,
      length: length,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      placeholder: placeholder,
      width: width,
    );
  }

  @override
  String toString() {
    return 'VNLEditablePart{length: $length, obscureText: $obscureText, inputFormatters: $inputFormatters, width: $width, placeholder: $placeholder}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLEditablePart &&
        other.length == length &&
        other.obscureText == obscureText &&
        listEquals(other.inputFormatters, inputFormatters) &&
        other.width == width &&
        other.placeholder == placeholder;
  }

  @override
  int get hashCode => Object.hash(
      length, obscureText, Object.hashAll(inputFormatters), width, placeholder);
}

class _EditablePartController extends TextEditingController {
  final int maxLength;
  final bool hasPlaceholder;
  _EditablePartController(
      {required this.maxLength, required this.hasPlaceholder, super.text});

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final theme = Theme.of(context);
    assert(!value.composing.isValid ||
        !withComposing ||
        value.isComposingRangeValid);
    final bool composingRegionOutOfRange =
        !value.isComposingRangeValid || !withComposing;

    if (composingRegionOutOfRange) {
      var text = this.text;
      if (text.isEmpty && hasPlaceholder) {
        return const TextSpan();
      }
      var padding = '_' * max(0, maxLength - text.length);
      return TextSpan(children: [
        TextSpan(
          style: style,
          text: text,
        ),
        TextSpan(
          style: style?.copyWith(color: theme.colorScheme.mutedForeground),
          text: padding,
        ),
      ]);
    }

    final TextStyle composingStyle =
        style?.merge(const TextStyle(decoration: TextDecoration.underline)) ??
            const TextStyle(decoration: TextDecoration.underline);
    var textBefore = value.composing.textBefore(value.text);
    var textInside = value.composing.textInside(value.text);
    var textAfter = value.composing.textAfter(value.text);
    int totalTextLength =
        textBefore.length + textInside.length + textAfter.length;
    if (totalTextLength == 0 && hasPlaceholder) {
      return const TextSpan();
    }
    var padding = '_' * max(0, maxLength - totalTextLength);
    return TextSpan(
      style: style,
      children: <TextSpan>[
        TextSpan(text: textBefore),
        TextSpan(
          style: composingStyle,
          text: textInside,
        ),
        TextSpan(text: textAfter),
        TextSpan(
          style: style?.copyWith(color: theme.colorScheme.mutedForeground),
          text: padding,
        ),
      ],
    );
  }
}

class _EditablePartWidget extends StatefulWidget {
  final VNLFormattedInputData data;
  final int length;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final double width;
  final Widget? placeholder;
  const _EditablePartWidget({
    required this.length,
    required this.data,
    this.obscureText = false,
    this.inputFormatters = const [],
    this.placeholder,
    required this.width,
  });

  @override
  State<_EditablePartWidget> createState() => _EditablePartWidgetState();
}

class _EditablePartWidgetState extends State<_EditablePartWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _EditablePartController(
      maxLength: widget.length,
      hasPlaceholder: widget.placeholder != null,
      text: widget.data.initialValue,
    );
    _controller.addListener(_onTextChanged);
    if (widget.data.controller != null) {
      widget.data.controller!.addListener(_onFormattedInputControllerChange);
    }
  }

  void _onTextChanged() {
    if (_updating) return;
    _updating = true;
    try {
      if (widget.data.controller != null) {
        var value = widget.data.controller!.value;
        var parts = List<VNLFormattedValuePart>.from(value.parts);
        int valueIndex = 0;
        for (int i = 0; i < parts.length; i++) {
          if (parts[i].part.canHaveValue) {
            if (valueIndex == widget.data.partIndex) {
              parts[i] = parts[i].withValue(_controller.text);
              break;
            }
            valueIndex++;
          }
        }
        widget.data.controller!.value = VNLFormattedValue(parts);
      }
    } finally {
      _updating = false;
    }
  }

  bool _updating = false;
  void _onFormattedInputControllerChange() {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      if (widget.data.controller != null) {
        var value = widget.data.controller!.value;
        var part = value.values.elementAt(widget.data.partIndex);
        String newText = part.value ?? '';
        if (_controller.text != newText) {
          _controller.value = _controller.value.replaceText(newText);
        }
      }
    } finally {
      _updating = false;
    }
  }

  @override
  void didUpdateWidget(covariant _EditablePartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      final oldValue = _controller.value;
      _controller = _EditablePartController(
        maxLength: widget.length,
        hasPlaceholder: widget.placeholder != null,
        text: oldValue.text,
      );
    } else if (widget.data.initialValue != oldWidget.data.initialValue) {
      // Update text if initialValue changes externally
      if (_controller.text != widget.data.initialValue) {
        _controller.text = widget.data.initialValue ?? '';
      }
    }
    if (oldWidget.data.controller != widget.data.controller) {
      if (oldWidget.data.controller != null) {
        oldWidget.data.controller!
            .removeListener(_onFormattedInputControllerChange);
      }
      if (widget.data.controller != null) {
        widget.data.controller!.addListener(_onFormattedInputControllerChange);
      }
    }
  }

  @override
  void dispose() {
    if (widget.data.controller != null) {
      widget.data.controller!.removeListener(_onFormattedInputControllerChange);
    }
    super.dispose();
  }

  VNLFormattedInputData get data => widget.data;

  void _onChanged(String value) {
    int length = value.length;
    if (length >= widget.length) {
      _nextFocus();
    }
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == 0) {
          _previousFocus();
          return KeyEventResult.handled;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == 0) {
          _previousFocus();
          return KeyEventResult.handled;
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (_controller.selection.isCollapsed &&
            _controller.selection.baseOffset == _controller.text.length) {
          _nextFocus();
          return KeyEventResult.handled;
        }
      }
    }
    return KeyEventResult.ignored;
  }

  void _nextFocus() {
    int nextIndex = data.partIndex + 1;
    if (nextIndex < data.focusNodes.length) {
      FocusNode nextNode = data.focusNodes[nextIndex];
      nextNode.requestFocus();
    }
  }

  void _previousFocus() {
    int nextIndex = data.partIndex - 1;
    if (nextIndex >= 0) {
      FocusNode nextNode = data.focusNodes[nextIndex];
      nextNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Focus(
      onKeyEvent: _onKeyEvent,
      child: FormEntry(
        key: TextFieldKey(data.partIndex),
        child: SizedBox(
          width: widget.width,
          child: VNLComponentTheme(
            data: const VNLFocusOutlineTheme(
              border: Border.fromBorderSide(BorderSide.none),
            ),
            child: VNLTextField(
              focusNode: data.focusNode,
              controller: _controller,
              maxLength: widget.length,
              onChanged: _onChanged,
              decoration: const BoxDecoration(),
              style: DefaultTextStyle.of(context)
                  .style
                  .merge(theme.typography.mono),
              border: const Border.fromBorderSide(BorderSide.none),
              textAlign: TextAlign.center,
              initialValue: data.initialValue,
              maxLines: 1,
              obscureText: widget.obscureText,
              inputFormatters: widget.inputFormatters,
              placeholder: widget.placeholder,
              padding: EdgeInsets.symmetric(
                horizontal: 6 * theme.scaling,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Represents a part of a formatted value with its associated input part and value.
///
/// A [VNLFormattedValuePart] pairs an [VNLInputPart] definition with an optional
/// string value, used to represent user input or parsed data within a
/// formatted input field.
///
/// Example:
/// ```dart
/// final part = VNLFormattedValuePart(DigitPart(), '5');
/// final updated = part.withValue('7');
/// ```
class VNLFormattedValuePart {
  /// The input part definition that this value belongs to.
  final VNLInputPart part;

  /// The actual string value for this part, or null if not set.
  final String? value;

  /// Creates a [VNLFormattedValuePart].
  ///
  /// Parameters:
  /// - [part] (`VNLInputPart`, required): The input part definition.
  /// - [value] (`String?`, optional): The value for this part.
  const VNLFormattedValuePart(this.part, [this.value]);

  /// Creates a copy of this part with a new value.
  ///
  /// Parameters:
  /// - [value] (`String`, required): The new value to associate with this part.
  ///
  /// Returns: A new [VNLFormattedValuePart] with the updated value.
  ///
  /// Example:
  /// ```dart
  /// final original = VNLFormattedValuePart(DigitPart(), '1');
  /// final updated = original.withValue('2');
  /// ```
  VNLFormattedValuePart withValue(String value) {
    return VNLFormattedValuePart(part, value);
  }

  @override
  String toString() {
    return 'VNLFormattedValuePart{part: $part, value: $value}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLFormattedValuePart &&
        part == other.part &&
        value == other.value;
  }

  @override
  int get hashCode => Object.hash(part, value);
}

/// Represents a complete formatted value composed of multiple parts.
///
/// A [VNLFormattedValue] holds a list of [VNLFormattedValuePart] instances, where
/// each part represents either static text or editable fields. It provides
/// methods to access value parts (excluding static parts) and retrieve
/// individual parts by index.
///
/// Example:
/// ```dart
/// final value = VNLFormattedValue([
///   VNLFormattedValuePart(DigitPart(), '1'),
///   VNLFormattedValuePart(VNLStaticPart('/'), null),
///   VNLFormattedValuePart(DigitPart(), '2'),
/// ]);
/// print(value.values.length); // 2 (only value parts)
/// ```
class VNLFormattedValue {
  /// The list of parts that make up this formatted value.
  final List<VNLFormattedValuePart> parts;

  /// Creates a [VNLFormattedValue].
  ///
  /// Parameters:
  /// - [parts] (`List<VNLFormattedValuePart>`, default: `const []`): The parts
  ///   composing this value.
  const VNLFormattedValue([this.parts = const []]);

  /// Returns an iterable of only the parts that can hold values.
  ///
  /// This excludes static parts like separators or fixed text.
  Iterable<VNLFormattedValuePart> get values =>
      parts.where((part) => part.part.canHaveValue);

  /// Retrieves the value part at the specified index.
  ///
  /// This indexes only the parts that can hold values (excluding static parts).
  ///
  /// Parameters:
  /// - [index] (`int`, required): The zero-based index into value parts.
  ///
  /// Returns: The [VNLFormattedValuePart] at the index, or null if out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final value = VNLFormattedValue([
  ///   VNLFormattedValuePart(DigitPart(), '1'),
  ///   VNLFormattedValuePart(VNLStaticPart('/'), null),
  ///   VNLFormattedValuePart(DigitPart(), '2'),
  /// ]);
  /// print(value[0]?.value); // '1'
  /// print(value[1]?.value); // '2'
  /// ```
  VNLFormattedValuePart? operator [](int index) {
    int partIndex = 0;
    for (var part in parts) {
      if (part.part.canHaveValue) {
        if (partIndex == index) {
          return part;
        }
        partIndex++;
      }
    }
    return null;
  }

  @override
  String toString() => parts.join();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLFormattedValue && listEquals(parts, other.parts);
  }

  @override
  int get hashCode => parts.hashCode;
}

/// A controller for managing [VNLFormattedInput] values programmatically.
///
/// This controller extends `ValueNotifier<VNLFormattedValue>` to provide reactive
/// state management for formatted input components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to formatted input changes.
///
/// Example:
/// ```dart
/// final controller = VNLFormattedInputController(
///   VNLFormattedValue([
///     VNLFormattedValuePart.static('('),
///     VNLFormattedValuePart.editable('', length: 3),
///     VNLFormattedValuePart.static(') '),
///     VNLFormattedValuePart.editable('', length: 3),
///     VNLFormattedValuePart.static('-'),
///     VNLFormattedValuePart.editable('', length: 4),
///   ])
/// );
/// ```
class VNLFormattedInputController extends ValueNotifier<VNLFormattedValue>
    with ComponentController<VNLFormattedValue> {
  /// Creates a [VNLFormattedInputController] with an optional initial value.
  ///
  /// Parameters:
  /// - [value] (VNLFormattedValue, default: empty): Initial formatted value
  VNLFormattedInputController([super.value = const VNLFormattedValue()]);
}

/// A controlled input widget for structured data entry with formatting.
///
/// This widget provides a sophisticated input system that combines static text
/// elements with editable fields in a single input interface. It's ideal for
/// formatted inputs like phone numbers, credit cards, dates, or any structured
/// data that requires specific formatting patterns.
///
/// The VNLFormattedInput manages multiple editable segments, each with their own
/// validation, formatting, and input restrictions. It automatically handles
/// focus management between segments and provides a seamless user experience
/// with proper keyboard navigation.
///
/// Example:
/// ```dart
/// VNLFormattedInput(
///   style: TextStyle(fontFamily: 'monospace'),
///   leading: Icon(Icons.phone),
///   initialValue: VNLFormattedValue([
///     VNLFormattedValuePart.static('('),
///     VNLFormattedValuePart.editable('555', length: 3),
///     VNLFormattedValuePart.static(') '),
///     VNLFormattedValuePart.editable('123', length: 3),
///     VNLFormattedValuePart.static('-'),
///     VNLFormattedValuePart.editable('4567', length: 4),
///   ]),
/// );
/// ```
class VNLFormattedInput extends StatefulWidget
    with ControlledComponent<VNLFormattedValue> {
  @override
  final VNLFormattedValue? initialValue;
  @override
  final ValueChanged<VNLFormattedValue>? onChanged;
  @override
  final bool enabled;
  @override
  final VNLFormattedInputController? controller;

  /// Text style applied to all input segments.
  ///
  /// This style affects both static text and editable input fields within
  /// the formatted input. Using a monospace font family is recommended
  /// for consistent character spacing across segments.
  final TextStyle? style;

  /// Widget displayed at the beginning of the input.
  ///
  /// Commonly used for icons or labels that provide context for the input
  /// content, such as a phone icon for phone number inputs.
  final Widget? leading;

  /// Widget displayed at the end of the input.
  ///
  /// Can be used for action buttons, status indicators, or additional
  /// context related to the input content.
  final Widget? trailing;

  /// Creates a [VNLFormattedInput].
  ///
  /// The input structure is defined by the [initialValue] or [controller]
  /// value, which contains the mix of static text and editable segments.
  /// Each editable segment can have its own length restrictions and formatting.
  ///
  /// Parameters:
  /// - [initialValue] (VNLFormattedValue?, optional): Initial structure and values
  /// - [onChanged] (`ValueChanged<VNLFormattedValue>?`, optional): Callback for value changes
  /// - [style] (TextStyle?, optional): Text styling for all segments
  /// - [leading] (Widget?, optional): Widget displayed before the input
  /// - [trailing] (Widget?, optional): Widget displayed after the input
  /// - [enabled] (bool, default: true): Whether the input accepts user interaction
  /// - [controller] (VNLFormattedInputController?, optional): External controller for programmatic control
  ///
  /// Example:
  /// ```dart
  /// VNLFormattedInput(
  ///   initialValue: VNLFormattedValue([
  ///     VNLFormattedValuePart.static('$'),
  ///     VNLFormattedValuePart.editable('0.00', length: 8),
  ///   ]),
  ///   leading: Icon(Icons.attach_money),
  ///   style: TextStyle(fontSize: 16),
  /// );
  /// ```
  const VNLFormattedInput({
    super.key,
    this.initialValue,
    this.onChanged,
    this.style,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.controller,
  });

  @override
  State<VNLFormattedInput> createState() => _FormattedInputState();
}

class _FormattedInputState extends State<VNLFormattedInput> {
  final VNLFormController _controller = VNLFormController();
  bool _hasFocus = false;
  VNLFormattedValue? _value;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue ?? widget.controller?.value;
    _controller.addListener(_notifyChanged);
    int partIndex = 0;
    if (_value != null) {
      for (var part in _value!.parts) {
        if (part.part.canHaveValue) {
          partIndex++;
        }
      }
    }
    _focusNodes = _allocateFocusNodes(partIndex);
  }

  List<FocusNode> _allocateFocusNodes(int newLength,
      [List<FocusNode>? oldNodes]) {
    if (oldNodes == null) {
      return List.generate(newLength, (index) => FocusNode());
    }
    if (newLength == oldNodes.length) {
      return oldNodes;
    }
    if (newLength < oldNodes.length) {
      for (var i = newLength; i < oldNodes.length; i++) {
        oldNodes[i].dispose();
      }
      return oldNodes.sublist(0, newLength);
    }
    return [
      ...oldNodes,
      ...List.generate(newLength - oldNodes.length, (index) => FocusNode()),
    ];
  }

  Widget _buildPart(int index, VNLInputPart part) {
    var formattedInputData = VNLFormattedInputData(
      partIndex: index,
      initialValue: index < 0 ? null : (_value?[index]?.value ?? ''),
      enabled: widget.enabled,
      controller: widget.controller,
      focusNode: index < 0 ? null : _focusNodes[index],
      focusNodes: _focusNodes,
    );
    return part.build(context, formattedInputData);
  }

  bool _updating = false;
  void _notifyChanged() {
    if (_updating) {
      return;
    }
    _updating = true;
    try {
      List<VNLFormattedValuePart> parts = [];
      var values = _controller.values;
      var value = _value;
      if (value != null) {
        int partIndex = 0;
        for (var i = 0; i < value.parts.length; i++) {
          var part = value.parts[i];
          if (part.part.canHaveValue) {
            FormKey key = FormKey(partIndex);
            var val = values[key];
            parts.add(part.withValue(val as String? ?? ''));
            partIndex++;
          } else {
            parts.add(part);
          }
        }
        _focusNodes = _allocateFocusNodes(partIndex, _focusNodes);
      } else {
        _focusNodes = _allocateFocusNodes(0, _focusNodes);
      }
      var newValue = VNLFormattedValue(parts);
      if (widget.onChanged != null && newValue != _value) {
        widget.onChanged!(newValue);
      }
    } finally {
      _updating = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> children = [];
    if (_value != null) {
      int partIndex = 0;
      for (var part in _value!.parts) {
        if (part.part.canHaveValue) {
          children.add(_buildPart(partIndex, part.part));
          partIndex++;
        } else {
          children.add(_buildPart(-1, part.part));
        }
      }
    }
    final compTheme = VNLComponentTheme.maybeOf<VNLFormattedInputTheme>(context);
    return SizedBox(
      height: (compTheme?.height ?? kTextFieldHeight) * theme.scaling, // 32 + 2
      child: TextFieldTapRegion(
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _hasFocus = hasFocus;
            });
          },
          child: VNLFocusOutline(
            focused: _hasFocus,
            borderRadius: theme.borderRadiusMd,
            child: VNLOutlinedContainer(
              borderRadius: theme.borderRadiusMd,
              borderColor: theme.colorScheme.border,
              backgroundColor: theme.colorScheme.input.scaleAlpha(0.3),
              padding: compTheme?.padding ??
                  EdgeInsets.symmetric(
                    horizontal: 6 * theme.scaling,
                  ),
              child: VNLForm(
                controller: _controller,
                child: FocusTraversalGroup(
                  policy: WidgetOrderTraversalPolicy(),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.leading != null) widget.leading!,
                        ...children,
                        if (widget.trailing != null) widget.trailing!,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Internal data structure for formatted input parts.
///
/// [VNLFormattedInputData] holds the state and configuration data needed
/// to render and manage an individual input part within a formatted input.
class VNLFormattedInputData {
  /// The index of this part in the formatted input.
  final int partIndex;

  /// The initial value for this part.
  final String? initialValue;

  /// Whether this part is enabled for editing.
  final bool enabled;

  /// The controller managing the overall formatted input.
  final VNLFormattedInputController? controller;

  /// The focus node for this specific part.
  final FocusNode? focusNode;

  /// All focus nodes in the formatted input.
  final List<FocusNode> focusNodes;

  /// Creates a [VNLFormattedInputData].
  VNLFormattedInputData({
    required this.partIndex,
    required this.initialValue,
    required this.enabled,
    required this.controller,
    required this.focusNode,
    required this.focusNodes,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLFormattedInputData &&
        partIndex == other.partIndex &&
        initialValue == other.initialValue &&
        enabled == other.enabled &&
        controller == other.controller &&
        focusNode == other.focusNode &&
        focusNodes == other.focusNodes;
  }

  @override
  int get hashCode => Object.hash(
      partIndex, initialValue, enabled, controller, focusNode, focusNodes);
}

/// A function type for building custom popup content for formatted object inputs.
///
/// Parameters:
/// - [context]: The build context.
/// - [controller]: The controller managing the input value.
///
/// Returns: A widget to display in the popup.
typedef FormattedInputPopupBuilder<T> = Widget Function(
    BuildContext context, ComponentController<T?> controller);

/// A formatted input widget that works with complex objects.
///
/// [FormattedObjectInput] extends formatted input functionality to handle
/// objects of type [T], converting between the object and its formatted
/// string representation. It can optionally display a popup for advanced editing.
///
/// Example:
/// ```dart
/// FormattedObjectInput<DateTime>(
///   converter: dateConverter,
///   parts: [
///     VNLInputPart.editable(length: 2, width: 30), // Month
///     VNLInputPart.static('/'),
///     VNLInputPart.editable(length: 2, width: 30), // Day
///   ],
///   popupBuilder: (context, controller) => CalendarWidget(),
/// )
/// ```
class FormattedObjectInput<T> extends StatefulWidget
    with ControlledComponent<T?> {
  @override

  /// The initial value of the input.
  final T? initialValue;

  @override

  /// Called when the value changes.
  final ValueChanged<T?>? onChanged;

  /// Called when the individual parts change.
  final ValueChanged<List<String>>? onPartsChanged;

  /// Builder for creating a custom popup widget.
  final FormattedInputPopupBuilder<T>? popupBuilder;

  @override

  /// Whether the input is enabled.
  final bool enabled;

  @override

  /// Optional controller for external control.
  final ComponentController<T?>? controller;

  /// Converter between the object type and string parts.
  final BiDirectionalConvert<T?, List<String?>> converter;

  /// The input parts that make up the formatted input.
  final List<VNLInputPart> parts;

  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Offset for the popover position.
  final Offset? popoverOffset;

  /// Icon displayed in the popover trigger.
  final Widget? popoverIcon;

  /// Creates a [FormattedObjectInput].
  const FormattedObjectInput({
    super.key,
    this.initialValue,
    this.onChanged,
    this.popupBuilder,
    this.enabled = true,
    this.controller,
    required this.converter,
    required this.parts,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverOffset,
    this.popoverIcon,
    this.onPartsChanged,
  });

  @override
  State<FormattedObjectInput<T>> createState() =>
      _FormattedObjectInputState<T>();
}

class _FormattedObjectController<T> extends ValueNotifier<T?>
    with ComponentController<T?> {
  _FormattedObjectController([super.value]);
}

class _FormattedObjectInputState<T> extends State<FormattedObjectInput<T>> {
  late VNLFormattedInputController _formattedController;
  late ComponentController<T?> _controller;

  final _popoverController = VNLPopoverController();

  bool _updating = false; // to prevent circular updates

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? _FormattedObjectController<T>();
    List<String?> values = widget.converter
        .convertA(widget.initialValue ?? widget.controller?.value);
    List<VNLFormattedValuePart> valueParts = [];
    int partIndex = 0;
    for (var i = 0; i < widget.parts.length; i++) {
      var part = widget.parts[i];
      if (part.canHaveValue) {
        var value = values[partIndex];
        if (value != null) {
          valueParts.add(part.withValue(value));
        } else {
          valueParts.add(VNLFormattedValuePart(part));
        }
        partIndex++;
      } else {
        valueParts.add(VNLFormattedValuePart(part));
      }
    }
    _formattedController = VNLFormattedInputController(
      VNLFormattedValue(valueParts),
    );
    _formattedController.addListener(_onFormattedControllerUpdate);
    _controller.addListener(_onControllerUpdate);
  }

  @override
  void didUpdateWidget(covariant FormattedObjectInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.parts, oldWidget.parts)) {
      List<String?> values = widget.converter.convertA(_controller.value);
      List<VNLFormattedValuePart> valueParts = [];
      List<VNLFormattedValuePart> oldValues =
          _formattedController.value.values.toList();
      int partIndex = 0;
      for (var i = 0; i < widget.parts.length; i++) {
        var part = widget.parts[i];
        if (part.canHaveValue) {
          var value = values[partIndex];
          if (value != null) {
            valueParts.add(part.withValue(value));
          } else {
            var oldValue =
                partIndex < oldValues.length ? oldValues[partIndex] : null;
            if (oldValue != null) {
              valueParts.add(oldValue);
            } else {
              valueParts.add(VNLFormattedValuePart(part));
            }
          }
          partIndex++;
        } else {
          valueParts.add(VNLFormattedValuePart(part));
        }
      }
      _updating = true;
      try {
        _formattedController.value = VNLFormattedValue(valueParts);
      } finally {
        _updating = false;
      }
    }
  }

  void _onFormattedControllerUpdate() {
    if (_updating) return;
    _updating = true;
    try {
      var value = _formattedController.value;
      T? newValue = widget.converter.convertB(value.values.map((part) {
        return part.value ?? '';
      }).toList());
      _controller.value = newValue;
      widget.onChanged?.call(newValue);
    } finally {
      _updating = false;
    }
  }

  void _onControllerUpdate() {
    if (_updating) return;
    _updating = true;
    try {
      List<String?> values = widget.converter.convertA(_controller.value);
      List<VNLFormattedValuePart> valueParts = [];
      int partIndex = 0;
      List<VNLFormattedValuePart> oldValues =
          _formattedController.value.values.toList();
      for (var i = 0; i < widget.parts.length; i++) {
        var part = widget.parts[i];
        if (part.canHaveValue) {
          var value = values[partIndex];
          if (value != null) {
            valueParts.add(part.withValue(value));
          } else {
            var oldValue =
                partIndex < oldValues.length ? oldValues[partIndex] : null;
            if (oldValue != null) {
              valueParts.add(oldValue);
            } else {
              valueParts.add(VNLFormattedValuePart(part));
            }
          }
          partIndex++;
        } else {
          valueParts.add(VNLFormattedValuePart(part));
        }
      }
      _formattedController.value = VNLFormattedValue(valueParts);
      widget.onChanged?.call(_controller.value);
    } finally {
      _updating = false;
    }
  }

  void _openPopover() {
    var popupBuilder = widget.popupBuilder;
    if (popupBuilder == null) {
      return;
    }
    final theme = Theme.of(context);
    _popoverController.show(
        context: context,
        alignment: widget.popoverAlignment ?? AlignmentDirectional.topStart,
        anchorAlignment:
            widget.popoverAnchorAlignment ?? AlignmentDirectional.bottomStart,
        offset: widget.popoverOffset ?? (const Offset(0, 4) * theme.scaling),
        builder: (context) {
          return popupBuilder(context, _controller);
        });
  }

  @override
  void dispose() {
    _formattedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var popoverIcon = widget.popoverIcon;
    return VNLFormattedInput(
        controller: _formattedController,
        onChanged: (value) {
          List<String> values = value.values.map((part) {
            return part.value ?? '';
          }).toList();
          widget.onPartsChanged?.call(values);
          T? newValue = widget.converter.convertB(values);
          _controller.value = newValue;
        },
        trailing: popoverIcon == null
            ? null
            : ListenableBuilder(
                listenable: _popoverController,
                builder: (context, child) {
                  return VNLWidgetStatesProvider(
                    states: {
                      if (_popoverController.hasOpenPopover)
                        WidgetState.hovered,
                    },
                    child: child!,
                  );
                },
                child: VNLIconButton.text(
                  icon: popoverIcon,
                  density: VNLButtonDensity.compact,
                  onPressed: _openPopover,
                )));
  }
}
