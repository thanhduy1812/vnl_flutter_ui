import 'package:vnl_common_ui/vnl_ui.dart';

/// Closes the currently active overlay with an optional result value.
///
/// Searches up the widget tree for an [OverlayHandlerStateMixin] and
/// requests it to close with the provided result. If no overlay handler
/// is found, returns a completed future.
///
/// Parameters:
/// - [context] (BuildContext, required): Build context from within the overlay
/// - [value] (T?): Optional result value to return when closing
///
/// Returns a [Future] that completes when the overlay is closed.
///
/// Example:
/// ```dart
/// closeOverlay(context, 'user_confirmed');
/// ```
Future<void> closeOverlay<T>(BuildContext context, [T? value]) {
  return Data.maybeFind<OverlayHandlerStateMixin>(context)?.closeWithResult(value) ?? Future.value();
}

/// Mixin providing overlay state management methods.
///
/// Defines the interface for overlay state classes, including methods for
/// closing overlays and updating overlay configuration dynamically.
///
/// Used by overlay implementations to provide consistent lifecycle management
/// and configuration update capabilities.
mixin OverlayHandlerStateMixin<T extends StatefulWidget> on State<T> {
  /// Closes the overlay.
  ///
  /// Parameters:
  /// - [immediate] (bool): If true, closes immediately without animation
  ///
  /// Returns a [Future] that completes when closed.
  Future<void> close([bool immediate = false]);

  /// Schedules overlay closure for the next frame.
  ///
  /// Useful for closing overlays from callbacks where immediate closure
  /// might cause issues with the widget tree.
  void closeLater();

  /// Closes the overlay with a result value.
  ///
  /// Parameters:
  /// - [value] (X?): Optional result to return
  ///
  /// Returns a [Future] that completes when closed.
  Future<void> closeWithResult<X>([X? value]);

  /// Updates the anchor context for positioning.
  set anchorContext(BuildContext value) {}

  /// Updates the overlay alignment.
  set alignment(AlignmentGeometry value) {}

  /// Updates the anchor alignment.
  set anchorAlignment(AlignmentGeometry value) {}

  /// Updates the width constraint.
  set widthConstraint(VNLPopoverConstraint value) {}

  /// Updates the height constraint.
  set heightConstraint(VNLPopoverConstraint value) {}

  /// Updates the margin.
  set margin(EdgeInsets value) {}

  /// Updates whether the overlay follows the anchor.
  set follow(bool value) {}

  /// Updates the position offset.
  set offset(Offset? value) {}

  /// Updates horizontal inversion permission.
  set allowInvertHorizontal(bool value) {}

  /// Updates vertical inversion permission.
  set allowInvertVertical(bool value) {}
}

/// Abstract interface for overlay operation completion tracking.
///
/// Provides lifecycle management and status tracking for overlay operations,
/// including completion state, animation state, and dismissal.
abstract class OverlayCompleter<T> {
  /// Removes the overlay from the screen.
  void remove();

  /// Disposes resources associated with the overlay.
  void dispose();

  /// Whether the overlay operation has completed.
  bool get isCompleted;

  /// Whether the overlay's animation has completed.
  bool get isAnimationCompleted;

  /// Future that completes with the overlay's result value.
  Future<T?> get future;

  /// Future that completes when the overlay animation finishes.
  Future<void> get animationFuture;
}

/// Abstract handler for managing overlay presentation and lifecycle.
///
/// Provides common interface for different overlay types (popover, sheet, dialog)
/// with customizable display, positioning, and interaction behavior.
abstract class VNLOverlayHandler {
  /// Default popover overlay handler.
  static const VNLOverlayHandler popover = VNLPopoverOverlayHandler();

  /// Default sheet overlay handler.
  static const VNLOverlayHandler sheet = VNLSheetOverlayHandler();

  /// Default dialog overlay handler.
  static const VNLOverlayHandler dialog = VNLDialogOverlayHandler();

  /// Creates an [VNLOverlayHandler].
  const VNLOverlayHandler();

