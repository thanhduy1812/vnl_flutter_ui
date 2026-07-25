import 'dart:math';

import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Converts a [Color] to its hexadecimal string representation.
///
/// This function transforms a Flutter [Color] object into a hex string format
/// commonly used in CSS and design tools. The output can optionally include
/// the alpha (transparency) channel and a hash (#) prefix.
///
/// Parameters:
/// - [color]: The color to convert to hexadecimal format.
/// - [showAlpha]: Whether to include the alpha channel in the output. Defaults to `false`.
///   When `true`, the alpha value is prepended to the RGB values (ARGB format).
/// - [hashPrefix]: Whether to prefix the output with '#'. Defaults to `true`.
///
/// Returns:
/// A hexadecimal string representation of the color. Format varies based on parameters:
/// - With alpha and hash: `#AARRGGBB` (e.g., `#FF0080FF`)
/// - Without alpha, with hash: `#RRGGBB` (e.g., `#0080FF`)
/// - With alpha, no hash: `AARRGGBB`
/// - Without alpha, no hash: `RRGGBB`
///
/// Example:
/// ```dart
/// final color = Color.fromARGB(255, 0, 128, 255);
/// print(colorToHex(color)); // Output: #0080FF
/// print(colorToHex(color, true)); // Output: #FF0080FF
/// print(colorToHex(color, false, false)); // Output: 0080FF
/// ```
String colorToHex(Color color,
    [bool showAlpha = false, bool hashPrefix = true]) {
  String r = ((color.r * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  String g = ((color.g * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  String b = ((color.b * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  if (showAlpha) {
    String a =
        ((color.a * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
    return hashPrefix ? '#$a$r$g$b' : '$a$r$g$b';
  } else {
    return hashPrefix ? '#$r$g$b' : '$r$g$b';
  }
}

/// An abstract base class representing a color that can be transformed between different color spaces.
///
/// [VNLColorDerivative] provides a unified interface for working with colors in various color spaces
/// (HSV, HSL, RGB) while maintaining transformation capabilities. This is particularly useful
/// in color picker implementations where users may want to work with different color models.
///
/// The class supports:
/// - Conversion between HSV, HSL, and RGB color spaces
/// - Individual channel manipulation (hue, saturation, value/lightness, red, green, blue, opacity)
/// - Preserving the internal color representation when transforming
///
/// Example:
/// ```dart
/// // Create from a Flutter Color
/// final derivative = VNLColorDerivative.fromColor(VNLColors.blue);
///
/// // Modify saturation
/// final desaturated = derivative.changeToHSVSaturation(0.5);
///
/// // Convert back to Color
/// final newColor = desaturated.toColor();
/// ```
abstract base class VNLColorDerivative {
  /// Creates a [VNLColorDerivative] from a Flutter [Color] using HSV color space internally.
  static VNLColorDerivative fromColor(Color color) {
    return _HSVColor(HSVColor.fromColor(color));
  }

  /// Creates a [VNLColorDerivative] from an [HSVColor].
  const factory VNLColorDerivative.fromHSV(HSVColor color) = _HSVColor;

  /// Creates a [VNLColorDerivative] from an [HSLColor].
  const factory VNLColorDerivative.fromHSL(HSLColor color) = _HSLColor;

  /// Creates a const [VNLColorDerivative].
  const VNLColorDerivative();

  /// Converts this color derivative to a Flutter [Color].
  Color toColor();

  /// Converts this color derivative to an [HSVColor].
  HSVColor toHSVColor();

  /// Converts this color derivative to an [HSLColor].
  HSLColor toHSLColor();

  /// Gets the opacity (alpha) value of this color, ranging from 0.0 to 1.0.
  double get opacity;

  /// Gets the hue component in HSL color space, ranging from 0.0 to 360.0.
  double get hslHue;

  /// Gets the saturation component in HSL color space, ranging from 0.0 to 1.0.
  double get hslSat;

  /// Gets the lightness component in HSL color space, ranging from 0.0 to 1.0.
  double get hslVal;

  /// Gets the hue component in HSV color space, ranging from 0.0 to 360.0.
  double get hsvHue;

  /// Gets the saturation component in HSV color space, ranging from 0.0 to 1.0.
  double get hsvSat;

  /// Gets the value (brightness) component in HSV color space, ranging from 0.0 to 1.0.
  double get hsvVal;

  /// Gets the red component in RGB color space, ranging from 0 to 255.
  int get red;

  /// Gets the green component in RGB color space, ranging from 0 to 255.
  int get green;

  /// Gets the blue component in RGB color space, ranging from 0 to 255.
  int get blue;

  /// Transforms this color derivative to match the internal representation of [old].
  ///
  /// This method preserves the color space representation (HSV or HSL) used by [old]
  /// while applying the color values from this derivative. This is useful when
  /// maintaining consistency in color space during transformations.
  VNLColorDerivative transform(VNLColorDerivative old);

  /// Changes the opacity (alpha) value of this color.
  ///
  /// Parameters:
  /// - [alpha]: The new opacity value, ranging from 0.0 (fully transparent) to 1.0 (fully opaque).
  ///
  /// Returns: A new [VNLColorDerivative] with the updated opacity.
  VNLColorDerivative changeToOpacity(double alpha);

  /// Changes this color to the specified [color] while preserving the internal color space representation.
  ///
  /// Parameters:
  /// - [color]: The target color to change to.
  ///
  /// Returns: A new [VNLColorDerivative] with the new color value.
  VNLColorDerivative changeToColor(Color color) {
    VNLColorDerivative newColor = VNLColorDerivative.fromColor(color);
    return newColor.transform(this);
  }

  /// Changes this color to the specified [color] in HSV color space.
  ///
  /// Parameters:
  /// - [color]: The target HSV color to change to.
  ///
  /// Returns: A new [VNLColorDerivative] with the new HSV color value.
  VNLColorDerivative changeToHSV(HSVColor color) {
    VNLColorDerivative newColor = VNLColorDerivative.fromHSV(color);
    return newColor.transform(this);
  }

  /// Changes this color to the specified [color] in HSL color space.
  ///
  /// Parameters:
  /// - [color]: The target HSL color to change to.
  ///
  /// Returns: A new [VNLColorDerivative] with the new HSL color value.
  VNLColorDerivative changeToHSL(HSLColor color) {
    VNLColorDerivative newColor = VNLColorDerivative.fromHSL(color);
    return newColor.transform(this);
  }

  /// Changes the red component of this color in RGB color space.
  ///
  /// Parameters:
  /// - [red]: The new red value, ranging from 0.0 to 255.0.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated red component.
  VNLColorDerivative changeToColorRed(double red) {
    return changeToColor(toColor().withRed(red.toInt()));
  }

  /// Changes the green component of this color in RGB color space.
  ///
  /// Parameters:
  /// - [green]: The new green value, ranging from 0.0 to 255.0.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated green component.
  VNLColorDerivative changeToColorGreen(double green) {
    return changeToColor(toColor().withGreen(green.toInt()));
  }

  /// Changes the blue component of this color in RGB color space.
  ///
  /// Parameters:
  /// - [blue]: The new blue value, ranging from 0.0 to 255.0.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated blue component.
  VNLColorDerivative changeToColorBlue(double blue) {
    return changeToColor(toColor().withBlue(blue.toInt()));
  }

  /// Changes the hue component of this color in HSV color space.
  ///
  /// Parameters:
  /// - [hue]: The new hue value, ranging from 0.0 to 360.0 degrees.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated HSV hue.
  VNLColorDerivative changeToHSVHue(double hue) {
    return changeToHSV(toHSVColor().withHue(hue));
  }

  /// Changes the saturation component of this color in HSV color space.
  ///
  /// Parameters:
  /// - [saturation]: The new saturation value, ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated HSV saturation.
  VNLColorDerivative changeToHSVSaturation(double saturation) {
    return changeToHSV(toHSVColor().withSaturation(saturation));
  }

  /// Changes the value (brightness) component of this color in HSV color space.
  ///
  /// Parameters:
  /// - [value]: The new value component, ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated HSV value.
  VNLColorDerivative changeToHSVValue(double value) {
    return changeToHSV(toHSVColor().withValue(value));
  }

  /// Changes the alpha (opacity) component of this color in HSV color space.
  ///
  /// Parameters:
  /// - [alpha]: The new alpha value, ranging from 0.0 (fully transparent) to 1.0 (fully opaque).
  ///
  /// Returns: A new [VNLColorDerivative] with the updated HSV alpha.
  VNLColorDerivative changeToHSVAlpha(double alpha) {
    return changeToHSV(toHSVColor().withAlpha(alpha));
  }

  /// Changes the hue component of this color in HSL color space.
  ///
  /// Parameters:
  /// - [hue]: The new hue value, ranging from 0.0 to 360.0 degrees.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated HSL hue.
  VNLColorDerivative changeToHSLHue(double hue) {
    return changeToHSL(toHSLColor().withHue(hue));
  }

  /// Changes the saturation component of this color in HSL color space.
  ///
  /// Parameters:
  /// - [saturation]: The new saturation value, ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated HSL saturation.
  VNLColorDerivative changeToHSLSaturation(double saturation) {
    return changeToHSL(toHSLColor().withSaturation(saturation));
  }

  /// Changes the lightness component of this color in HSL color space.
  ///
  /// Parameters:
  /// - [lightness]: The new lightness value, ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [VNLColorDerivative] with the updated HSL lightness.
  VNLColorDerivative changeToHSLLightness(double lightness) {
    return changeToHSL(toHSLColor().withLightness(lightness));
  }
}

final class _HSVColor extends VNLColorDerivative {
  final HSVColor color;
  const _HSVColor(this.color);

  @override
  String toString() => color.toString();

  @override
  Color toColor() {
    return color.toColor();
  }

  @override
  HSVColor toHSVColor() {
    return color;
  }

  @override
  HSLColor toHSLColor() {
    return color.toHSL();
  }

  @override
  double get opacity => color.alpha;

  @override
  VNLColorDerivative changeToOpacity(double alpha) {
    return _HSVColor(color.withAlpha(alpha));
  }

  @override
  VNLColorDerivative changeToHSVHue(double hue) {
    return _HSVColor(color.withHue(hue));
  }

  @override
  VNLColorDerivative changeToHSVSaturation(double saturation) {
    return _HSVColor(color.withSaturation(saturation));
  }

  @override
  VNLColorDerivative changeToHSVValue(double value) {
    return _HSVColor(color.withValue(value));
  }

  @override
  VNLColorDerivative transform(VNLColorDerivative old) {
    if (old is _HSVColor) {
      return _HSVColor(color);
    } else if (old is _HSLColor) {
      return _HSLColor(color.toHSL());
    } else {
      throw FlutterError('Invalid color type');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is _HSLColor) {
      return color == other.toHSVColor();
    }

    return other is _HSVColor && other.color == color;
  }

  @override
  int get hashCode => color.hashCode;

  @override
  double get hslHue => color.toHSL().hue;

  @override
  double get hslSat => color.toHSL().saturation;

  @override
  double get hslVal => color.toHSL().lightness;

  @override
  double get hsvHue => color.hue;

  @override
  double get hsvSat => color.saturation;

  @override
  double get hsvVal => color.value;

  @override
  int get red => (color.toColor().r * 255).round() & 0xFF;

  @override
  int get green => (color.toColor().g * 255).round() & 0xFF;

  @override
  int get blue => (color.toColor().b * 255).round() & 0xFF;
}

final class _HSLColor extends VNLColorDerivative {
  final HSLColor color;
  const _HSLColor(this.color);
  @override
  String toString() => color.toString();

  @override
  Color toColor() {
    return color.toColor();
  }

  @override
  HSVColor toHSVColor() {
    return color.toHSV();
  }

  @override
  HSLColor toHSLColor() {
    return color;
  }

  @override
  double get opacity => color.alpha;

  @override
  VNLColorDerivative changeToOpacity(double alpha) {
    return _HSLColor(color.withAlpha(alpha));
  }

  @override
  VNLColorDerivative changeToHSLHue(double hue) {
    return _HSLColor(color.withHue(hue));
  }

  @override
  VNLColorDerivative changeToHSLSaturation(double saturation) {
    return _HSLColor(color.withSaturation(saturation));
  }

  @override
  VNLColorDerivative changeToHSLLightness(double lightness) {
    return _HSLColor(color.withLightness(lightness));
  }

  @override
  VNLColorDerivative changeToHSVHue(double hue) {
    // should be the same as changing HSL hue
    return _HSLColor(color.withHue(hue));
  }

  @override
  VNLColorDerivative transform(VNLColorDerivative old) {
    if (old is _HSVColor) {
      return _HSVColor(color.toHSV());
    } else if (old is _HSLColor) {
      return _HSLColor(color);
    } else {
      throw FlutterError('Invalid color type');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is _HSVColor) {
      return color == other.toHSLColor();
    }

    return other is _HSLColor && other.color == color;
  }

  @override
  int get hashCode => color.hashCode;

  @override
  double get hslHue => color.hue;

  @override
  double get hslSat => color.saturation;

  @override
  double get hslVal => color.lightness;

  @override
  double get hsvHue => color.toHSV().hue;

  @override
  double get hsvSat => color.toHSV().saturation;

  @override
  double get hsvVal => color.toHSV().value;

  @override
  int get red => (color.toColor().r * 255).toInt() & 0xFF;

  @override
  int get green => (color.toColor().g * 255).toInt() & 0xFF;

  @override
  int get blue => (color.toColor().b * 255).toInt() & 0xFF;
}

/// An abstract base class representing a color gradient with multiple color stops.
///
/// [VNLColorGradient] provides a common interface for working with gradients that can
/// have colors added, modified, or removed at specific positions. This is useful
/// for creating custom gradient pickers and editors.
///
/// Implementations should handle the gradient type (linear, radial, sweep, etc.)
/// and provide methods to manipulate color stops and their positions.
abstract class VNLColorGradient {
  /// Creates a const [VNLColorGradient].
  const VNLColorGradient();

  /// Creates a copy of this gradient with optional modifications.
  ///
  /// Returns: A new [VNLColorGradient] instance.
  VNLColorGradient copyWith();

  /// Changes the color at the specified [index].
  ///
  /// Parameters:
  /// - [index]: The zero-based index of the color stop to modify.
  /// - [color]: The new color for the stop.
  ///
  /// Returns: A new [VNLColorGradient] with the updated color.
  VNLColorGradient changeColorAt(int index, VNLColorDerivative color);

  /// Changes the position of the color stop at the specified [index].
  ///
  /// Parameters:
  /// - [index]: The zero-based index of the color stop to modify.
  /// - [position]: The new position for the stop, typically ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [VNLColorGradient] with the updated position.
  VNLColorGradient changePositionAt(int index, double position);

  /// Changes both the color and position at the specified [index].
  ///
  /// Parameters:
  /// - [index]: The zero-based index of the color stop to modify.
  /// - [color]: The new color for the stop.
  /// - [position]: The new position for the stop, typically ranging from 0.0 to 1.0.
  ///
  /// Returns: A new [VNLColorGradient] with both values updated.
  VNLColorGradient changeColorAndPositionAt(
      int index, VNLColorDerivative color, double position);

  /// Inserts a new color stop at a specific position in the gradient.
  ///
  /// Parameters:
  /// - [color]: The color to insert.
  /// - [position]: The offset position where the color should be inserted.
  /// - [size]: The size of the gradient area.
  /// - [textDirection]: The text direction for resolving directional alignments.
  ///
  /// Returns: A record containing the updated gradient and the index where the color was inserted.
  ({VNLColorGradient gradient, int index}) insertColorAt(VNLColorDerivative color,
      Offset position, Size size, TextDirection textDirection);

  /// Converts this color gradient to a Flutter [Gradient].
  ///
  /// Returns: A [Gradient] object that can be used in Flutter painting operations.
  Gradient toGradient();
}

/// Represents a color stop in a gradient with a specific color and position.
///
/// A color stop defines where a particular color appears along a gradient.
/// The position is typically a value between 0.0 (start) and 1.0 (end).
///
/// Example:
/// ```dart
/// const stop = VNLColorStop(
///   color: VNLColorDerivative.fromColor(VNLColors.blue),
///   position: 0.5, // Middle of the gradient
/// );
/// ```
class VNLColorStop {
  /// The color at this stop.
  final VNLColorDerivative color;

  /// The position of this stop along the gradient, typically from 0.0 to 1.0.
  final double position;

  /// Creates a [VNLColorStop] with the specified [color] and [position].
  const VNLColorStop({
    required this.color,
    required this.position,
  });
}

/// An abstract base class for representing gradient angles with alignment geometry.
///
/// [GradientAngleGeometry] provides an interface for converting between angular
/// representation and alignment-based gradients. It supports both directional
/// (text-direction-aware) and non-directional gradient angles.
///
/// Subclasses should implement how to calculate begin and end alignments based
/// on the angle value.
abstract class GradientAngleGeometry {
  /// Creates a const [GradientAngleGeometry].
  const GradientAngleGeometry();

  /// The angle of the gradient in radians.
  double get angle;

  /// The beginning alignment of the gradient.
  AlignmentGeometry get begin;

  /// The ending alignment of the gradient.
  AlignmentGeometry get end;

  /// Converts this to a directional gradient angle.
  ///
  /// Returns: A [DirectionalGradientAngle] based on this angle.
  DirectionalGradientAngle toDirectional() {
    return DirectionalGradientAngle(angle);
  }

  /// Converts this to a non-directional gradient angle.
  ///
  /// Returns: A [VNLGradientAngle] based on this angle.
  VNLGradientAngle toNonDirectional() {
    return VNLGradientAngle(angle);
  }
}

/// A directional gradient angle that is aware of text direction.
///
/// [DirectionalGradientAngle] uses [AlignmentDirectional] for its alignments,
/// making it responsive to the text direction (LTR or RTL). The angle is specified
/// in radians and determines the direction of the gradient.
///
/// Example:
/// ```dart
/// const angle = DirectionalGradientAngle(0.0); // 0 radians (horizontal)
/// final begin = angle.begin; // Start alignment
/// final end = angle.end;     // End alignment
/// ```
class DirectionalGradientAngle extends GradientAngleGeometry {
  @override

  /// The angle of the gradient in radians.
  final double angle;

  /// Creates a [DirectionalGradientAngle] with the specified [angle] in radians.
  const DirectionalGradientAngle(this.angle);

  @override

  /// The beginning alignment calculated from the angle.
  AlignmentGeometry get begin {
    final x = 0.5 + 0.5 * cos(angle);
    final y = 0.5 + 0.5 * sin(angle);
    return AlignmentDirectional(x * 2 - 1, y * 2 - 1);
  }

  @override

  /// The ending alignment calculated from the angle.
  AlignmentGeometry get end {
    final x = 0.5 + 0.5 * cos(angle + pi);
    final y = 0.5 + 0.5 * sin(angle + pi);
    return AlignmentDirectional(x * 2 - 1, y * 2 - 1);
  }
}

/// A non-directional gradient angle that uses standard [Alignment].
///
/// Unlike [DirectionalGradientAngle], this class uses non-directional [Alignment]
/// and is not affected by text direction. The angle is specified in radians.
///
/// Example:
/// ```dart
/// const angle = VNLGradientAngle(pi / 4); // 45 degrees
/// final begin = angle.begin;
/// final end = angle.end;
/// ```
class VNLGradientAngle extends GradientAngleGeometry {
  @override

  /// The angle of the gradient in radians.
  final double angle;

  /// Creates a [VNLGradientAngle] with the specified [angle] in radians.
  const VNLGradientAngle(this.angle);

  @override

  /// The beginning alignment calculated from the angle.
  AlignmentGeometry get begin {
    final x = 0.5 + 0.5 * cos(angle);
    final y = 0.5 + 0.5 * sin(angle);
    return Alignment(x * 2 - 1, y * 2 - 1);
  }

  @override

  /// The ending alignment calculated from the angle.
  AlignmentGeometry get end {
    final x = 0.5 + 0.5 * cos(angle + pi);
    final y = 0.5 + 0.5 * sin(angle + pi);
    return Alignment(x * 2 - 1, y * 2 - 1);
  }
}

/// A linear gradient implementation of [VNLColorGradient].
///
/// [VNLLinearColorGradient] represents a gradient that transitions linearly between
/// colors along a specified angle. It supports multiple color stops and different
/// tile modes for how the gradient repeats beyond its bounds.
///
/// Example:
/// ```dart
/// final gradient = VNLLinearColorGradient(
///   colors: [
///     VNLColorStop(color: VNLColorDerivative.fromColor(VNLColors.red), position: 0.0),
///     VNLColorStop(color: VNLColorDerivative.fromColor(VNLColors.blue), position: 1.0),
///   ],
///   angle: const VNLGradientAngle(0.0),
/// );
/// ```
class VNLLinearColorGradient extends VNLColorGradient {
  /// The list of color stops in the gradient.
  final List<VNLColorStop> colors;

  /// The angle of the gradient.
  final GradientAngleGeometry angle;

  /// How the gradient repeats beyond its bounds.
  final TileMode tileMode;

  /// Creates a [VNLLinearColorGradient] with the specified parameters.
  const VNLLinearColorGradient({
    required this.colors,
    this.angle = const DirectionalGradientAngle(0),
    this.tileMode = TileMode.clamp,
  });

  @override
  VNLLinearColorGradient copyWith({
    List<VNLColorStop>? colors,
    GradientAngleGeometry? angle,
    TileMode? tileMode,
  }) {
    return VNLLinearColorGradient(
      colors: colors ?? this.colors,
      angle: angle ?? this.angle,
      tileMode: tileMode ?? this.tileMode,
    );
  }

  @override
  VNLLinearColorGradient changeColorAt(int index, VNLColorDerivative color) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: color,
      position: newColors[index].position,
    );
    return copyWith(colors: newColors);
  }

  @override
  VNLLinearColorGradient changePositionAt(int index, double position) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: newColors[index].color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  VNLLinearColorGradient changeColorAndPositionAt(
      int index, VNLColorDerivative color, double position) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  ({VNLLinearColorGradient gradient, int index}) insertColorAt(
      VNLColorDerivative color,
      Offset position,
      Size size,
      TextDirection textDirection) {
    Alignment alignBegin = angle.begin.resolve(textDirection);
    Alignment alignEnd = angle.end.resolve(textDirection);
    final dx = alignEnd.x - alignBegin.x;
    final dy = alignEnd.y - alignBegin.y;
    final lengthSquared = dx * dx + dy * dy;
    final px = (position.dx / size.width) * 2 - 1;
    final py = (position.dy / size.height) * 2 - 1;
    final t =
        ((px - alignBegin.x) * dx + (py - alignBegin.y) * dy) / lengthSquared;
    final pos = t.clamp(0.0, 1.0);
    List<VNLColorStop> newColors = List.from(colors);
    int insertIndex = 0;
    for (int i = 0; i < newColors.length; i++) {
      if (newColors[i].position < pos) {
        insertIndex = i + 1;
      }
    }
    newColors.insert(
      insertIndex,
      VNLColorStop(color: color, position: pos),
    );
    return (
      gradient: copyWith(colors: newColors),
      index: insertIndex,
    );
  }

  @override
  LinearGradient toGradient() {
    return LinearGradient(
      colors: colors.map((e) => e.color.toColor()).toList(),
      stops: colors.map((e) => e.position).toList(),
      tileMode: tileMode,
      begin: angle.begin,
      end: angle.end,
    );
  }
}

/// A radial gradient for color values.
///
/// Creates a circular gradient radiating from a center point.
class VNLRadialColorGradient extends VNLColorGradient {
  /// The color stops defining the gradient.
  final List<VNLColorStop> colors;

  /// How the gradient tiles beyond its bounds.
  final TileMode tileMode;

  /// The center point of the gradient.
  final AlignmentGeometry center;

  /// The focal point of the gradient (for elliptical gradients).
  final AlignmentGeometry? focal;

  /// The radius of the gradient (0.0 to 1.0).
  final double radius;

  /// The focal radius for elliptical gradients.
  final double focalRadius;

  /// Creates a radial color gradient.
  const VNLRadialColorGradient({
    required this.colors,
    this.tileMode = TileMode.clamp,
    this.center = Alignment.center,
    this.focal,
    this.radius = 0.5,
    this.focalRadius = 0.0,
  });

  @override
  VNLRadialColorGradient copyWith({
    List<VNLColorStop>? colors,
    TileMode? tileMode,
    AlignmentGeometry? center,
    AlignmentGeometry? focal,
    double? radius,
    double? focalRadius,
  }) {
    return VNLRadialColorGradient(
      colors: colors ?? this.colors,
      tileMode: tileMode ?? this.tileMode,
      center: center ?? this.center,
      focal: focal ?? this.focal,
      radius: radius ?? this.radius,
      focalRadius: focalRadius ?? this.focalRadius,
    );
  }

  @override
  VNLRadialColorGradient changeColorAt(int index, VNLColorDerivative color) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: color,
      position: newColors[index].position,
    );
    return copyWith(colors: newColors);
  }

  @override
  VNLRadialColorGradient changePositionAt(int index, double position) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: newColors[index].color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  VNLRadialColorGradient changeColorAndPositionAt(
      int index, VNLColorDerivative color, double position) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  ({VNLRadialColorGradient gradient, int index}) insertColorAt(
      VNLColorDerivative color,
      Offset position,
      Size size,
      TextDirection textDirection) {
    Alignment alignCenter = center.resolve(textDirection);
    final px = (position.dx / size.width) * 2 - 1;
    final py = (position.dy / size.height) * 2 - 1;
    final dx = px - alignCenter.x;
    final dy = py - alignCenter.y;
    final dist =
        sqrt(dx * dx + dy * dy) / sqrt(2); // max distance in square is sqrt(2)
    final pos = dist.clamp(0.0, 1.0);
    List<VNLColorStop> newColors = List.from(colors);
    int insertIndex = 0;
    for (int i = 0; i < newColors.length; i++) {
      if (newColors[i].position < pos) {
        insertIndex = i + 1;
      }
    }
    newColors.insert(
      insertIndex,
      VNLColorStop(color: color, position: pos),
    );
    return (
      gradient: copyWith(colors: newColors),
      index: insertIndex,
    );
  }

  @override
  RadialGradient toGradient() {
    return RadialGradient(
      colors: colors.map((e) => e.color.toColor()).toList(),
      stops: colors.map((e) => e.position).toList(),
      center: center,
      focal: focal,
      radius: radius,
      focalRadius: focalRadius,
      tileMode: tileMode,
    );
  }
}

/// A sweep (angular/conical) gradient for color values.
///
/// Creates a gradient that sweeps around a center point.
class VNLSweepColorGradient extends VNLColorGradient {
  /// The color stops defining the gradient.
  final List<VNLColorStop> colors;

  /// How the gradient tiles beyond its bounds.
  final TileMode tileMode;

  /// The center point of the gradient.
  final AlignmentGeometry center;

  /// The starting angle in radians.
  final double startAngle;

  /// The ending angle in radians.
  final double endAngle;

  /// Creates a sweep color gradient.
  const VNLSweepColorGradient({
    required this.colors,
    this.tileMode = TileMode.clamp,
    this.center = Alignment.center,
    this.startAngle = 0.0,
    this.endAngle = pi * 2,
  });

  @override
  VNLSweepColorGradient copyWith({
    List<VNLColorStop>? colors,
    TileMode? tileMode,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
  }) {
    return VNLSweepColorGradient(
      colors: colors ?? this.colors,
      tileMode: tileMode ?? this.tileMode,
      center: center ?? this.center,
      startAngle: startAngle ?? this.startAngle,
      endAngle: endAngle ?? this.endAngle,
    );
  }

  @override
  VNLSweepColorGradient changeColorAt(int index, VNLColorDerivative color) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: color,
      position: newColors[index].position,
    );
    return copyWith(colors: newColors);
  }

  @override
  VNLSweepColorGradient changePositionAt(int index, double position) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: newColors[index].color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  VNLSweepColorGradient changeColorAndPositionAt(
      int index, VNLColorDerivative color, double position) {
    List<VNLColorStop> newColors = List.from(colors);
    newColors[index] = VNLColorStop(
      color: color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  ({VNLSweepColorGradient gradient, int index}) insertColorAt(
      VNLColorDerivative color,
      Offset position,
      Size size,
      TextDirection textDirection) {
    Alignment alignCenter = center.resolve(textDirection);
    final px = (position.dx / size.width) * 2 - 1;
    final py = (position.dy / size.height) * 2 - 1;
    final dx = px - alignCenter.x;
    final dy = py - alignCenter.y;
    final angle = atan2(dy, dx);
    double normalizedAngle = angle;
    if (normalizedAngle < startAngle) {
      normalizedAngle += pi * 2;
    }
    final totalAngle = endAngle - startAngle;
    final pos = ((normalizedAngle - startAngle) / totalAngle).clamp(0.0, 1.0);
    List<VNLColorStop> newColors = List.from(colors);
    int insertIndex = 0;
    for (int i = 0; i < newColors.length; i++) {
      if (newColors[i].position < pos) {
        insertIndex = i + 1;
      }
    }
    newColors.insert(
      insertIndex,
      VNLColorStop(color: color, position: pos),
    );
    return (
      gradient: copyWith(colors: newColors),
      index: insertIndex,
    );
  }

  @override
  SweepGradient toGradient() {
    return SweepGradient(
      colors: colors.map((e) => e.color.toColor()).toList(),
      stops: colors.map((e) => e.position).toList(),
      center: center,
      startAngle: startAngle,
      endAngle: endAngle,
      tileMode: tileMode,
    );
  }
}
