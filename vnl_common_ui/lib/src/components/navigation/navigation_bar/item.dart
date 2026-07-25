import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'misc.dart';

/// Selectable navigation item with selection state management.
///
/// Represents a clickable navigation item that can be selected. Supports
/// custom styling for selected/unselected states, labels, and icons.
///
/// Example:
/// ```dart
/// VNLNavigationItem(
///   key: ValueKey('home'),
///   label: Text('Home'),
///   child: Icon(Icons.home),
///   selected: selectedKey == ValueKey('home'),
///   onChanged: (selected) => setState(() => selectedKey = ValueKey('home')),
/// )
/// )
/// ```
class VNLNavigationItem extends VNLAbstractNavigationButton {
  /// Custom style when item is selected.
  final VNLAbstractButtonStyle? selectedStyle;

  /// Whether this item is currently selected.
  final bool? selected;

  /// Callback when selection state changes.
  final ValueChanged<bool>? onChanged;

  /// Creates a navigation item.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [selectedStyle] (VNLAbstractButtonStyle?): Style when selected
  /// - [selected] (bool?): Current selection state
  /// - [onChanged] (`ValueChanged<bool>?`): Selection change callback
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (VNLAbstractButtonStyle?): Default style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (VNLNavigationOverflow): Overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const VNLNavigationItem({
    super.key,
    this.selectedStyle,
    this.selected,
    this.onChanged,
    super.label,
    super.spacing,
    super.style,
    super.alignment,
    super.enabled,
    super.overflow,
    super.marginAlignment,
    required super.child,
  });

  @override
  State<VNLAbstractNavigationButton> createState() => _NavigationItemState();
}

class _NavigationItemState
    extends _AbstractNavigationButtonState<VNLNavigationItem> {
  @override
  Widget buildBox(
    BuildContext context,
    VNLNavigationControlData? data,
  ) {
    var key = widget.key;
    var isSelected =
        widget.selected ?? (key != null && key == data?.selectedKey);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final labelType = data?.parentLabelType ?? VNLNavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    bool showLabel = labelType == VNLNavigationLabelType.all ||
        (labelType == VNLNavigationLabelType.selected && isSelected) ||
        (labelType == VNLNavigationLabelType.expanded && data?.expanded == true);

    VNLAbstractButtonStyle style = widget.style ??
        (data?.containerType != VNLNavigationContainerType.sidebar
            ? const VNLButtonStyle.ghost(density: VNLButtonDensity.icon)
            : const VNLButtonStyle.ghost());
    VNLAbstractButtonStyle selectedStyle = widget.selectedStyle ??
        (data?.containerType != VNLNavigationContainerType.sidebar
            ? const VNLButtonStyle.secondary(density: VNLButtonDensity.icon)
            : const VNLButtonStyle.secondary());

    Widget? label = widget.label == null
        ? const SizedBox.shrink()
        : DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            child: VNLNavigationChildOverflowHandle(
              overflow: widget.overflow,
              child: data?.parentLabelSize == VNLNavigationLabelSize.small
                  ? widget.label!.xSmall()
                  : widget.label!,
            ),
          );
    var canShowLabel = (labelType == VNLNavigationLabelType.expanded ||
        labelType == VNLNavigationLabelType.all ||
        labelType == VNLNavigationLabelType.selected);

    return VNLSelectedButton(
      value: isSelected,
      enabled: widget.enabled,
      onChanged: (value) {
        widget.onChanged?.call(value);
        if (key != null && value) {
          data?.onSelected?.call(key);
        }
      },
      marginAlignment: widget.marginAlignment,
      style: style,
      selectedStyle: selectedStyle,
      alignment: widget.alignment ??
          (data?.containerType == VNLNavigationContainerType.sidebar &&
                  data?.labelDirection == Axis.horizontal
              ? (data?.parentLabelPosition == VNLNavigationLabelPosition.start
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart)
              : null),
      child: VNLNavigationLabeled(
        label: label,
        showLabel: showLabel,
        labelType: labelType,
        direction: direction,
        keepMainAxisSize: (data?.keepMainAxisSize ?? false) && canShowLabel,
        keepCrossAxisSize: (data?.keepCrossAxisSize ?? false) && canShowLabel,
        position: data?.parentLabelPosition ?? VNLNavigationLabelPosition.bottom,
        spacing: widget.spacing ?? densityGap,
        child: widget.child,
      ),
    );
  }
}

/// Non-selectable navigation button for actions.
///
/// Similar to [VNLNavigationItem] but without selection state. Used for
/// action buttons in navigation (e.g., settings, logout) that trigger
/// callbacks rather than changing navigation state.
///
/// Example:
/// ```dart
/// VNLNavigationButton(
///   label: Text('Settings'),
///   child: Icon(Icons.settings),
///   onPressed: () => _openSettings(),
/// )
/// ```
class VNLNavigationButton extends VNLAbstractNavigationButton {
  /// Callback when button is pressed.
  final VoidCallback? onPressed;

  /// Whether to enable haptic feedback.
  final bool? enableFeedback;

  /// Creates a navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [enableFeedback] (bool?) : Whether to enable haptic feedback
  /// - [onPressed] (VoidCallback?): Press callback
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (VNLAbstractButtonStyle?): VNLButton style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (TextOverflow?): VNLLabel overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const VNLNavigationButton({
    super.key,
    this.onPressed,
    this.enableFeedback = true,
    super.label,
    super.spacing,
    super.style,
    super.alignment,
    super.enabled,
    super.overflow,
    super.marginAlignment,
    required super.child,
  });