  /// Shows an overlay with the specified configuration.
  ///
  /// Displays an overlay (popover, sheet, or dialog) with extensive customization
  /// options for positioning, sizing, behavior, and appearance.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [alignment] (AlignmentGeometry, required): Overlay alignment
  /// - [builder] (WidgetBuilder, required): Overlay content builder
  /// - [position] (Offset?): Explicit position (overrides alignment)
  /// - [anchorAlignment] (AlignmentGeometry?): Anchor alignment
  /// - [widthConstraint] (VNLPopoverConstraint): Width constraint, defaults to flexible
  /// - [heightConstraint] (VNLPopoverConstraint): Height constraint, defaults to flexible
  /// - [key] (Key?): Widget key
  /// - [rootOverlay] (bool): Use root overlay, defaults to true
  /// - [modal] (bool): Modal behavior, defaults to true
  /// - [barrierDismissable] (bool): Dismissible by tapping barrier, defaults to true
  /// - [clipBehavior] (Clip): Clipping behavior, defaults to none
  /// - [regionGroupId] (Object?): Region group ID
  /// - [offset] (Offset?): Position offset
  /// - [transitionAlignment] (AlignmentGeometry?): Transition alignment
  /// - [margin] (EdgeInsetsGeometry?): Overlay margin
  /// - [follow] (bool): Follow anchor on move, defaults to true
  /// - [consumeOutsideTaps] (bool): Consume outside taps, defaults to true
  /// - [onTickFollow] (`ValueChanged<VNLPopoverOverlayWidgetState>?`): Follow tick callback
  /// - [allowInvertHorizontal] (bool): Allow horizontal inversion, defaults to true
  /// - [allowInvertVertical] (bool): Allow vertical inversion, defaults to true
  /// - [dismissBackdropFocus] (bool): Dismiss on backdrop focus, defaults to true
  /// - [showDuration] (Duration?): Show animation duration
  /// - [dismissDuration] (Duration?): Dismiss animation duration
  /// - [overlayBarrier] (VNLOverlayBarrier?): Custom barrier configuration
  /// - [layerLink] (LayerLink?): Layer link for positioning
  ///
  /// Returns an [OverlayCompleter] for managing the overlay lifecycle.
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    VNLPopoverConstraint widthConstraint = VNLPopoverConstraint.flexible,
    VNLPopoverConstraint heightConstraint = VNLPopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<VNLPopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    VNLOverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  });
}

/// Configuration for overlay modal barriers.
///
/// Defines the visual appearance and spacing of the barrier displayed
/// behind modal overlays.
class VNLOverlayBarrier {
  /// Padding around the barrier.
  final EdgeInsetsGeometry padding;

  /// Border radius for the barrier shape.
  final BorderRadiusGeometry borderRadius;

  /// Color of the barrier (typically semi-transparent).
  final Color? barrierColor;

  /// Creates an overlay barrier configuration.
  ///
  /// Parameters:
  /// - [padding] (EdgeInsetsGeometry): Barrier padding, defaults to zero
  /// - [borderRadius] (BorderRadiusGeometry): Border radius, defaults to zero
  /// - [barrierColor] (Color?): Barrier color
  const VNLOverlayBarrier({
    this.padding = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.barrierColor,
  });
}

/// Abstract manager for overlay operations.
///
/// Extends [VNLOverlayHandler] with additional methods for showing specialized
/// overlay types like tooltips and menus. Provides centralized overlay
/// management for an application.
abstract class VNLOverlayManager implements VNLOverlayHandler {
  /// Gets the overlay manager from the widget tree.
  ///
  /// Searches for an [VNLOverlayManager] in the build context and throws
  /// an assertion error if not found.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  ///
  /// Returns the [VNLOverlayManager] instance.
  static VNLOverlayManager of(BuildContext context) {
    var manager = Data.maybeOf<VNLOverlayManager>(context);
    assert(manager != null, 'No VNLOverlayManager found in context');
    return manager!;
  }

