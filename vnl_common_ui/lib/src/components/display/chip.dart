import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Theme for [VNLChip].
class VNLChipTheme extends ComponentThemeData {
  /// The padding inside the chip.
  final EdgeInsetsGeometry? padding;

  /// The default [VNLButton] style of the chip.
  final VNLAbstractButtonStyle? style;

  /// Creates a [ChipTheme].
  const VNLChipTheme({this.padding, this.style});

  /// Creates a copy of this theme with the given values replaced.
  VNLChipTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<VNLAbstractButtonStyle?>? style,
  }) {
    return VNLChipTheme(
      padding: padding == null ? this.padding : padding(),
      style: style == null ? this.style : style(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLChipTheme &&
        other.padding == padding &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(padding, style);
}

/// Specialized button component designed for use within chips.
///
/// A compact button widget optimized for use as leading or trailing elements
/// within [VNLChip] widgets. Provides consistent styling and behavior for
/// interactive chip elements like close buttons or action triggers.
///
/// Example:
/// ```dart
/// VNLChipButton(
///   onPressed: () => removeItem(item),
///   child: Icon(Icons.close, size: 14),
/// );
/// ```
class VNLChipButton extends StatelessWidget {
  /// The widget to display as the button content.
  final Widget child;

  /// Callback invoked when the button is pressed.
  final VoidCallback? onPressed;

  /// Creates a chip button with the specified child and callback.
  const VNLChipButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = VNLComponentTheme.maybeOf<VNLChipTheme>(context);
    final padding = styleValue(
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.zero,
    );
    final style = compTheme?.style ??
        VNLButtonVariance(
          decoration: (context, states) {
            return const BoxDecoration();
          },
          mouseCursor: (context, states) {
            if (states.contains(WidgetState.disabled)) {
              return SystemMouseCursors.basic;
            }
            return SystemMouseCursors.click;
          },
          padding: (context, states) {
            return padding;
          },
          textStyle: (context, states) {
            return const TextStyle();
          },
          iconTheme: (context, states) {
            return theme.iconTheme.xSmall;
          },
          margin: (context, states) {
            return EdgeInsets.zero;
          },
        );
    return VNLButton(
      style: style,
      onPressed: onPressed,
      child: child,
    );
  }
}

/// Compact interactive element for tags, labels, and selections.
///
/// A versatile chip widget that combines button functionality with a compact
/// form factor. Ideal for representing tags, categories, filters, or selected
/// items in a space-efficient manner with optional interactive elements.
///
/// ## Features
///
/// - **Compact design**: Space-efficient layout perfect for tags and labels
/// - **Interactive elements**: Optional leading and trailing widgets (icons, buttons)
/// - **Customizable styling**: Flexible button styling with theme integration
/// - **Touch feedback**: Optional press handling with visual feedback
/// - **Accessibility**: Full screen reader support and keyboard navigation
/// - **Consistent theming**: Integrated with the component theme system
///
/// The chip renders as a rounded button with optional leading and trailing
/// elements, making it perfect for filter tags, contact chips, or selection
/// indicators.
///
/// Example:
/// ```dart
/// VNLChip(
///   leading: Icon(Icons.star),
///   child: Text('Favorites'),
///   trailing: VNLChipButton(
///     onPressed: () => removeFilter('favorites'),
///     child: Icon(Icons.close),
///   ),
///   onPressed: () => toggleFilter('favorites'),
///   style: VNLButtonStyle.secondary(),
/// );
/// ```
class VNLChip extends StatelessWidget {
  /// The main content of the chip.
  final Widget child;

  /// Optional widget displayed before the child.
  final Widget? leading;

  /// Optional widget displayed after the child.
  final Widget? trailing;

  /// Callback invoked when the chip is pressed.
  final VoidCallback? onPressed;

  /// Custom button style for the chip.
  final VNLAbstractButtonStyle? style;

  /// Creates a [VNLChip].
  ///
  /// The chip displays [child] content with optional [leading] and [trailing]
  /// widgets. When [onPressed] is provided, the entire chip becomes interactive.
  ///
  /// Parameters:
  /// - [child] (Widget, required): main content displayed in the chip center
  /// - [leading] (Widget?, optional): widget displayed before the main content
  /// - [trailing] (Widget?, optional): widget displayed after the main content
  /// - [onPressed] (VoidCallback?, optional): callback when chip is pressed
  /// - [style] (VNLAbstractButtonStyle?, optional): override chip button styling
  ///
  /// Example:
  /// ```dart
  /// VNLChip(
  ///   leading: VNLAvatar(user: currentUser),
  ///   child: Text(currentUser.name),
  ///   trailing: VNLChipButton(
  ///     onPressed: () => removeUser(currentUser),
  ///     child: Icon(Icons.close, size: 16),
  ///   ),
  ///   style: VNLButtonStyle.primary(),
  /// )
  /// ```
  const VNLChip({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = VNLComponentTheme.maybeOf<VNLChipTheme>(context);
    final baseStyle = style ?? compTheme?.style ?? VNLButtonVariance.secondary;
    return VNLButton(
      style: baseStyle.copyWith(
        mouseCursor: (context, states, value) {
          return onPressed != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic;
        },
        padding: (context, states, value) {
          return styleValue(
            themeValue: compTheme?.padding,
            defaultValue: EdgeInsets.symmetric(
              horizontal: theme.scaling * 8,
              vertical: theme.scaling * 4,
            ),
          );
        },
      ),
      onPressed: onPressed ?? () {},
      leading: leading,
      trailing: trailing,
      child: child,
    );
  }
}
