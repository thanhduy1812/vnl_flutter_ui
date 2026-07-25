import 'package:vnl_common_ui/vnl_ui.dart';

/// Theme data for customizing badge widget appearance across different styles.
///
/// This class defines the visual properties that can be applied to various
/// badge types including [VNLPrimaryBadge], [VNLSecondaryBadge], [VNLOutlineBadge],
/// and [VNLDestructiveBadge]. Each badge style can have its own button styling
/// configuration to provide consistent appearance across the application.
class VNLBadgeTheme extends ComponentThemeData {
  /// Style for [VNLPrimaryBadge].
  final VNLAbstractButtonStyle? primaryStyle;

  /// Style for [VNLSecondaryBadge].
  final VNLAbstractButtonStyle? secondaryStyle;

  /// Style for [VNLOutlineBadge].
  final VNLAbstractButtonStyle? outlineStyle;

  /// Style for [VNLDestructiveBadge].
  final VNLAbstractButtonStyle? destructiveStyle;

  /// Creates a [VNLBadgeTheme].
  const VNLBadgeTheme({
    this.primaryStyle,
    this.secondaryStyle,
    this.outlineStyle,
    this.destructiveStyle,
  });

  /// Returns a copy of this theme with the given fields replaced.
  VNLBadgeTheme copyWith({
    ValueGetter<VNLAbstractButtonStyle?>? primaryStyle,
    ValueGetter<VNLAbstractButtonStyle?>? secondaryStyle,
    ValueGetter<VNLAbstractButtonStyle?>? outlineStyle,
    ValueGetter<VNLAbstractButtonStyle?>? destructiveStyle,
  }) {
    return VNLBadgeTheme(
      primaryStyle: primaryStyle == null ? this.primaryStyle : primaryStyle(),
      secondaryStyle:
          secondaryStyle == null ? this.secondaryStyle : secondaryStyle(),
      outlineStyle: outlineStyle == null ? this.outlineStyle : outlineStyle(),
      destructiveStyle:
          destructiveStyle == null ? this.destructiveStyle : destructiveStyle(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLBadgeTheme &&
        other.primaryStyle == primaryStyle &&
        other.secondaryStyle == secondaryStyle &&
        other.outlineStyle == outlineStyle &&
        other.destructiveStyle == destructiveStyle;
  }

  @override
  int get hashCode =>
      Object.hash(primaryStyle, secondaryStyle, outlineStyle, destructiveStyle);
}

/// A primary style badge widget for highlighting important information or status.
///
/// [VNLPrimaryBadge] displays content in a prominent badge format using the primary
/// color scheme. It's designed for high-importance status indicators, labels,
/// and interactive elements that need to draw attention. The badge supports
/// leading and trailing widgets for icons or additional content.
///
/// Key features:
/// - Primary color styling with emphasis and contrast
/// - Optional tap handling for interactive badges
/// - Support for leading and trailing widgets (icons, counters, etc.)
/// - Customizable button styling through theme integration
/// - Compact size optimized for badge display
/// - Consistent visual hierarchy with other badge variants
///
/// The badge uses button-like styling but in a compact form factor suitable
/// for status displays, labels, and small interactive elements. It integrates
/// with the theme system to maintain visual consistency.
///
/// Common use cases:
/// - Status indicators (active, new, featured)
/// - Notification counts and alerts
/// - Category labels and tags
/// - Interactive filter chips
/// - Achievement or ranking displays
///
/// Example:
/// ```dart
/// VNLPrimaryBadge(
///   child: Text('NEW'),
///   leading: Icon(Icons.star, size: 16),
///   onPressed: () => _showNewItems(),
/// );
///
/// // Non-interactive status badge
/// VNLPrimaryBadge(
///   child: Text('5'),
///   trailing: Icon(Icons.notifications, size: 14),
/// );
/// ```
class VNLPrimaryBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed, making it interactive.
  ///
  /// If `null`, the badge is non-interactive.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  ///
  /// If `null`, uses theme's primary badge style or default primary styling.
  final VNLAbstractButtonStyle? style;

  /// Creates a primary badge.
  const VNLPrimaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = VNLComponentTheme.maybeOf<VNLBadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.primaryStyle ??
        const VNLButtonStyle.primary(
          size: VNLButtonSize.small,
          density: VNLButtonDensity.dense,
          shape: VNLButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: VNLButton(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

/// A secondary-styled badge for displaying labels, counts, or status indicators.
///
/// Similar to [VNLPrimaryBadge] but with secondary (muted) styling suitable for
/// less prominent information.
class VNLSecondaryBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  final VNLAbstractButtonStyle? style;

  /// Creates a secondary badge with the specified child content.
  const VNLSecondaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = VNLComponentTheme.maybeOf<VNLBadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.secondaryStyle ??
        const VNLButtonStyle.secondary(
          size: VNLButtonSize.small,
          density: VNLButtonDensity.dense,
          shape: VNLButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: VNLButton(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

/// An outline-styled badge for displaying labels, counts, or status indicators.
///
/// Uses outline styling with a visible border and no background fill,
/// suitable for less visually prominent badge elements.
class VNLOutlineBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  final VNLAbstractButtonStyle? style;

  /// Creates an outline badge with the specified child content.
  const VNLOutlineBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = VNLComponentTheme.maybeOf<VNLBadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.outlineStyle ??
        const VNLButtonStyle.outline(
          size: VNLButtonSize.small,
          density: VNLButtonDensity.dense,
          shape: VNLButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: VNLButton(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

/// A destructive-styled badge for displaying warnings or dangerous actions.
///
/// Uses destructive (typically red) styling to indicate dangerous, destructive,
/// or critical information that requires user attention.
class VNLDestructiveBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  final VNLAbstractButtonStyle? style;

  /// Creates a destructive badge with the specified child content.
  const VNLDestructiveBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = VNLComponentTheme.maybeOf<VNLBadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.destructiveStyle ??
        const VNLButtonStyle.destructive(
          size: VNLButtonSize.small,
          density: VNLButtonDensity.dense,
          shape: VNLButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: VNLButton(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}
