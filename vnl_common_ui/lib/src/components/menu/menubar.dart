import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Theme configuration for [VNLMenubar] appearance and layout.
///
/// MenubarTheme defines the visual styling for menubar components including
/// borders, colors, positioning, and spacing. All properties are optional
/// and fall back to theme defaults when not specified.
///
/// The theme controls both the menubar container appearance and the behavior
/// of submenu positioning when menu items are opened.
///
/// Example:
/// ```dart
/// VNLComponentTheme<VNLMenubarTheme>(
///   data: VNLMenubarTheme(
///     border: true,
///     backgroundColor: VNLColors.white,
///     borderColor: VNLColors.grey,
///     borderRadius: BorderRadius.circular(8),
///     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
///     subMenuOffset: Offset(0, 8),
///   ),
///   child: VNLMenubar(...),
/// )
/// ```
/// Theme for [VNLMenubar].
class VNLMenubarTheme extends ComponentThemeData {
  /// Whether to draw a border around the menubar container.
  ///
  /// Type: `bool?`. If null, uses the widget's border property. When true,
  /// the menubar is wrapped with an outlined container with customizable
  /// border color and radius.
  final bool? border;

  /// Positioning offset for submenu popovers when menu items are opened.
  ///
  /// Type: `Offset?`. If null, uses calculated defaults based on border
  /// presence. Controls where submenus appear relative to their parent items.
  final Offset? subMenuOffset;

  /// Internal padding within the menubar container.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses 4 logical pixels on all sides
  /// scaled by theme scaling. Applied inside the border when present.
  final EdgeInsetsGeometry? padding;

  /// Color of the border when [border] is enabled.
  ///
  /// Type: `Color?`. If null, uses the theme's border color. Only visible
  /// when [border] is true.
  final Color? borderColor;

  /// Background color of the menubar container.
  ///
  /// Type: `Color?`. If null, uses the theme's background color. Applied
  /// to the menubar's container element.
  final Color? backgroundColor;

