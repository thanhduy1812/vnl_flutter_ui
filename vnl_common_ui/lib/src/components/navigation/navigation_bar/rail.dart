import 'package:vnl_common_ui/shadcn_flutter.dart';

/// A standard navigation rail component for sidebar-style navigation.
///
/// Provides a compact vertical navigation bar (rail) typically used on the side
/// of a screen. It can be configured with or without labels, support multiple
/// alignment modes, and manage its own selection state. Navigation items
/// are defined through the [children] and [footer] properties.
///
/// Features:
/// - Supports both vertical and horizontal orientations
/// - Configurable alignment (start, center, end)
/// - Flexible label display modes (always, never, selected)
/// - Optional header and footer sections
/// - Built-in expansion and collapse animations
/// - Customizable background, surface effects, and constraints
///
/// Example:
/// ```dart
/// VNLNavigationRail(
///   selectedKey: ValueKey('home'),
///   onSelected: (key) => setState(() => selectedKey = key),
///   children: [
///     VNLNavigationItem(
///       key: ValueKey('home'),
///       icon: Icon(Icons.home),
///       label: Text('Home'),
///     ),
///     VNLNavigationItem(
///       key: ValueKey('search'),
///       icon: Icon(Icons.search),
///       label: Text('Search'),
///     ),
///   ],
/// )
/// ```
class VNLNavigationRail extends StatefulWidget {
  /// Background color of the navigation rail.
  final Color? backgroundColor;

  /// Alignment of navigation items along the main axis.
  final VNLNavigationRailAlignment alignment;

  /// Layout direction (horizontal or vertical).
  final Axis direction;

  /// Spacing between navigation items.
  final double? spacing;

  /// Type of label display behavior.
  final VNLNavigationLabelType labelType;

  /// Position of labels relative to icons.
  final VNLNavigationLabelPosition labelPosition;

  /// Size variant for labels.
  final VNLNavigationLabelSize labelSize;

  /// Internal padding of the navigation rail.
  final EdgeInsetsGeometry? padding;

  /// Constraints for the navigation rail container.
  final BoxConstraints? constraints;

  /// Cross-axis size when the rail is expanded.
  final double? expandedSize;

  /// Cross-axis size when the rail is collapsed.
  final double? collapsedSize;

  /// Surface opacity effect for the background.
  final double? surfaceOpacity;

  /// Surface blur effect for the background.
  final double? surfaceBlur;

  /// Whether the rail is in its expanded state.
  final bool expanded;

  /// Whether to maintain intrinsic size along the main axis.
  final bool keepMainAxisSize;

  /// Whether to maintain intrinsic size along the cross axis.
  final bool keepCrossAxisSize;

  /// Optional header widget displayed at the start of the rail.
  final List<Widget>? header;

  /// Optional footer widget displayed at the end of the rail.
  final List<Widget>? footer;

  /// List of navigation items to display.
  final List<Widget> children;

  /// Currently selected item key.
  final Key? selectedKey;

  /// Callback when an item is selected.
  final ValueChanged<Key?>? onSelected;

  /// Creates a [VNLNavigationRail] with the specified configuration and items.
  ///
  /// The [children] parameter is required and should contain [VNLNavigationBarItem]
  /// widgets that define the navigation destinations. Other parameters control
  /// the rail's appearance, behavior, and layout characteristics.
  ///
  /// Default values provide a sensible vertical rail configuration suitable
  /// for most sidebar navigation scenarios. Customization allows adaptation
  /// to specific layout requirements and design systems.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): Navigation destinations
  /// - [alignment] (VNLNavigationRailAlignment, default: center): Item alignment along main axis
  /// - [direction] (Axis, default: vertical): Layout orientation of the rail
  /// - [labelType] (VNLNavigationLabelType, default: selected): When to show labels
  /// - [labelPosition] (VNLNavigationLabelPosition, default: bottom): VNLLabel positioning
  /// - [selectedKey] (Key?, optional): Currently selected item key
  /// - [onSelected] (`ValueChanged<Key?>?`, optional): Selection change callback
  const VNLNavigationRail({
    super.key,
    this.backgroundColor,
    this.alignment = VNLNavigationRailAlignment.center,
    this.direction = Axis.vertical,
    this.spacing,
    this.labelType = VNLNavigationLabelType.selected,
    this.labelPosition = VNLNavigationLabelPosition.bottom,
    this.labelSize = VNLNavigationLabelSize.small,
    this.padding,
    this.constraints,
    this.expandedSize,
    this.collapsedSize,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.expanded = true,
    this.keepMainAxisSize = false,
    this.keepCrossAxisSize = false,
    this.header,
    this.footer,
    this.selectedKey,
    this.onSelected,
    required this.children,
  });

  @override
  State<VNLNavigationRail> createState() => _NavigationRailState();
}