  @override
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    VNLPopoverConstraint widthConstraint = VNLPopoverConstraint.flexible,
    VNLPopoverConstraint heightConstraint = VNLPopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<VNLPopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    VNLOverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  });

  /// Shows a tooltip overlay.
  ///
  /// Specialized method for displaying tooltips with appropriate defaults
  /// for tooltip behavior (non-modal, brief display, etc.).
  ///
  /// Parameters similar to [show] method. See [show] for full parameter documentation.
  ///
  /// Returns an [OverlayCompleter] for managing the tooltip lifecycle.
  OverlayCompleter<T?> showTooltip<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    VNLPopoverConstraint widthConstraint = VNLPopoverConstraint.flexible,
    VNLPopoverConstraint heightConstraint = VNLPopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<VNLPopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    VNLOverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  });

  /// Shows a menu overlay.
  ///
  /// Specialized method for displaying menus with appropriate defaults
  /// for menu behavior (dismissible, follows anchor, etc.).
  ///
  /// Parameters similar to [show] method. See [show] for full parameter documentation.
  ///
  /// Returns an [OverlayCompleter] for managing the menu lifecycle.
  OverlayCompleter<T?> showMenu<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    VNLPopoverConstraint widthConstraint = VNLPopoverConstraint.flexible,
    VNLPopoverConstraint heightConstraint = VNLPopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<VNLPopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    VNLOverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  });
}

/// Layer widget managing different overlay handlers for the application.
///
/// Provides centralized overlay management for popovers, tooltips, and menus
/// with customizable handlers for each type.
class VNLOverlayManagerLayer extends StatefulWidget {
  /// Handler for popover overlays.
  final VNLOverlayHandler popoverHandler;

  /// Handler for tooltip overlays.
  final VNLOverlayHandler tooltipHandler;

  /// Handler for menu overlays.
  final VNLOverlayHandler menuHandler;

  /// Child widget wrapped by overlay management.
  final Widget child;

  /// Creates an overlay manager layer.
  ///
  /// Parameters:
  /// - [popoverHandler] (VNLOverlayHandler, required): Handler for popover overlays
  /// - [tooltipHandler] (VNLOverlayHandler, required): Handler for tooltip overlays
  /// - [menuHandler] (VNLOverlayHandler, required): Handler for menu overlays
  /// - [child] (Widget, required): Child widget
  const VNLOverlayManagerLayer({
    super.key,
    required this.popoverHandler,
    required this.tooltipHandler,
    required this.menuHandler,
    required this.child,
  });

  @override
  State<VNLOverlayManagerLayer> createState() => _OverlayManagerLayerState();
}

class _OverlayManagerLayerState extends State<VNLOverlayManagerLayer> implements VNLOverlayManager {
  @override
  Widget build(BuildContext context) {
    return Data<VNLOverlayManager>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    VNLPopoverConstraint widthConstraint = VNLPopoverConstraint.flexible,
    VNLPopoverConstraint heightConstraint = VNLPopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<VNLPopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    VNLOverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
    return widget.popoverHandler.show(
      context: context,
      alignment: alignment,
      builder: builder,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      barrierDismissable: barrierDismissable,
      clipBehavior: clipBehavior,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
      layerLink: layerLink,
    );
  }

  @override
  OverlayCompleter<T?> showTooltip<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    VNLPopoverConstraint widthConstraint = VNLPopoverConstraint.flexible,
    VNLPopoverConstraint heightConstraint = VNLPopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<VNLPopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    VNLOverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
    return widget.tooltipHandler.show(
      context: context,
      alignment: alignment,
      builder: builder,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      barrierDismissable: barrierDismissable,
      clipBehavior: clipBehavior,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
      layerLink: layerLink,
    );
  }

  @override
  OverlayCompleter<T?> showMenu<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    VNLPopoverConstraint widthConstraint = VNLPopoverConstraint.flexible,
    VNLPopoverConstraint heightConstraint = VNLPopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<VNLPopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    VNLOverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
    return widget.menuHandler.show(
      context: context,
      alignment: alignment,
      builder: builder,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      barrierDismissable: barrierDismissable,
      clipBehavior: clipBehavior,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
      layerLink: layerLink,
    );
  }
}
