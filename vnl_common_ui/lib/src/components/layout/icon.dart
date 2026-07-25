import 'package:vnl_common_ui/shadcn_flutter.dart';
/// Provides themed icon container widgets for shadcn_flutter components.
///
/// Includes [VNLIconContainerTheme] and [VNLIconContainer] for styling icons with background, padding, and border radius.

class VNLIconContainerTheme extends ComponentThemeData {
  /// Background color for the icon container.
  final Color? backgroundColor;
  /// Color for the icon inside the container.
  final Color? iconColor;
  /// Padding inside the icon container.
  final EdgeInsetsGeometry? padding;
  /// Border radius for the icon container.
  final BorderRadius? borderRadius;

  /// Creates an [VNLIconContainerTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  /// Creates an [VNLIconContainerTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  const VNLIconContainerTheme({
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  VNLIconContainerTheme copyWith({
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? iconColor,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<BorderRadius?>? borderRadius,
  }) {
    return VNLIconContainerTheme(
      backgroundColor:
          backgroundColor != null ? backgroundColor() : this.backgroundColor,
      iconColor: iconColor != null ? iconColor() : this.iconColor,
      padding: padding != null ? padding() : this.padding,
      borderRadius: borderRadius != null ? borderRadius() : this.borderRadius,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLIconContainerTheme &&
        other.backgroundColor == backgroundColor &&
        other.iconColor == iconColor &&
        other.padding == padding &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode {
    return Object.hash(
      backgroundColor,
      iconColor,
      padding,
      borderRadius,
    );
  }
}

/// A container widget for displaying an icon with customizable padding, background, and border radius.
///
/// Use [VNLIconContainer] to wrap an icon and apply theme or custom styling.
///
/// Example:
/// ```dart
/// VNLIconContainer(
///   icon: Icon(Icons.star),
///   backgroundColor: VNLColors.yellow,
///   borderRadius: BorderRadius.circular(8),
/// )
/// ```
class VNLIconContainer extends StatelessWidget {
  /// The icon widget to display.
  final Widget icon;
  /// Padding inside the container.
  final EdgeInsetsGeometry? padding;
  /// Border radius for the container.
  final BorderRadius? borderRadius;
  /// Background color for the container.
  final Color? backgroundColor;
  /// Color for the icon.
  final Color? iconColor;
  /// Creates an [VNLIconContainer].
  ///
  /// Parameters:
  /// - [icon] (`Widget`, required): Icon widget to display.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Container padding.
  /// - [borderRadius] (`BorderRadius?`, optional): Container border radius.
  /// - [backgroundColor] (`Color?`, optional): Container background color.
  /// - [iconColor] (`Color?`, optional): Icon color.
  const VNLIconContainer({
    super.key,
    required this.icon,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = VNLComponentTheme.maybeOf<VNLIconContainerTheme>(context);
    return Container(
      padding: styleValue(
          defaultValue: EdgeInsetsDensity.all(padXs)
              .resolveDensity(theme.density.baseContainerPadding),
          widgetValue: padding,
          themeValue: compTheme?.padding),
      decoration: BoxDecoration(
        color: styleValue(
            defaultValue: theme.colorScheme.primary,
            widgetValue: backgroundColor,
            themeValue: compTheme?.backgroundColor),
        borderRadius: styleValue(
            defaultValue: theme.borderRadiusMd,
            widgetValue: borderRadius,
            themeValue: compTheme?.borderRadius),
      ),
      child: IconTheme(
        data: IconThemeData(
          color: styleValue(
              defaultValue: theme.colorScheme.primaryForeground,
              widgetValue: iconColor,
              themeValue: compTheme?.iconColor),
        ),
        child: icon,
      ),
    );
  }
}