class _NavigationRailState extends State<VNLNavigationRail> {
  void _onSelected(Key? key) {
    widget.onSelected?.call(key);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;

    final sectionGap = densityGap * padSm;

    var parentPadding = widget.padding ??
        EdgeInsetsDensity.all(
          widget.expanded ? padSm : padXs,
        ).resolveDensity(theme.density.baseContainerPadding * scaling);
    var directionality = Directionality.of(context);
    var resolvedPadding = parentPadding.resolve(directionality);

    final baseData = VNLNavigationControlData(
      containerType: VNLNavigationContainerType.rail,
      parentLabelType: widget.labelType,
      parentLabelPosition: widget.labelPosition,
      parentLabelSize: widget.labelSize,
      parentPadding: resolvedPadding,
      direction: widget.direction,
      expanded: widget.expanded,
      onSelected: _onSelected,
      selectedKey: widget.selectedKey,
      childCount: widget.children.length,
      spacing: widget.spacing ?? densityGap,
      keepCrossAxisSize: widget.keepCrossAxisSize,
      keepMainAxisSize: widget.keepMainAxisSize,
    );

    Widget buildSection(List<Widget> items, EdgeInsets padding) {
      if (items.isEmpty) {
        return const SizedBox.shrink();
      }

      return Data.inherit(
        data: VNLNavigationControlData(
          containerType: baseData.containerType,
          parentLabelType: baseData.parentLabelType,
          parentLabelPosition: baseData.parentLabelPosition,
          parentLabelSize: baseData.parentLabelSize,
          parentPadding: baseData.parentPadding,
          direction: baseData.direction,
          selectedKey: baseData.selectedKey,
          onSelected: baseData.onSelected,
          expanded: baseData.expanded,
          childCount: items.length,
          spacing: baseData.spacing,
          keepCrossAxisSize: baseData.keepCrossAxisSize,
          keepMainAxisSize: baseData.keepMainAxisSize,
        ),
        child: AnimatedPadding(
          duration: kDefaultDuration,
          padding: resolvedPadding,
          child: Flex(
            direction: widget.direction,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items,
          ),
        ),
      );
    }

    final headerItems = widget.header ?? [];
    final footerItems = widget.footer ?? [];

    Widget rail = RepaintBoundary(
      child: Data.inherit(
        data: baseData,
        child: VNLSurfaceBlur(
          surfaceBlur: widget.surfaceBlur,
          child: AnimatedContainer(
            duration: kDefaultDuration,
            color: widget.backgroundColor ??
                (theme.colorScheme.background.scaleAlpha(
                  widget.surfaceOpacity ?? 1,
                )),
            child: Flex(
              direction: widget.direction,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (headerItems.isNotEmpty)
                  buildSection(
                      headerItems,
                      resolvedPadding.copyWith(
                        bottom: 0,
                      )),
                Expanded(
                  child: AnimatedValueBuilder<EdgeInsets>(
                      value: resolvedPadding,
                      duration: kDefaultDuration,
                      child: Flex(
                        direction: widget.direction,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: baseData.spacing,
                        children: widget.children,
                      ),
                      builder: (context, resolvedPadding, child) {
                        return SingleChildScrollView(
                          scrollDirection: widget.direction,
                          padding: resolvedPadding.copyWith(
                            top: headerItems.isNotEmpty
                                ? sectionGap
                                : resolvedPadding.top,
                            bottom: footerItems.isNotEmpty
                                ? sectionGap
                                : resolvedPadding.bottom,
                          ),
                          child: child!,
                        );
                      }),
                ),
                if (footerItems.isNotEmpty)
                  buildSection(
                      footerItems,
                      resolvedPadding.copyWith(
                        top: 0,
                      )),
              ],
            ),
          ),
        ),
      ),
    );
    if (widget.constraints != null) {
      rail = ConstrainedBox(constraints: widget.constraints!, child: rail);
    }
    if (widget.expandedSize != null || widget.collapsedSize != null) {
      final targetMinSize = widget.expanded
          ? (widget.expandedSize ?? 0.0)
          : (widget.collapsedSize ?? 0.0);
      final maxSize = widget.expandedSize ?? double.infinity;
      rail = AnimatedValueBuilder<double>(
        value: targetMinSize,
        duration: kDefaultDuration,
        // curve: Curves.easeInOut,
        builder: (context, animatedMinSize, child) {
          return ConstrainedBox(
            constraints: widget.direction == Axis.vertical
                ? BoxConstraints(minWidth: animatedMinSize, maxWidth: maxSize)
                : BoxConstraints(
                    minHeight: animatedMinSize, maxHeight: maxSize),
            child: child,
          );
        },
        child: rail,
      );
    }
    return _wrapIntrinsic(child: rail);
  }

  Widget _wrapIntrinsic({required Widget child}) {
    if (widget.direction == Axis.horizontal) {
      return IntrinsicHeight(child: child);
    }
    return IntrinsicWidth(child: child);
  }
}
