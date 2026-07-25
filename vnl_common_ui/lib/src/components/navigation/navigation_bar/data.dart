import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Enumeration defining alignment options for navigation bar items.
///
/// This enum provides various alignment strategies for positioning navigation
/// items within the available space, corresponding to Flutter's MainAxisAlignment
/// options but specifically tailored for navigation contexts.
enum VNLNavigationBarAlignment {
  /// Align items to the start of the navigation bar.
  start(MainAxisAlignment.start),

  /// Center items within the navigation bar.
  center(MainAxisAlignment.center),

  /// Align items to the end of the navigation bar.
  end(MainAxisAlignment.end),

  /// Distribute items with space between them.
  spaceBetween(MainAxisAlignment.spaceBetween),

  /// Distribute items with space around them.
  spaceAround(MainAxisAlignment.spaceAround),

  /// Distribute items with equal space between and around them.
  spaceEvenly(MainAxisAlignment.spaceEvenly);

  /// The corresponding MainAxisAlignment value.
  final MainAxisAlignment mainAxisAlignment;

  /// Creates a VNLNavigationBarAlignment with the associated MainAxisAlignment.
  const VNLNavigationBarAlignment(this.mainAxisAlignment);
}

/// Enumeration defining alignment options for navigation rail items.
///
/// This enum provides alignment strategies specifically for navigation rails,
/// which are typically vertical navigation components.
enum VNLNavigationRailAlignment {
  /// Align items to the start (top) of the rail.
  start,

  /// Center items within the rail.
  center,

  /// Align items to the end (bottom) of the rail.
  end
}

/// Enumeration defining the type of navigation container.
///
/// This enum identifies the different navigation layout modes available,
/// each with distinct visual presentations and interaction patterns.
enum VNLNavigationContainerType {
  /// Vertical rail navigation, typically positioned at the side.
  rail,

  /// Horizontal bar navigation, typically positioned at the top or bottom.
  bar,

  /// Expandable sidebar navigation with more space for content.
  sidebar
}

/// Determines when labels are shown in navigation items.
enum VNLNavigationLabelType {
  /// No labels displayed.
  none,

  /// Labels shown only for selected items.
  selected,

  /// Labels always shown for all items.
  all,

  /// Labels shown as tooltips on hover.
  tooltip,

  /// Labels shown when navigation is expanded.
  expanded,
}

/// Position of navigation item labels relative to icons.
enum VNLNavigationLabelPosition {
  /// VNLLabel before icon (left in LTR, right in RTL)
  start,

  /// VNLLabel after icon (right in LTR, left in RTL)
  end,

  /// VNLLabel above icon
  top,

  /// VNLLabel below icon
  bottom,
}

/// Size variant for navigation item labels.
enum VNLNavigationLabelSize {
  /// Compact label text
  small,

  /// Larger label text
  large,
}

/// Data class containing navigation control configuration and state.
///
/// Manages layout, styling, and interaction settings for navigation
/// containers and their children. Used internally to coordinate
/// behavior across navigation items.
class VNLNavigationControlData {
  /// Type of navigation container (bar, rail, etc.).
  final VNLNavigationContainerType containerType;

  /// VNLLabel display type from parent container.
  final VNLNavigationLabelType parentLabelType;

  /// VNLLabel position relative to icon from parent.
  final VNLNavigationLabelPosition parentLabelPosition;

  /// VNLLabel size variant from parent.
  final VNLNavigationLabelSize parentLabelSize;

  /// Padding applied by parent container.
  final EdgeInsets parentPadding;

  /// Layout direction (horizontal or vertical).
  final Axis direction;

  /// Currently selected item key (null if none selected).
  final Key? selectedKey;

  /// Total number of child items.
  final int childCount;

  /// Callback when an item is selected.
  final ValueChanged<Key?>? onSelected;

  /// Whether the navigation is expanded to fill available space.
  final bool expanded;

  /// Spacing between navigation items.
  final double spacing;

  /// Whether to maintain cross-axis size constraints.
  final bool keepCrossAxisSize;

  /// Whether to maintain main-axis size constraints.
  final bool keepMainAxisSize;

  /// Computed label direction based on parent label position.
  ///
  /// Returns horizontal for start/end positions, vertical for top/bottom.
  Axis get labelDirection {
    return parentLabelPosition == VNLNavigationLabelPosition.start ||
            parentLabelPosition == VNLNavigationLabelPosition.end
        ? Axis.horizontal
        : Axis.vertical;
  }

  /// Creates navigation control data.
  ///
  /// Parameters:
  /// - [containerType] (VNLNavigationContainerType, required): Container type
  /// - [parentLabelType] (VNLNavigationLabelType, required): VNLLabel display type
  /// - [parentLabelPosition] (VNLNavigationLabelPosition, required): VNLLabel position
  /// - [parentLabelSize] (VNLNavigationLabelSize, required): VNLLabel size variant
  /// - [parentPadding] (EdgeInsets, required): Container padding
  /// - [direction] (Axis, required): Layout direction
  /// - [selectedKey] (Key?): Selected item key
  /// - [onSelected] (`ValueChanged<Key>`, required): Selection callback
  /// - [expanded] (bool, required): Whether expanded
  /// - [childCount] (int, required): Number of children
  /// - [spacing] (double, required): Item spacing
  /// - [keepCrossAxisSize] (bool, required): Maintain cross-axis size
  /// - [keepMainAxisSize] (bool, required): Maintain main-axis size
  VNLNavigationControlData({
    required this.containerType,
    required this.parentLabelType,
    required this.parentLabelPosition,
    required this.parentLabelSize,
    required this.parentPadding,
    required this.direction,
    this.selectedKey,
    this.onSelected,
    required this.expanded,
    required this.childCount,
    required this.spacing,
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VNLNavigationControlData &&
        other.containerType == containerType &&
        other.parentLabelType == parentLabelType &&
        other.parentPadding == parentPadding &&
        other.direction == direction &&
        other.selectedKey == selectedKey &&
        other.onSelected == onSelected &&
        other.parentLabelPosition == parentLabelPosition &&
        other.parentLabelSize == parentLabelSize &&
        other.expanded == expanded &&
        other.childCount == childCount &&
        other.spacing == spacing &&
        other.keepCrossAxisSize == keepCrossAxisSize &&
        other.keepMainAxisSize == keepMainAxisSize;
  }

  @override
  int get hashCode {
    return Object.hash(
      containerType,
      parentLabelType,
      parentPadding,
      direction,
      selectedKey,
      onSelected,
      parentLabelPosition,
      parentLabelSize,
      expanded,
      childCount,
      spacing,
      keepCrossAxisSize,
      keepMainAxisSize,
    );
  }
}