  /// Border radius for the menubar container corners.
  ///
  /// Type: `BorderRadiusGeometry?`. If null, uses the theme's medium border
  /// radius. Only visible when [border] is true.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [MenubarTheme].
  const VNLMenubarTheme({
    this.border,
    this.subMenuOffset,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  VNLMenubarTheme copyWith({
    ValueGetter<bool?>? border,
    ValueGetter<Offset?>? subMenuOffset,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? borderColor,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return VNLMenubarTheme(
      border: border == null ? this.border : border(),
      subMenuOffset:
          subMenuOffset == null ? this.subMenuOffset : subMenuOffset(),
      padding: padding == null ? this.padding : padding(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLMenubarTheme &&
        other.border == border &&
        other.subMenuOffset == subMenuOffset &&
        other.padding == padding &&
        other.borderColor == borderColor &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        border,
        subMenuOffset,
        padding,
        borderColor,
        backgroundColor,
        borderRadius,
      );
}

/// A horizontal menubar widget for displaying application menus and menu items.
///
/// VNLMenubar provides a classic application-style menu interface with horizontal
/// layout and dropdown submenu support. It organizes menu items in a row format
/// similar to traditional desktop application menubars, with each item capable
/// of revealing dropdown menus when activated.
///
/// The menubar supports hierarchical menu structures through VNLMenuItem widgets
/// that can contain nested menu items. It handles focus management, keyboard
/// navigation, and proper popover positioning for submenu display.
///
/// Features:
/// - Horizontal layout of top-level menu items
/// - Dropdown submenu support with configurable positioning
/// - Optional border and styling customization
/// - Keyboard navigation and accessibility support
/// - Focus region management for proper menu behavior
/// - Automatic sizing and layout adaptation
/// - Theme-aware styling with comprehensive customization options
///
/// The widget integrates with the VNLMenuGroup system to provide consistent
/// menu behavior across different contexts and supports both bordered and
/// borderless display modes.
///
/// Example:
/// ```dart
/// VNLMenubar(
///   border: true,
///   children: [
///     VNLMenuItem(
///       title: Text('File'),
///       children: [
///         VNLMenuItem(
///           title: Text('New'),
///           onPressed: () => createNewFile(),
///         ),
///         VNLMenuItem(
///           title: Text('Open'),
///           onPressed: () => openFile(),
///         ),
///         VNLMenuDivider(),
///         VNLMenuItem(
///           title: Text('Exit'),
///           onPressed: () => exitApp(),
///         ),
///       ],
///     ),
///     VNLMenuItem(
///       title: Text('Edit'),
///       children: [
///         VNLMenuItem(title: Text('Cut')),
///         VNLMenuItem(title: Text('Copy')),
///         VNLMenuItem(title: Text('Paste')),
///       ],
///     ),
///   ],
/// )
/// ```
class VNLMenubar extends StatefulWidget {
  /// List of menu items to display in the menubar.
  ///
  /// Type: `List<VNLMenuItem>`. Each VNLMenuItem represents a top-level menu that
  /// can contain nested menu items for dropdown functionality. Items are
  /// displayed horizontally in the order provided.
  final List<VNLMenuItem> children;

  /// Positioning offset for submenu popovers when items are opened.
  ///
  /// Type: `Offset?`. If null, uses theme defaults or calculated values based
  /// on border presence. Controls where dropdown menus appear relative to
  /// their parent menu items.
  final Offset? popoverOffset;

  /// Whether to draw a border around the menubar container.
  ///
  /// Type: `bool`, default: `true`. When true, the menubar is wrapped with
  /// an outlined container using theme colors and border radius.
  final bool border;

  /// Creates a [VNLMenubar] with horizontal menu layout.
  ///
  /// Configures a horizontal menubar that displays menu items and supports
  /// dropdown submenus with customizable styling and positioning.
  ///
  /// Parameters:
  /// - [key] (Key?): Widget identifier for the widget tree
  /// - [children] (`List<VNLMenuItem>`, required): Menu items to display horizontally
  /// - [popoverOffset] (Offset?, optional): Positioning offset for dropdown menus
  /// - [border] (bool, default: true): Whether to show a border around the menubar
  ///
  /// Example:
  /// ```dart
  /// VNLMenubar(
  ///   border: true,
  ///   popoverOffset: Offset(0, 8),
  ///   children: [
  ///     VNLMenuItem(
  ///       title: Text('View'),
  ///       children: [
  ///         VNLMenuItem(title: Text('Zoom In')),
  ///         VNLMenuItem(title: Text('Zoom Out')),
  ///         VNLMenuDivider(),
  ///         VNLMenuItem(title: Text('Full Screen')),
  ///       ],
  ///     ),
  ///     VNLMenuItem(
  ///       title: Text('Tools'),
  ///       children: [
  ///         VNLMenuItem(title: Text('Preferences')),
  ///         VNLMenuItem(title: Text('Extensions')),
  ///       ],
  ///     ),
  ///   ],
  /// )
  /// ```
  const VNLMenubar({
    super.key,
    this.popoverOffset,
    this.border = true,
    required this.children,
  });

  @override
  State<VNLMenubar> createState() => VNLMenubarState();
}

/// State class for [VNLMenubar] widget.
///
/// Manages the rendering and theming of the menubar container.
class VNLMenubarState extends State<VNLMenubar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final densityGap = theme.density.baseGap * theme.scaling;
    final compTheme = VNLComponentTheme.maybeOf<VNLMenubarTheme>(context);
    final bool border = compTheme?.border ?? widget.border;
    final borderColor = compTheme?.borderColor ?? theme.colorScheme.border;
    final backgroundColor =
        compTheme?.backgroundColor ?? theme.colorScheme.background;
    final borderRadius = compTheme?.borderRadius ?? theme.borderRadiusMd;
    final padding = compTheme?.padding ?? EdgeInsets.all(densityGap * 0.5);

    if (border) {
      return VNLOutlinedContainer(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        child: AnimatedPadding(
          duration: kDefaultDuration,
          padding: padding,
          child: buildContainer(context, theme,
              compTheme?.subMenuOffset ?? widget.popoverOffset, border),
        ),
      );
    }
    return buildContainer(context, theme,
        compTheme?.subMenuOffset ?? widget.popoverOffset, border);
  }

  /// Builds the container widget for the menubar.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): build context
  /// - [theme] (`ThemeData`, required): theme data
  /// - [subMenuOffset] (`Offset?`, optional): offset for submenu positioning
  /// - [border] (`bool`, required): whether to show border
  ///
  /// Returns: `Widget` — container with menu items
  Widget buildContainer(BuildContext context, ThemeData theme,
      Offset? subMenuOffset, bool border) {
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final offset = subMenuOffset ??
        (border
            ? Offset(-densityGap * 0.5, densityGap)
            : Offset(0, densityGap * 0.5));
    return Data.inherit(
      data: this,
      child: VNLMenuGroup(
        regionGroupId: this,
        direction: Axis.vertical,
        itemPadding: EdgeInsets.zero,
        subMenuOffset: offset,
        autofocus: false,
        builder: (context, children) {
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ).medium();
        },
        children: widget.children,
      ),
    );
  }
}
