import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Theme data for customizing [VNLNavigationBar] widget appearance.
///
/// This class defines the visual and behavioral properties that can be applied to
/// [VNLNavigationBar] widgets, including background colors, alignment, spacing,
/// label presentation, and padding. These properties can be set at the theme level
/// to provide consistent styling across the application.
class VNLNavigationBarTheme extends ComponentThemeData {
  /// Background color of the navigation bar.
  final Color? backgroundColor;

  /// Alignment of navigation items.
  final VNLNavigationBarAlignment? alignment;

  /// Layout direction (horizontal or vertical).
  final Axis? direction;

  /// Spacing between navigation items.
  final double? spacing;

  /// Type of label display (e.g., always show, hide, etc.).
  final VNLNavigationLabelType? labelType;

  /// Position of labels relative to icons.
  final VNLNavigationLabelPosition? labelPosition;

  /// Size variant for labels.
  final VNLNavigationLabelSize? labelSize;

  /// Internal padding of the navigation bar.
  final EdgeInsetsGeometry? padding;

  /// Creates a [VNLNavigationBarTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Background color.
  /// - [alignment] (`VNLNavigationBarAlignment?`, optional): Item alignment.
  /// - [direction] (`Axis?`, optional): Layout direction.
  /// - [spacing] (`double?`, optional): Item spacing.
  /// - [labelType] (`VNLNavigationLabelType?`, optional): VNLLabel display type.
  /// - [labelPosition] (`VNLNavigationLabelPosition?`, optional): VNLLabel position.
  /// - [labelSize] (`VNLNavigationLabelSize?`, optional): VNLLabel size.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Internal padding.
  const VNLNavigationBarTheme({
    this.backgroundColor,
    this.alignment,
    this.direction,
    this.spacing,
    this.labelType,
    this.labelPosition,
    this.labelSize,
    this.padding,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [backgroundColor] (`ValueGetter<Color?>?`, optional): New background color.
  /// - [alignment] (`ValueGetter<VNLNavigationBarAlignment?>?`, optional): New alignment.
  /// - [direction] (`ValueGetter<Axis?>?`, optional): New direction.
  /// - [spacing] (`ValueGetter<double?>?`, optional): New spacing.
  /// - [labelType] (`ValueGetter<VNLNavigationLabelType?>?`, optional): New label type.
  /// - [labelPosition] (`ValueGetter<VNLNavigationLabelPosition?>?`, optional): New label position.
  /// - [labelSize] (`ValueGetter<VNLNavigationLabelSize?>?`, optional): New label size.
  /// - [padding] (`ValueGetter<EdgeInsetsGeometry?>?`, optional): New padding.
  ///
  /// Returns: A new [VNLNavigationBarTheme] with updated properties.
  VNLNavigationBarTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<VNLNavigationBarAlignment?>? alignment,
    ValueGetter<Axis?>? direction,
    ValueGetter<double?>? spacing,
    ValueGetter<VNLNavigationLabelType?>? labelType,
    ValueGetter<VNLNavigationLabelPosition?>? labelPosition,
    ValueGetter<VNLNavigationLabelSize?>? labelSize,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return VNLNavigationBarTheme(
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      alignment: alignment == null ? this.alignment : alignment(),
      direction: direction == null ? this.direction : direction(),
      spacing: spacing == null ? this.spacing : spacing(),
      labelType: labelType == null ? this.labelType : labelType(),
      labelPosition:
          labelPosition == null ? this.labelPosition : labelPosition(),
      labelSize: labelSize == null ? this.labelSize : labelSize(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is VNLNavigationBarTheme &&
        other.backgroundColor == backgroundColor &&
        other.alignment == alignment &&
        other.direction == direction &&
        other.spacing == spacing &&
        other.labelType == labelType &&
        other.labelPosition == labelPosition &&
        other.labelSize == labelSize &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(
        backgroundColor,
        alignment,
        direction,
        spacing,
        labelType,
        labelPosition,
        labelSize,
        padding,
      );
}
