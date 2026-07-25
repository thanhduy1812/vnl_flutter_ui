import '../../../vnl_ui.dart';

/// Theme configuration for [VNLMediaQueryVisibility].
class VNLMediaQueryVisibilityTheme extends ComponentThemeData {
  /// Minimum width at which the child is shown.
  final double? minWidth;

  /// Maximum width at which the child is shown.
  final double? maxWidth;

  /// Creates a [MediaQueryVisibilityTheme].
  const VNLMediaQueryVisibilityTheme({this.minWidth, this.maxWidth});

  /// Creates a copy of this theme but with the given fields replaced.
  VNLMediaQueryVisibilityTheme copyWith({
    ValueGetter<double?>? minWidth,
    ValueGetter<double?>? maxWidth,
  }) {
    return VNLMediaQueryVisibilityTheme(
      minWidth: minWidth == null ? this.minWidth : minWidth(),
      maxWidth: maxWidth == null ? this.maxWidth : maxWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLMediaQueryVisibilityTheme &&
        other.minWidth == minWidth &&
        other.maxWidth == maxWidth;
  }

  @override
  int get hashCode => Object.hash(minWidth, maxWidth);
}

/// A widget that conditionally displays children based on media query constraints.
///
/// Shows [child] when the current screen width falls within the specified range
/// defined by [minWidth] and [maxWidth]. Optionally displays [alternateChild]
/// when the width is outside the range. Useful for responsive layouts.
///
/// Example:
/// ```dart
/// VNLMediaQueryVisibility(
///   minWidth: 600,
///   maxWidth: 1200,
///   child: TabletLayout(),
///   alternateChild: MobileLayout(),
/// )
/// ```
class VNLMediaQueryVisibility extends StatelessWidget {
  /// Minimum screen width to show [child].
  ///
  /// If `null`, no minimum constraint is applied.
  final double? minWidth;

  /// Maximum screen width to show [child].
  ///
  /// If `null`, no maximum constraint is applied.
  final double? maxWidth;

  /// Widget to display when width is within range.
  final Widget child;

  /// Widget to display when width is outside range.
  ///
  /// If `null`, nothing is displayed when outside range.
  final Widget? alternateChild;

  /// Creates a [VNLMediaQueryVisibility].
  ///
  /// Parameters:
  /// - [minWidth] (`double?`, optional): Minimum width threshold.
  /// - [maxWidth] (`double?`, optional): Maximum width threshold.
  /// - [child] (`Widget`, required): Widget to show within range.
  /// - [alternateChild] (`Widget?`, optional): Widget to show outside range.
  const VNLMediaQueryVisibility({
    super.key,
    this.minWidth,
    this.maxWidth,
    required this.child,
    this.alternateChild,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final compTheme =
        VNLComponentTheme.maybeOf<VNLMediaQueryVisibilityTheme>(context);
    final size = mediaQuery.size.width;
    final minWidth = styleValue(
        widgetValue: this.minWidth,
        themeValue: compTheme?.minWidth,
        defaultValue: null);
    final maxWidth = styleValue(
        widgetValue: this.maxWidth,
        themeValue: compTheme?.maxWidth,
        defaultValue: null);
    if (minWidth != null && size < minWidth) {
      return SizedBox(
        child: alternateChild,
      );
    }
    if (maxWidth != null && size > maxWidth) {
      return SizedBox(
        child: alternateChild,
      );
    }
    // to prevent widget tree from changing
    return SizedBox(
      child: child,
    );
  }
}