  @override
  State<VNLAbstractNavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState
    extends _AbstractNavigationButtonState<VNLNavigationButton> {
  @override
  Widget buildBox(
    BuildContext context,
    VNLNavigationControlData? data,
  ) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final labelType = data?.parentLabelType ?? VNLNavigationLabelType.none;
    final direction = data?.direction ?? Axis.vertical;
    bool showLabel = labelType == VNLNavigationLabelType.all ||
        (labelType == VNLNavigationLabelType.expanded && data?.expanded == true);
    VNLAbstractButtonStyle style = widget.style ??
        (data?.containerType != VNLNavigationContainerType.sidebar
            ? const VNLButtonStyle.ghost(density: VNLButtonDensity.icon)
            : const VNLButtonStyle.ghost());

    Widget? label = widget.label == null
        ? const SizedBox()
        : DefaultTextStyle.merge(
            textAlign: TextAlign.center,
            child: VNLNavigationChildOverflowHandle(
              overflow: widget.overflow,
              child: data?.parentLabelSize == VNLNavigationLabelSize.small
                  ? widget.label!.xSmall()
                  : widget.label!,
            ),
          );
    var canShowLabel = (labelType == VNLNavigationLabelType.expanded ||
        labelType == VNLNavigationLabelType.all ||
        labelType == VNLNavigationLabelType.selected);
    return VNLButton(
      enabled: widget.enabled,
      onPressed: widget.onPressed,
      marginAlignment: widget.marginAlignment,
      style: style,
      enableFeedback: widget.enableFeedback,
      alignment: widget.alignment ??
          (data?.containerType == VNLNavigationContainerType.sidebar &&
                  data?.labelDirection == Axis.horizontal
              ? (data?.parentLabelPosition == VNLNavigationLabelPosition.start
                  ? AlignmentDirectional.centerEnd
                  : AlignmentDirectional.centerStart)
              : null),
      child: VNLNavigationLabeled(
        label: label,
        showLabel: showLabel,
        labelType: labelType,
        direction: direction,
        keepMainAxisSize: (data?.keepMainAxisSize ?? false) && canShowLabel,
        keepCrossAxisSize: (data?.keepCrossAxisSize ?? false) && canShowLabel,
        position: data?.parentLabelPosition ?? VNLNavigationLabelPosition.bottom,
        spacing: widget.spacing ?? densityGap,
        child: widget.child,
      ),
    );
  }
}

/// Abstract base class for navigation button widgets.
///
/// Provides common properties and behavior for navigation items and buttons.
/// Subclasses include [VNLNavigationItem] and [VNLNavigationButton].
///
/// Handles layout, labels, styling, and integration with navigation containers.
abstract class VNLAbstractNavigationButton extends StatefulWidget {
  /// Main content widget (typically an icon).
  final Widget child;

  /// Optional label text widget.
  final Widget? label;

  /// Spacing between icon and label.
  final double? spacing;

  /// Custom button style.
  final VNLAbstractButtonStyle? style;

  /// Content alignment within the button.
  final AlignmentGeometry? alignment;

  /// Whether the button is enabled for interaction.
  final bool? enabled;

  /// How to handle label overflow.
  final VNLNavigationOverflow overflow;

  /// Alignment for margins.
  final AlignmentGeometry? marginAlignment;

  /// Creates an abstract navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content (icon)
  /// - [spacing] (double?): Icon-label spacing
  /// - [label] (Widget?): VNLLabel widget
  /// - [style] (VNLAbstractButtonStyle?): VNLButton style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Enabled state
  /// - [overflow] (VNLNavigationOverflow): Overflow behavior, defaults to marquee
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const VNLAbstractNavigationButton({
    super.key,
    this.spacing,
    this.label,
    this.style,
    this.alignment,
    this.enabled,
    this.overflow = VNLNavigationOverflow.marquee,
    this.marginAlignment,
    required this.child,
  });

  @override
  State<VNLAbstractNavigationButton> createState();
}

abstract class _AbstractNavigationButtonState<
    T extends VNLAbstractNavigationButton> extends State<T> {
  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<VNLNavigationControlData>(context);
    if (data?.containerType == VNLNavigationContainerType.sidebar) {
      return buildSliver(context, data);
    }
    final labelType = data?.parentLabelType ?? VNLNavigationLabelType.none;
    if (labelType == VNLNavigationLabelType.tooltip) {
      return buildTooltip(context, data);
    }
    return _buildBox(context, data);
  }

  Widget buildTooltip(
    BuildContext context,
    VNLNavigationControlData? data,
  ) {
    if (widget.label == null) {
      return buildBox(context, data);
    }
    AlignmentGeometry alignment = Alignment.topCenter;
    AlignmentGeometry anchorAlignment = Alignment.bottomCenter;
    if (data?.direction == Axis.vertical) {
      alignment = AlignmentDirectional.centerStart;
      anchorAlignment = AlignmentDirectional.centerEnd;
    }
    return VNLTooltip(
      waitDuration: !isMobile(Theme.of(context).platform)
          ? Duration.zero
          : const Duration(milliseconds: 500),
      alignment: alignment,
      anchorAlignment: anchorAlignment,
      tooltip: VNLTooltipContainer(child: widget.label!).call,
      child: buildBox(context, data),
    );
  }

  Widget buildSliver(
    BuildContext context,
    VNLNavigationControlData? data,
  ) {
    final labelType = data?.parentLabelType ?? VNLNavigationLabelType.none;
    if (labelType == VNLNavigationLabelType.tooltip) {
      return SliverToBoxAdapter(child: buildTooltip(context, data));
    }
    return SliverToBoxAdapter(child: _buildBox(context, data));
  }

  Widget _buildBox(
    BuildContext context,
    VNLNavigationControlData? data,
  ) {
    return buildBox(context, data);
  }

  Widget buildBox(
    BuildContext context,
    VNLNavigationControlData? data,
  );
}
