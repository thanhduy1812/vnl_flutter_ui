import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Theme configuration for swiper overlay behavior and appearance.
///
/// Defines default properties for swiper components including overlay
/// behavior, drag interaction, surface effects, and visual styling.
///
/// Features:
/// - Configurable drag and expansion behavior
/// - Surface effects and backdrop styling
/// - Barrier and interaction customization
/// - Consistent theming across swiper variants
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     SwiperTheme: VNLSwiperTheme(
///       expands: true,
///       draggable: true,
///       barrierDismissible: true,
///       transformBackdrop: true,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
class VNLSwiperTheme extends ComponentThemeData {
  /// Whether the swiper should expand to fill available space.
  final bool? expands;

  /// Whether the swiper can be dragged to dismiss.
  final bool? draggable;

  /// Whether tapping the barrier dismisses the swiper.
  final bool? barrierDismissible;

  /// Builder for custom backdrop content.
  final WidgetBuilder? backdropBuilder;

  /// Whether to respect device safe areas.
  final bool? useSafeArea;

  /// Whether to show the drag handle.
  final bool? showDragHandle;

  /// Border radius for the swiper container.
  final BorderRadiusGeometry? borderRadius;

  /// Size of the drag handle when displayed.
  final Size? dragHandleSize;

  /// Whether to transform the backdrop when shown.
  final bool? transformBackdrop;

  /// Opacity for surface effects.
  final double? surfaceOpacity;

  /// Blur intensity for surface effects.
  final double? surfaceBlur;

  /// Color of the modal barrier.
  final Color? barrierColor;

  /// Hit test behavior for gesture detection.
  final HitTestBehavior? behavior;

  /// Creates a [VNLSwiperTheme].
  ///
  /// All parameters are optional and will use system defaults when null.
  ///
  /// Example:
  /// ```dart
  /// const VNLSwiperTheme(
  ///   expands: true,
  ///   draggable: true,
  ///   transformBackdrop: true,
  /// )
  /// ```
  const VNLSwiperTheme({
    this.expands,
    this.draggable,
    this.barrierDismissible,
    this.backdropBuilder,
    this.useSafeArea,
    this.showDragHandle,
    this.borderRadius,
    this.dragHandleSize,
    this.transformBackdrop,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.behavior,
  });

  /// Creates a copy of this theme with optionally replaced values.
  ///
  /// All parameters are wrapped in [ValueGetter] to allow lazy evaluation
  /// and dynamic theme changes.
  VNLSwiperTheme copyWith({
    ValueGetter<bool?>? expands,
    ValueGetter<bool?>? draggable,
    ValueGetter<bool?>? barrierDismissible,
    ValueGetter<WidgetBuilder?>? backdropBuilder,
    ValueGetter<bool?>? useSafeArea,
    ValueGetter<bool?>? showDragHandle,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<Size?>? dragHandleSize,
    ValueGetter<bool?>? transformBackdrop,
    ValueGetter<double?>? surfaceOpacity,
    ValueGetter<double?>? surfaceBlur,
    ValueGetter<Color?>? barrierColor,
    ValueGetter<HitTestBehavior?>? behavior,
  }) {
    return VNLSwiperTheme(
      expands: expands == null ? this.expands : expands(),
      draggable: draggable == null ? this.draggable : draggable(),
      barrierDismissible: barrierDismissible == null
          ? this.barrierDismissible
          : barrierDismissible(),
      backdropBuilder:
          backdropBuilder == null ? this.backdropBuilder : backdropBuilder(),
      useSafeArea: useSafeArea == null ? this.useSafeArea : useSafeArea(),
      showDragHandle:
          showDragHandle == null ? this.showDragHandle : showDragHandle(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      dragHandleSize:
          dragHandleSize == null ? this.dragHandleSize : dragHandleSize(),
      transformBackdrop: transformBackdrop == null
          ? this.transformBackdrop
          : transformBackdrop(),
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      barrierColor: barrierColor == null ? this.barrierColor : barrierColor(),
      behavior: behavior == null ? this.behavior : behavior(),
    );
  }

  @override
  int get hashCode => Object.hash(
      expands,
      draggable,
      barrierDismissible,
      backdropBuilder,
      useSafeArea,
      showDragHandle,
      borderRadius,
      dragHandleSize,
      transformBackdrop,
      surfaceOpacity,
      surfaceBlur,
      barrierColor,
      behavior);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLSwiperTheme &&
        other.expands == expands &&
        other.draggable == draggable &&
        other.barrierDismissible == barrierDismissible &&
        other.backdropBuilder == backdropBuilder &&
        other.useSafeArea == useSafeArea &&
        other.showDragHandle == showDragHandle &&
        other.borderRadius == borderRadius &&
        other.dragHandleSize == dragHandleSize &&
        other.transformBackdrop == transformBackdrop &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.barrierColor == barrierColor &&
        other.behavior == behavior;
  }

  @override
  String toString() {
    return 'VNLSwiperTheme(expands: $expands, draggable: $draggable, barrierDismissible: $barrierDismissible, backdropBuilder: $backdropBuilder, useSafeArea: $useSafeArea, showDragHandle: $showDragHandle, borderRadius: $borderRadius, dragHandleSize: $dragHandleSize, transformBackdrop: $transformBackdrop, surfaceOpacity: $surfaceOpacity, surfaceBlur: $surfaceBlur, barrierColor: $barrierColor, behavior: $behavior)';
  }
}

/// Abstract handler interface for swiper overlay implementations.
///
/// Defines the contract for creating different types of swiper overlays,
/// with built-in implementations for drawer-style and sheet-style swipers.
///
/// Features:
/// - Pluggable swiper behavior patterns
/// - Built-in drawer and sheet implementations
/// - Consistent API across swiper types
/// - Configurable overlay properties
///
/// Example:
/// ```dart
/// // Use built-in handlers
/// const VNLSwiperHandler.drawer
/// const VNLSwiperHandler.sheet
/// ```
abstract class VNLSwiperHandler {
  /// Handler for drawer-style swipers with backdrop transformation.
  static const VNLSwiperHandler drawer = VNLDrawerSwiperHandler();

  /// Handler for sheet-style swipers with minimal styling.
  static const VNLSwiperHandler sheet = VNLSheetSwiperHandler();

  /// Creates a swiper handler.
  const VNLSwiperHandler();

  /// Creates a swiper overlay with the specified configuration.
  ///
  /// Parameters vary by implementation but commonly include position,
  /// builder, and visual/behavioral properties.
  ///
  /// Returns:
  /// A [DrawerOverlayCompleter] for managing the swiper lifecycle.
  DrawerOverlayCompleter openSwiper({
    required BuildContext context,
    required WidgetBuilder builder,
    required VNLOverlayPosition position,
    bool? expands,
    bool? draggable,
    bool? barrierDismissible,
    WidgetBuilder? backdropBuilder,
    bool? useSafeArea,
    bool? showDragHandle,
    BorderRadiusGeometry? borderRadius,
    Size? dragHandleSize,
    bool? transformBackdrop,
    double? surfaceOpacity,
    double? surfaceBlur,
    Color? barrierColor,
  });
}

/// Drawer-style swiper handler with backdrop transformation.
///
/// Creates swipers that behave like drawers with backdrop scaling,
/// drag handles, and full interaction support.
///
/// Example:
/// ```dart
/// VNLSwiper(
///   handler: VNLSwiperHandler.drawer,
///   position: VNLOverlayPosition.left,
///   builder: (context) => DrawerContent(),
///   child: VNLMenuButton(),
/// )
/// ```
class VNLDrawerSwiperHandler extends VNLSwiperHandler {
  /// Creates a drawer-style swiper handler.
  const VNLDrawerSwiperHandler();

  @override
  DrawerOverlayCompleter openSwiper({
    required BuildContext context,
    required WidgetBuilder builder,
    required VNLOverlayPosition position,
    bool? expands,
    bool? draggable,
    bool? barrierDismissible,
    WidgetBuilder? backdropBuilder,
    bool? useSafeArea,
    bool? showDragHandle,
    BorderRadiusGeometry? borderRadius,
    Size? dragHandleSize,
    bool? transformBackdrop,
    double? surfaceOpacity,
    double? surfaceBlur,
    Color? barrierColor,
  }) {
    return openDrawerOverlay(
      context: context,
      builder: builder,
      position: position,
      expands: expands ?? true,
      draggable: draggable ?? true,
      barrierDismissible: barrierDismissible ?? true,
      backdropBuilder: backdropBuilder,
      useSafeArea: useSafeArea ?? true,
      showDragHandle: showDragHandle ?? true,
      borderRadius: borderRadius,
      dragHandleSize: dragHandleSize,
      transformBackdrop: transformBackdrop ?? true,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      barrierColor: barrierColor,
      autoOpen: false,
    );
  }
}

/// Sheet-style swiper handler with minimal styling.
///
/// Creates swipers that behave like sheets with edge-to-edge content,
/// minimal decoration, and optional drag interaction.
///
/// Example:
/// ```dart
/// VNLSwiper(
///   handler: VNLSwiperHandler.sheet,
///   position: VNLOverlayPosition.bottom,
///   builder: (context) => BottomSheetContent(),
///   child: ActionButton(),
/// )
/// ```
class VNLSheetSwiperHandler extends VNLSwiperHandler {
  /// Creates a sheet-style swiper handler.
  const VNLSheetSwiperHandler();

  @override
  DrawerOverlayCompleter openSwiper({
    required BuildContext context,
    required WidgetBuilder builder,
    required VNLOverlayPosition position,
    bool? expands,
    bool? draggable,
    bool? barrierDismissible,
    WidgetBuilder? backdropBuilder,
    bool? useSafeArea,
    bool? showDragHandle,
    BorderRadiusGeometry? borderRadius,
    Size? dragHandleSize,
    bool? transformBackdrop,
    double? surfaceOpacity,
    double? surfaceBlur,
    Color? barrierColor,
  }) {
    return openSheetOverlay(
      context: context,
      builder: builder,
      position: position,
      barrierDismissible: barrierDismissible ?? true,
      backdropBuilder: backdropBuilder,
      transformBackdrop: transformBackdrop ?? false,
      barrierColor: barrierColor,
      draggable: draggable ?? false,
      autoOpen: false,
    );
  }
}

/// A gesture-responsive widget that triggers overlay content through swiping.
///
/// Detects swipe gestures on the child widget and displays overlay content
/// using the configured handler (drawer or sheet style). Supports both
/// programmatic and gesture-based triggering with comprehensive customization.
///
/// Features:
/// - Gesture-based overlay triggering
/// - Multiple handler implementations (drawer/sheet)
/// - Configurable swipe sensitivity and behavior
/// - Theme integration and visual customization
/// - Programmatic control and dismissal
/// - Position-aware gesture detection
///
/// The swiper responds to swipe gestures in the direction that would reveal
/// the overlay (e.g., swiping right reveals a left-positioned overlay).
///
/// Example:
/// ```dart
/// VNLSwiper(
///   handler: VNLSwiperHandler.drawer,
///   position: VNLOverlayPosition.left,
///   builder: (context) => NavigationDrawer(),
///   child: VNLAppBar(
///     leading: Icon(Icons.menu),
///     title: Text('My App'),
///   ),
/// )
/// ```
class VNLSwiper extends StatefulWidget {
  /// Whether swipe gestures are enabled.
  final bool enabled;

  /// Position from which the overlay should appear.
  final VNLOverlayPosition position;

  /// Builder function that creates the overlay content.
  final WidgetBuilder builder;

  /// Handler that defines the overlay behavior (drawer or sheet).
  final VNLSwiperHandler handler;

  /// Whether the overlay should expand to fill available space.
  final bool? expands;

  /// Whether the overlay can be dragged to dismiss.
  final bool? draggable;

  /// Whether tapping the barrier dismisses the overlay.
  final bool? barrierDismissible;

  /// Builder for custom backdrop content.
  final WidgetBuilder? backdropBuilder;

  /// Whether to respect device safe areas.
  final bool? useSafeArea;

  /// Whether to show the drag handle.
  final bool? showDragHandle;

  /// Border radius for the overlay container.
  final BorderRadiusGeometry? borderRadius;

  /// Size of the drag handle when displayed.
  final Size? dragHandleSize;

  /// Whether to transform the backdrop when shown.
  final bool? transformBackdrop;

  /// Opacity for surface effects.
  final double? surfaceOpacity;

  /// Blur intensity for surface effects.
  final double? surfaceBlur;

  /// Color of the modal barrier.
  final Color? barrierColor;

  /// The child widget that responds to swipe gestures.
  final Widget child;

  /// Hit test behavior for gesture detection.
  final HitTestBehavior? behavior;

  /// Creates a [VNLSwiper].
  ///
  /// The [position], [builder], [handler], and [child] parameters are required.
  /// Other parameters customize the overlay behavior and appearance.
  ///
  /// Parameters:
  /// - [enabled] (bool, default: true): whether swipe gestures are enabled
  /// - [position] (VNLOverlayPosition, required): side from which overlay appears
  /// - [builder] (WidgetBuilder, required): builds the overlay content
  /// - [handler] (VNLSwiperHandler, required): defines overlay behavior (drawer/sheet)
  /// - [child] (Widget, required): widget that responds to swipe gestures
  /// - [expands] (bool?, optional): whether overlay expands to fill space
  /// - [draggable] (bool?, optional): whether overlay can be dragged to dismiss
  /// - [barrierDismissible] (bool?, optional): whether barrier tap dismisses overlay
  /// - [backdropBuilder] (WidgetBuilder?, optional): custom backdrop builder
  /// - [useSafeArea] (bool?, optional): whether to respect safe areas
  /// - [showDragHandle] (bool?, optional): whether to show drag handle
  /// - [borderRadius] (BorderRadiusGeometry?, optional): overlay corner radius
  /// - [dragHandleSize] (Size?, optional): size of drag handle
  /// - [transformBackdrop] (bool?, optional): whether to transform backdrop
  /// - [surfaceOpacity] (double?, optional): surface opacity level
  /// - [surfaceBlur] (double?, optional): surface blur intensity
  /// - [barrierColor] (Color?, optional): modal barrier color
  /// - [behavior] (HitTestBehavior?, optional): gesture detection behavior
  ///
  /// Example:
  /// ```dart
  /// VNLSwiper(
  ///   position: VNLOverlayPosition.bottom,
  ///   handler: VNLSwiperHandler.sheet,
  ///   builder: (context) => ActionSheet(),
  ///   child: FloatingActionButton(
  ///     onPressed: null,
  ///     child: Icon(Icons.more_horiz),
  ///   ),
  /// )
  /// ```
  const VNLSwiper({
    super.key,
    this.enabled = true,
    required this.position,
    required this.builder,
    required this.handler,
    this.expands,
    this.draggable,
    this.barrierDismissible,
    this.backdropBuilder,
    this.useSafeArea,
    this.showDragHandle,
    this.borderRadius,
    this.dragHandleSize,
    this.transformBackdrop,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.behavior,
    required this.child,
  });

  @override
  State<VNLSwiper> createState() => _SwiperState();
}

class _SwiperState extends State<VNLSwiper> {
  DrawerOverlayCompleter? _activeOverlay;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  VNLOverlayPosition get resolvedPosition {
    if (widget.position == VNLOverlayPosition.start) {
      var textDirection = Directionality.of(context);
      return textDirection == TextDirection.ltr
          ? VNLOverlayPosition.left
          : VNLOverlayPosition.right;
    }
    if (widget.position == VNLOverlayPosition.end) {
      var textDirection = Directionality.of(context);
      return textDirection == TextDirection.ltr
          ? VNLOverlayPosition.right
          : VNLOverlayPosition.left;
    }
    return widget.position;
  }

  void _onDrag(DragUpdateDetails details) {
    if (_activeOverlay != null) {
      var resolvedPosition = this.resolvedPosition;
      var controller = _activeOverlay!.animationController;
      double delta;
      switch (resolvedPosition) {
        case VNLOverlayPosition.top:
        case VNLOverlayPosition.left:
          delta = details.primaryDelta!;
          break;
        case VNLOverlayPosition.bottom:
        case VNLOverlayPosition.right:
          delta = -details.primaryDelta!;
          break;
        default:
          throw UnimplementedError('Unresolved position');
      }
      // normalize delta
      var size = _key.currentContext?.size;
      if (size == null) {
        return;
      }
      double axisSize;
      if (resolvedPosition == VNLOverlayPosition.top ||
          resolvedPosition == VNLOverlayPosition.bottom) {
        axisSize = size.height;
      } else {
        axisSize = size.width;
      }
      delta = delta / axisSize;
      controller?.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_activeOverlay != null) {
      var activeOverlay = _activeOverlay!;
      var controller = activeOverlay.animationController;
      if (controller != null) {
        if (controller.value < 0.5) {
          controller.reverse().then((value) {
            activeOverlay.remove();
          });
        } else {
          controller.forward();
        }
      }
      _activeOverlay = null;
    }
  }

  void _onDragCancel() {
    if (_activeOverlay != null) {
      var activeOverlay = _activeOverlay!;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        var controller = activeOverlay.animationController;
        if (controller != null) {
          controller.reverse().then((value) {
            activeOverlay.remove();
          });
        }
      });
      _activeOverlay = null;
    }
  }

  void _onDragStart(DragStartDetails details) {
    _onDragCancel();
    final compTheme = VNLComponentTheme.maybeOf<VNLSwiperTheme>(context);
    _activeOverlay = widget.handler.openSwiper(
      context: context,
      builder: (context) {
        return KeyedSubtree(
          key: _key,
          child: widget.builder(context),
        );
      },
      position: widget.position,
      expands: widget.expands ?? compTheme?.expands,
      draggable: widget.draggable ?? compTheme?.draggable,
      barrierDismissible:
          widget.barrierDismissible ?? compTheme?.barrierDismissible,
      backdropBuilder: widget.backdropBuilder ?? compTheme?.backdropBuilder,
      useSafeArea: widget.useSafeArea ?? compTheme?.useSafeArea,
      showDragHandle: widget.showDragHandle ?? compTheme?.showDragHandle,
      borderRadius: widget.borderRadius ?? compTheme?.borderRadius,
      dragHandleSize: widget.dragHandleSize ?? compTheme?.dragHandleSize,
      transformBackdrop:
          widget.transformBackdrop ?? compTheme?.transformBackdrop,
      surfaceOpacity: widget.surfaceOpacity ?? compTheme?.surfaceOpacity,
      surfaceBlur: widget.surfaceBlur ?? compTheme?.surfaceBlur,
      barrierColor: widget.barrierColor ?? compTheme?.barrierColor,
    );
  }

  Widget _buildGesture({
    required Widget child,
    required bool draggable,
  }) {
    final compTheme = VNLComponentTheme.maybeOf<VNLSwiperTheme>(context);
    final behavior =
        widget.behavior ?? compTheme?.behavior ?? HitTestBehavior.translucent;
    if (widget.position == VNLOverlayPosition.top ||
        widget.position == VNLOverlayPosition.bottom) {
      return GestureDetector(
        behavior: behavior,
        onVerticalDragUpdate: draggable ? _onDrag : null,
        onVerticalDragEnd: draggable ? _onDragEnd : null,
        onVerticalDragStart: draggable ? _onDragStart : null,
        onVerticalDragCancel: _onDragCancel,
        child: child,
      );
    }
    return GestureDetector(
      behavior: behavior,
      onHorizontalDragUpdate: draggable ? _onDrag : null,
      onHorizontalDragEnd: draggable ? _onDragEnd : null,
      onHorizontalDragStart: draggable ? _onDragStart : null,
      onHorizontalDragCancel: _onDragCancel,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildGesture(
      child: widget.child,
      draggable: widget.enabled,
    );
  }
}
