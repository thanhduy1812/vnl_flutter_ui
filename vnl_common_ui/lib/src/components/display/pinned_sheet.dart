import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Builder signature for pinned-sheet content.
typedef VNLPinnedSheetBuilder = Widget Function(BuildContext context);

/// Minimum leftover drag delta (logical px) worth forwarding to a parent sheet.
const double _kDragEpsilon = 0.01;

/// The context a [VNLSheetStage] resolves against: the sheet's content [size], the
/// resolved edge [position], and the container's [dragHandleExtent] (main-axis
/// pixels occupied by the drag handle, including its gaps; 0 when there is no
/// handle).
class VNLSheetStageResolution {
  /// The measured sheet content size.
  final Size size;

  /// The resolved edge position (never start/end).
  final VNLOverlayPosition position;

  /// The main-axis extent of the drag handle (+ gaps); 0 when there is none.
  final double dragHandleExtent;

  /// Creates a resolution context.
  const VNLSheetStageResolution({
    required this.size,
    required this.position,
    this.dragHandleExtent = 0,
  });

  /// The extent of the sheet along its drag axis.
  double get axisExtent {
    switch (position) {
      case VNLOverlayPosition.top:
      case VNLOverlayPosition.bottom:
        return size.height;
      default:
        return size.width;
    }
  }
}

double _fallbackBackdropTransform(VNLSheetStage stage, VNLSheetStageResolution res) {
  final axis = res.axisExtent;
  if (axis <= 0) return 0;
  return (stage.resolveDragOffset(res) / axis).clamp(0.0, 1.0);
}

/// A snap position for a [VNLPinnedSheet].
///
/// A stage resolves to a *visible extent* (logical pixels) along the sheet's
/// axis ([resolveDragOffset]) and, independently, to a *backdrop transform*
/// value in `0..1` ([resolveBackdropTransform]). When a stage's explicit
/// `backdropTransform` is null it falls back to the stage's normalized
/// expansion (offset / axis extent).
///
/// Stages support arithmetic so you can express derived snap points:
///
/// ```dart
/// VNLSheetStage.expanded() - VNLSheetStage.fixed(100); // 100px short of full
/// VNLSheetStage.expanded() * 0.9;                    // 90% of full
/// VNLSheetStage.fixed(100) + VNLSheetStage.fraction(0.5);
/// ```
///
/// Built-in stages: [VNLSheetStage.closed], [VNLSheetStage.expanded],
/// [VNLSheetStage.fixed], [VNLSheetStage.fraction], [VNLSheetStage.peekDragHandle].
abstract class VNLSheetStage {
  /// Const constructor for subclasses.
  const VNLSheetStage();

  /// A fully-hidden stage (offset 0).
  const factory VNLSheetStage.closed({double? backdropTransform}) =
      VNLClosedSheetStage;

  /// A fully-shown stage (offset == the full axis extent).
  const factory VNLSheetStage.expanded({double? backdropTransform}) =
      VNLExpandedSheetStage;

  /// A stage pinned at a fixed number of logical pixels from the edge.
  const factory VNLSheetStage.fixed(double offset, {double? backdropTransform}) =
      VNLFixedSheetStage;

  /// A stage pinned at a [fraction] (0..1) of the sheet's axis extent.
  const factory VNLSheetStage.fraction(double fraction,
      {double? backdropTransform}) = VNLFractionSheetStage;

  /// A stage that peeks only the drag handle. For containers without a drag
  /// handle the handle extent is 0, so this behaves like [VNLSheetStage.closed].
  const factory VNLSheetStage.peekDragHandle({double? backdropTransform}) =
      VNLPeekDragHandleSheetStage;

  /// The visible extent (logical pixels) this stage resolves to.
  double resolveDragOffset(VNLSheetStageResolution resolution);

  /// The backdrop transform value (0..1) this stage resolves to.
  double resolveBackdropTransform(VNLSheetStageResolution resolution);

  /// Sum of two stages (offsets and backdrop transforms are added).
  VNLSheetStage operator +(VNLSheetStage other) => VNLAdditiveSheetStage(this, other);

  /// Difference of two stages (offsets and backdrop transforms are subtracted).
  VNLSheetStage operator -(VNLSheetStage other) => VNLSubtractedSheetStage(this, other);

  /// Scales this stage's offset and backdrop transform by [factor].
  VNLSheetStage operator *(double factor) => VNLMultipliedSheetStage(this, factor);

  /// Divides this stage's offset and backdrop transform by [factor].
  VNLSheetStage operator /(double factor) => VNLDividedSheetStage(this, factor);

  @override
  bool operator ==(Object other) {
    // When compared against a live controller stage, borrow its attached state
    // to resolve this stage and compare the actual pixel offsets.
    if (other is _AttachedSheetStage) {
      return other == this;
    }
    return identical(this, other);
  }

  @override
  int get hashCode => identityHashCode(this);
}

/// A [VNLSheetStage] that is fully hidden.
class VNLClosedSheetStage extends VNLSheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates a closed stage.
  const VNLClosedSheetStage({this.backdropTransform});

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) => 0;

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// A [VNLSheetStage] that is fully expanded.
class VNLExpandedSheetStage extends VNLSheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates an expanded stage.
  const VNLExpandedSheetStage({this.backdropTransform});

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      resolution.axisExtent;

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// A [VNLSheetStage] pinned at a fixed number of logical pixels.
class VNLFixedSheetStage extends VNLSheetStage {
  /// The pixel offset from the closed edge.
  final double offset;

  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates a fixed-offset stage.
  const VNLFixedSheetStage(this.offset, {this.backdropTransform});

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      min(offset, resolution.axisExtent);

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// A [VNLSheetStage] pinned at a fraction of the sheet's axis extent.
class VNLFractionSheetStage extends VNLSheetStage {
  /// The fraction (0..1) of the axis extent.
  final double fraction;

  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates a fractional stage.
  const VNLFractionSheetStage(this.fraction, {this.backdropTransform});

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      resolution.axisExtent * fraction;

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// A [VNLSheetStage] that peeks only the drag handle.
class VNLPeekDragHandleSheetStage extends VNLSheetStage {
  /// Explicit backdrop transform for this stage; null falls back to expansion.
  final double? backdropTransform;

  /// Creates a peek-drag-handle stage.
  const VNLPeekDragHandleSheetStage({this.backdropTransform});

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      resolution.dragHandleExtent;

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      backdropTransform ?? _fallbackBackdropTransform(this, resolution);
}

/// Sum of two stages.
class VNLAdditiveSheetStage extends VNLSheetStage {
  /// The left operand.
  final VNLSheetStage a;

  /// The right operand.
  final VNLSheetStage b;

  /// Creates an additive stage.
  const VNLAdditiveSheetStage(this.a, this.b);

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      a.resolveDragOffset(resolution) + b.resolveDragOffset(resolution);

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      a.resolveBackdropTransform(resolution) +
      b.resolveBackdropTransform(resolution);
}

/// Difference of two stages.
class VNLSubtractedSheetStage extends VNLSheetStage {
  /// The left operand.
  final VNLSheetStage a;

  /// The right operand.
  final VNLSheetStage b;

  /// Creates a subtracted stage.
  const VNLSubtractedSheetStage(this.a, this.b);

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      a.resolveDragOffset(resolution) - b.resolveDragOffset(resolution);

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      a.resolveBackdropTransform(resolution) -
      b.resolveBackdropTransform(resolution);
}

/// A stage scaled by a scalar [factor].
class VNLMultipliedSheetStage extends VNLSheetStage {
  /// The operand.
  final VNLSheetStage stage;

  /// The scalar factor.
  final double factor;

  /// Creates a multiplied stage.
  const VNLMultipliedSheetStage(this.stage, this.factor);

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      stage.resolveDragOffset(resolution) * factor;

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      stage.resolveBackdropTransform(resolution) * factor;
}

/// A stage divided by a scalar [factor].
class VNLDividedSheetStage extends VNLSheetStage {
  /// The operand.
  final VNLSheetStage stage;

  /// The scalar divisor.
  final double factor;

  /// Creates a divided stage.
  const VNLDividedSheetStage(this.stage, this.factor);

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      stage.resolveDragOffset(resolution) / factor;

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      stage.resolveBackdropTransform(resolution) / factor;
}

/// A live stage bound to a [VNLPinnedSheet]'s state, returned by
/// [VNLSheetController.stage]. Comparing it to another [VNLSheetStage] resolves both
/// against the sheet's current geometry and compares the pixel offsets, so
/// `controller.stage == (VNLSheetStage.expanded() - VNLSheetStage.fixed(100))` works.
class _AttachedSheetStage extends VNLSheetStage {
  final _PinnedSheetState _state;

  const _AttachedSheetStage(this._state);

  @override
  double resolveDragOffset(VNLSheetStageResolution resolution) =>
      _state.currentOffset;

  @override
  double resolveBackdropTransform(VNLSheetStageResolution resolution) =>
      _state.currentBackdropTransform;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is _AttachedSheetStage) {
      return identical(_state, other._state);
    }
    if (other is VNLSheetStage) {
      final resolution = _state.resolution;
      final current = _state.currentOffset;
      final target = other.resolveDragOffset(resolution);
      return (current - target).abs() < 0.5;
    }
    return false;
  }

  @override
  int get hashCode => identityHashCode(_state);
}

/// Controls a [VNLPinnedSheet]: reads its current position and drives it to a
/// [VNLSheetStage].
///
/// The controller is a [ChangeNotifier] that notifies whenever the sheet's
/// position changes. [stage] returns a live stage that can be compared against
/// derived stages:
///
/// ```dart
/// final controller = VNLSheetController();
/// ...
/// VNLPinnedSheet(controller: controller, child: ...);
/// ...
/// controller.stage = VNLSheetStage.expanded();
/// controller.animateTo(VNLSheetStage.fixed(120),
///     duration: kDefaultDuration, curve: Curves.easeOut);
/// if (controller.stage == (VNLSheetStage.expanded() - VNLSheetStage.fixed(100))) { ... }
/// ```
class VNLSheetController extends ChangeNotifier {
  _PinnedSheetState? _state;

  /// Whether this controller is attached to a live [VNLPinnedSheet].
  bool get isAttached => _state != null;

  void _attach(_PinnedSheetState state) {
    _state = state;
    notifyListeners();
  }

  void _detach(_PinnedSheetState state) {
    if (identical(_state, state)) {
      _state = null;
    }
  }

  void _notify() => notifyListeners();

  /// The current visible extent of the sheet, in logical pixels.
  double get offset => _state?.currentOffset ?? 0.0;

  /// The current visible extent of the sheet, as a fraction (0..1) of its axis.
  double get fraction => _state?.currentFraction ?? 0.0;

  /// Whether the sheet is showing at all.
  bool get isOpen => fraction > 0;

  /// The current position as a live stage that can be compared against other
  /// (possibly derived) stages using `==`.
  VNLSheetStage get stage =>
      _state != null ? _AttachedSheetStage(_state!) : const VNLSheetStage.closed();

  /// Assigning a stage animates the sheet to it with the default duration/curve.
  set stage(VNLSheetStage stage) {
    animateTo(stage);
  }

  /// Animates the sheet to [stage].
  Future<void> animateTo(
    VNLSheetStage stage, {
    Duration duration = kDefaultDuration,
    Curve curve = Curves.linear,
  }) {
    final state = _state;
    if (state == null) return Future<void>.value();
    return state.animateToStage(stage, duration: duration, curve: curve);
  }

  /// Immediately jumps the sheet to [stage] with no animation.
  void jumpTo(VNLSheetStage stage) {
    _state?.jumpToStage(stage);
  }

  /// Animates the sheet fully open ([VNLSheetStage.expanded]).
  Future<void> open({
    Duration duration = kDefaultDuration,
    Curve curve = Curves.easeOut,
  }) =>
      animateTo(const VNLSheetStage.expanded(), duration: duration, curve: curve);

  /// Animates the sheet fully closed ([VNLSheetStage.closed]).
  Future<void> close({
    Duration duration = kDefaultDuration,
    Curve curve = Curves.easeOut,
  }) =>
      animateTo(const VNLSheetStage.closed(), duration: duration, curve: curve);
}

/// A controller-driven, gesture-driven sheet that snaps between [VNLSheetStage]s.
///
/// A [VNLPinnedSheet] is placed directly in the widget tree and controlled by a
/// [VNLSheetController]. It slides in from [position], can be dragged, and snaps to
/// the nearest configured [stages] on release. When [backdropTransform] is
/// non-null and a [backdrop] is provided, the backdrop is transformed as the
/// sheet opens; the transform's progress is interpolated from each stage's
/// `backdropTransform`. Nested [VNLPinnedSheet]s (a sheet inside another sheet's
/// [backdrop]) adjust their layout to hug the transformed backdrop.
///
/// The [child] is given loose constraints up to the region size (min 0), so a
/// `SizedBox.expand` child fills the whole backdrop while a content-sized child
/// shrink-wraps. The caller wraps [child] in a [VNLDrawerContainer] or
/// [VNLSheetContainer] to pick the chrome.
class VNLPinnedSheet extends StatefulWidget {
  /// The sheet content (typically wrapped in a [VNLDrawerContainer]/[VNLSheetContainer]).
  final Widget child;

  /// The edge the sheet is anchored to.
  final VNLOverlayPosition position;

  /// The controller driving this sheet.
  final VNLSheetController? controller;

  /// The snap stages. Defaults to `[VNLSheetStage.closed(), VNLSheetStage.expanded()]`.
  final List<VNLSheetStage> stages;

  /// The stage the sheet rests at initially. Defaults to the first stage.
  final VNLSheetStage? initialStage;

  /// The content shown behind the sheet, transformed by [backdropTransform].
  final Widget? backdrop;

  /// The backdrop transform. When null, the backdrop is not transformed.
  final VNLBackdropTransform? backdropTransform;

  /// Whether the sheet can be dragged.
  final bool draggable;

  /// Whether dragging the [backdrop] also drives this sheet (so a closed sheet
  /// can be pulled open from its backdrop area). Taps still pass through to
  /// backdrop content; only drags are captured.
  final bool draggableBackdrop;

  /// Whether the drag handle is shown.
  final bool showDragHandle;

  /// Whether the sheet expands along the cross axis.
  final bool expands;

  /// Whether a modal barrier is drawn behind the sheet.
  final bool modal;

  /// Whether tapping the barrier closes the sheet (to [VNLSheetStage.closed]).
  final bool barrierDismissible;

  /// The barrier color.
  final Color? barrierColor;

  /// Corner radius override (provided to the container via [VNLDrawerContainerData]).
  final BorderRadiusGeometry? borderRadius;

  /// Drag handle size override.
  final Size? dragHandleSize;

  /// Surface opacity for the container background.
  final double? surfaceOpacity;

  /// Surface blur for the container background.
  final double? surfaceBlur;

  /// Size constraints for the sheet content.
  final BoxConstraints? constraints;

  /// The default animation duration for open/close/snapping.
  final Duration duration;

  /// Creates a pinned sheet.
  const VNLPinnedSheet({
    super.key,
    this.position = VNLOverlayPosition.bottom,
    required this.child,
    this.controller,
    this.stages = const [VNLSheetStage.closed(), VNLSheetStage.expanded()],
    this.initialStage,
    this.backdrop,
    this.backdropTransform,
    this.draggable = true,
    this.draggableBackdrop = false,
    this.showDragHandle = true,
    this.expands = true,
    this.modal = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.borderRadius,
    this.dragHandleSize,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.constraints,
    this.duration = const Duration(milliseconds: 350),
  });

  @override
  State<VNLPinnedSheet> createState() => _PinnedSheetState();
}

class _PinnedSheetState extends State<VNLPinnedSheet>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late ControlledAnimation _anim;
  late AnimationController _overscrollController;
  late ControlledAnimation _overscroll;

  final GlobalKey _contentKey = GlobalKey();

  Size _lastAvailableSize = Size.zero;

  /// The parent sheet this sheet is nested inside (its backdrop), used to hand
  /// off overscroll when a drag runs past this sheet's own range.
  _PinnedSheetState? _parentSheet;

  /// Whether a drag is currently in progress (so config changes don't re-snap
  /// the sheet mid-drag).
  bool _dragging = false;

  VNLBackdropTransform get _effectiveTransform =>
      widget.backdropTransform ?? VNLBackdropTransform.none;

  List<VNLSheetStage> get effectiveStages =>
      widget.stages.isEmpty ? const [VNLSheetStage.closed()] : widget.stages;

  @override
  void initState() {
    super.initState();
    _slideController =
        AnimationController(vsync: this, duration: widget.duration);
    _anim = ControlledAnimation(_slideController);
    _overscrollController =
        AnimationController(vsync: this, duration: widget.duration);
    _overscroll = ControlledAnimation(_overscrollController);
    final initial = widget.initialStage ?? effectiveStages.first;
    _anim.addListener(_onAnimTick);
    widget.controller?._attach(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) jumpToStage(initial);
    });
  }

  @override
  void didUpdateWidget(covariant VNLPinnedSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._detach(this);
      widget.controller?._attach(this);
    }
    if (widget.duration != oldWidget.duration) {
      _slideController.duration = widget.duration;
      _overscrollController.duration = widget.duration;
    }
    // When the stage set changes (e.g. edited on hot reload), re-settle onto the
    // nearest new stage so the sheet isn't stranded at an old stage's position.
    final oldStages = oldWidget.stages;
    final newStages = widget.stages;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _dragging || _slideController.isAnimating) return;
      final res = resolution;
      final axis = res.axisExtent;
      if (axis <= 0) return;
      double norm(VNLSheetStage s) =>
          (s.resolveDragOffset(res) / axis).clamp(0.0, 1.0);
      final oldNorms = oldStages.map(norm).toList()..sort();
      final newNorms = newStages.map(norm).toList()..sort();
      var changed = oldNorms.length != newNorms.length;
      for (var i = 0; !changed && i < newNorms.length; i++) {
        changed = (oldNorms[i] - newNorms[i]).abs() > 0.001;
      }
      if (changed) {
        final stages = effectiveStages;
        if (stages.isNotEmpty) {
          jumpToStage(stages[_nearestStageIndex(_anim.value)]);
        }
      }
    });
  }

  @override
  void dispose() {
    _anim.removeListener(_onAnimTick);
    widget.controller?._detach(this);
    _slideController.dispose();
    _overscrollController.dispose();
    super.dispose();
  }

  void _onAnimTick() {
    widget.controller?._notify();
  }

  VNLOverlayPosition get resolvedPosition =>
      _resolvePosition(widget.position, Directionality.of(context));

  static VNLOverlayPosition _resolvePosition(
      VNLOverlayPosition position, TextDirection direction) {
    if (position == VNLOverlayPosition.start) {
      return direction == TextDirection.ltr
          ? VNLOverlayPosition.left
          : VNLOverlayPosition.right;
    }
    if (position == VNLOverlayPosition.end) {
      return direction == TextDirection.ltr
          ? VNLOverlayPosition.right
          : VNLOverlayPosition.left;
    }
    return position;
  }

  Size get _contentSize {
    final renderBox = _contentKey.currentContext?.findRenderObject();
    if (renderBox is RenderBox && renderBox.hasSize) {
      return renderBox.size;
    }
    return _lastAvailableSize;
  }

  /// Whether the child ([VNLDrawerContainer]/[VNLSheetContainer]) requests
  /// visible-extent sizing.
  bool get _childExpands {
    final c = widget.child;
    if (c is VNLDrawerContainer) return c.expands;
    if (c is VNLSheetContainer) return c.expands;
    return false;
  }

  bool get _childIntrinsic {
    final c = widget.child;
    if (c is VNLDrawerContainer) return c.intrinsic;
    if (c is VNLSheetContainer) return c.intrinsic;
    return true;
  }

  /// In expands mode the sheet is measured against the full region (its fully
  /// open extent is the backdrop size); otherwise against the measured child.
  Size get _effectiveContentSize =>
      _childExpands ? _lastAvailableSize : _contentSize;

  /// Main-axis extent (including gaps) of the drag handle, or 0 when hidden.
  double get _dragHandleExtent {
    if (!widget.showDragHandle) return 0;
    final theme = Theme.of(context);
    final densityGap = theme.density.baseGap * theme.scaling;
    final isVertical = resolvedPosition == VNLOverlayPosition.top ||
        resolvedPosition == VNLOverlayPosition.bottom;
    final handleMain = isVertical
        ? (widget.dragHandleSize?.height ?? densityGap * 0.75)
        : (widget.dragHandleSize?.width ?? densityGap * 0.75);
    // Matches VNLDrawerRawContainer's default gaps.
    final gapBefore = densityGap * 1.5;
    final gapAfter = densityGap * 2;
    return handleMain + gapBefore + gapAfter;
  }

  /// The resolution context describing the current sheet geometry.
  VNLSheetStageResolution get resolution => VNLSheetStageResolution(
        size: _effectiveContentSize,
        position: resolvedPosition,
        dragHandleExtent: _dragHandleExtent,
      );

  double get _axis => max(1.0, resolution.axisExtent);

  double get currentFraction => _anim.value.clamp(0.0, 1.0);

  double get currentOffset => currentFraction * _axis;

  /// The current backdrop transform value, interpolated piecewise between the
  /// stages' backdrop transforms by the current pixel offset.
  double get currentBackdropTransform {
    final res = resolution;
    final axis = res.axisExtent;
    if (axis <= 0) return currentFraction;
    final current = currentOffset;
    final knots = <MapEntry<double, double>>[
      for (final stage in effectiveStages)
        MapEntry(
          stage.resolveDragOffset(res).clamp(0.0, axis),
          stage.resolveBackdropTransform(res).clamp(0.0, 1.0),
        ),
    ]..sort((a, b) => a.key.compareTo(b.key));
    if (knots.isEmpty) return currentFraction;
    if (current <= knots.first.key) return knots.first.value;
    if (current >= knots.last.key) return knots.last.value;
    for (var i = 0; i < knots.length - 1; i++) {
      final a = knots[i];
      final b = knots[i + 1];
      if (current >= a.key && current <= b.key) {
        final range = b.key - a.key;
        if (range <= 0) return a.value;
        final f = (current - a.key) / range;
        return a.value + (b.value - a.value) * f;
      }
    }
    return knots.last.value;
  }

  double _normalizedFor(VNLSheetStage stage) {
    final res = resolution;
    final axis = res.axisExtent;
    if (axis <= 0) return 0.0;
    return (stage.resolveDragOffset(res) / axis).clamp(0.0, 1.0);
  }

  Future<void> animateToStage(
    VNLSheetStage stage, {
    Duration duration = kDefaultDuration,
    Curve curve = Curves.linear,
  }) {
    _slideController.duration = duration;
    final target = _normalizedFor(stage);
    return _anim.forward(target, curve).orCancel.catchError((_) {});
  }

  void jumpToStage(VNLSheetStage stage) {
    _anim.value = _normalizedFor(stage);
    widget.controller?._notify();
    if (mounted) setState(() {});
  }

  int _nearestStageIndex(double value) {
    final stages = effectiveStages;
    int best = 0;
    double bestDist = double.infinity;
    for (int i = 0; i < stages.length; i++) {
      final dist = (value - _normalizedFor(stages[i])).abs();
      if (dist < bestDist) {
        bestDist = dist;
        best = i;
      }
    }
    return best;
  }

  double get _dragSign {
    // Positive primaryDelta should open the sheet.
    switch (resolvedPosition) {
      case VNLOverlayPosition.left:
      case VNLOverlayPosition.top:
        return 1;
      default:
        return -1;
    }
  }

  /// Applies a raw [primaryDelta] to this sheet, clamped to its `[0, 1]` range,
  /// and returns the unconsumed leftover [primaryDelta] (0 when fully consumed).
  double _applyDrag(double primaryDelta) {
    final axis = _axis;
    final increment = _dragSign * primaryDelta / axis;
    final oldValue = _anim.value;
    final newValue = (oldValue + increment).clamp(0.0, 1.0);
    _anim.value = newValue;
    widget.controller?._notify();
    final leftoverIncrement = increment - (newValue - oldValue);
    return leftoverIncrement * axis / _dragSign;
  }

  void _applyOverscroll(double leftover) {
    _overscroll.value += _dragSign * leftover / max(_overscroll.value, 1);
  }

  /// This sheet plus its ancestor sheets, innermost (child) first.
  List<_PinnedSheetState> _dragChain() {
    final chain = <_PinnedSheetState>[];
    _PinnedSheetState? node = this;
    while (node != null) {
      chain.add(node);
      node = node._parentSheet;
    }
    return chain;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta!;
    final chain = _dragChain();
    // Opening fills child -> parent; closing unwinds parent -> child, so a
    // reversed drag pulls the (engaged) outer sheet back before the inner one.
    final opening = _dragSign * delta > 0;
    double remaining = delta;
    if (opening) {
      for (final sheet in chain) {
        remaining = sheet._applyDrag(remaining);
        if (remaining.abs() <= _kDragEpsilon) break;
      }
      if (remaining.abs() > _kDragEpsilon) {
        chain.last._applyOverscroll(remaining);
      }
    } else {
      for (final sheet in chain.reversed) {
        remaining = sheet._applyDrag(remaining);
        if (remaining.abs() <= _kDragEpsilon) break;
      }
    }
    if (mounted) setState(() {});
  }

  void _snapToNearest() {
    _overscroll.forward(0, Curves.easeOut);
    final index = _nearestStageIndex(_anim.value);
    animateToStage(effectiveStages[index],
        duration: widget.duration, curve: Curves.easeOut);
  }

  void _onDragStart(DragStartDetails details) {
    _dragging = true;
  }

  void _onDragEnd(DragEndDetails details) {
    _dragging = false;
    for (final sheet in _dragChain()) {
      sheet._snapToNearest();
    }
  }

  void _onDragCancel() {
    _dragging = false;
    _snapToNearest();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _lastAvailableSize = constraints.biggest;
        final resolved = resolvedPosition;
        final transform = _effectiveTransform;

        final existing = Data.maybeOf<VNLBackdropTransformData>(context);
        // Depth in a stack of nested PinnedSheets. 0 is the outermost sheet;
        // sheets placed inside another sheet's backdrop get a higher index,
        // which weakens their barrier and surface treatment (matching drawers).
        final stackData = Data.maybeOf<_PinnedSheetStackData>(context);
        final stackIndex = stackData?.stackIndex ?? 0;
        _parentSheet = stackData?.parent;
        final children = <Widget>[];

        // 1. Backdrop layer (transformed + propagates freed size to descendants).
        if (widget.backdrop != null) {
          Widget backdropContent = widget.backdrop!;
          if (widget.draggable && widget.draggableBackdrop) {
            backdropContent = _wrapGesture(resolved, backdropContent);
          }
          children.add(Positioned.fill(
            child: AnimatedBuilder(
              animation: _anim,
              builder: (context, child) {
                final t = currentBackdropTransform.clamp(0.0, 1.0);
                final size = constraints.biggest;
                var extra = transform.resolveExtraSize(size, t,
                    isRoot: existing == null);
                if (existing != null) {
                  extra = Size(
                    extra.width +
                        existing.sizeDifference.width / kBackdropScaleDown,
                    extra.height +
                        existing.sizeDifference.height / kBackdropScaleDown,
                  );
                }
                return Data.inherit(
                  data: VNLBackdropTransformData(extra),
                  child: Data.inherit(
                    data: _PinnedSheetStackData(stackIndex + 1, this),
                    child: transform.wrapBackdrop(context, child!, t,
                        isRoot: existing == null),
                  ),
                );
              },
              child: backdropContent,
            ),
          ));
        }

        // 2. Modal barrier (transparent tap target; the visual dim is painted
        // by the container's VNLModalBackdrop via the fade animation).
        if (widget.modal) {
          children.add(Positioned.fill(
            child: AnimatedBuilder(
              animation: _anim,
              builder: (context, child) {
                return IgnorePointer(
                  ignoring: _anim.value <= 0,
                  child: child,
                );
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: widget.barrierDismissible
                    ? () => animateToStage(const VNLSheetStage.closed(),
                        duration: widget.duration, curve: Curves.easeOut)
                    : null,
              ),
            ),
          ));
        }

        // 3. The sheet content: slide + backdrop-hug offset + container + drag.
        children.add(Positioned.fill(
          child: _buildSheet(context, resolved, existing, stackIndex),
        ));

        return Stack(
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          children: children,
        );
      },
    );
  }

  Widget _buildSheet(BuildContext context, VNLOverlayPosition resolved,
      VNLBackdropTransformData? existing, int stackIndex) {
    AlignmentGeometry alignment;
    Offset startFractionalOffset;
    switch (resolved) {
      case VNLOverlayPosition.left:
        alignment = Alignment.centerLeft;
        startFractionalOffset = const Offset(-1, 0);
        break;
      case VNLOverlayPosition.right:
        alignment = Alignment.centerRight;
        startFractionalOffset = const Offset(1, 0);
        break;
      case VNLOverlayPosition.top:
        alignment = Alignment.topCenter;
        startFractionalOffset = const Offset(0, -1);
        break;
      case VNLOverlayPosition.bottom:
        alignment = Alignment.bottomCenter;
        startFractionalOffset = const Offset(0, 1);
        break;
      default:
        throw UnimplementedError('Unknown position');
    }

    // Layout adjustment from the parent sheet's backdrop transform (nesting).
    Size additionalSize = Size.zero;
    Offset additionalOffset = Offset.zero;
    final extraSize = existing?.sizeDifference;
    if (extraSize != null) {
      switch (resolved) {
        case VNLOverlayPosition.left:
          additionalSize = Size(extraSize.width / 2, 0);
          additionalOffset = Offset(-additionalSize.width, 0);
          break;
        case VNLOverlayPosition.right:
          additionalSize = Size(extraSize.width / 2, 0);
          additionalOffset = Offset(additionalSize.width, 0);
          break;
        case VNLOverlayPosition.top:
          additionalSize = Size(0, extraSize.height / 2);
          additionalOffset = Offset(0, -additionalSize.height);
          break;
        case VNLOverlayPosition.bottom:
          additionalSize = Size(0, extraSize.height / 2);
          additionalOffset = Offset(0, additionalSize.height);
          break;
        default:
          break;
      }
    }

    return Align(
      alignment: alignment,
      child: AnimatedBuilder(
        animation: Listenable.merge([_anim, _overscroll]),
        builder: (context, child) {
          // VNLPinnedSheet only provides the container configuration; the caller
          // decides whether their [child] is wrapped in a [VNLDrawerContainer] or
          // a [VNLSheetContainer] to select the chrome.
          final data = VNLDrawerContainerData(
            position: resolved,
            size: _contentSize,
            stackIndex: stackIndex,
            expands: widget.expands,
            draggable: widget.draggable,
            showDragHandle: widget.showDragHandle,
            dragHandleSize: widget.dragHandleSize,
            borderRadius: widget.borderRadius,
            surfaceOpacity: widget.surfaceOpacity,
            surfaceBlur: widget.surfaceBlur,
            barrierColor: widget.barrierColor,
            constraints: widget.constraints,
            fadeAnimation: widget.modal ? _anim : null,
            extraSize: additionalSize,
            overscroll: _overscroll.value,
          );

          Widget container = Data.inherit(
            data: data,
            child: KeyedSubtree(key: _contentKey, child: widget.child),
          );

          // Attach the drag gesture to the content *before* translating/sizing,
          // so a closed sheet's hit area collapses with it instead of parking
          // over whatever is behind (e.g. a nested sheet's content).
          if (widget.draggable) {
            container = _wrapGesture(resolved, container);
          }

          container = Transform.translate(
            offset: additionalOffset / kBackdropScaleDown,
            child: container,
          );

          if (_childExpands) {
            // Size the sheet to the visible extent instead of sliding it.
            container = _SheetRevealBox(
              visibleExtent: currentOffset,
              maxExtent: _axis,
              intrinsic: _childIntrinsic,
              position: resolved,
              child: container,
            );
          } else {
            container = FractionalTranslation(
              translation:
                  startFractionalOffset * (1 - _anim.value.clamp(0.0, 1.0)),
              child: container,
            );
          }

          return container;
        },
      ),
    );
  }

  Widget _wrapGesture(VNLOverlayPosition resolved, Widget child) {
    final isVertical =
        resolved == VNLOverlayPosition.top || resolved == VNLOverlayPosition.bottom;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: isVertical ? _onDragStart : null,
      onVerticalDragUpdate: isVertical ? _onDragUpdate : null,
      onVerticalDragEnd: isVertical ? _onDragEnd : null,
      onVerticalDragCancel: isVertical ? _onDragCancel : null,
      onHorizontalDragStart: isVertical ? null : _onDragStart,
      onHorizontalDragUpdate: isVertical ? null : _onDragUpdate,
      onHorizontalDragEnd: isVertical ? null : _onDragEnd,
      onHorizontalDragCancel: isVertical ? null : _onDragCancel,
      child: child,
    );
  }
}

/// Marker carrying the nesting depth of a [VNLPinnedSheet] and a reference to it,
/// provided to descendants placed inside its backdrop (used for drag chaining).
class _PinnedSheetStackData {
  final int stackIndex;
  final _PinnedSheetState? parent;
  _PinnedSheetStackData(this.stackIndex, this.parent);
}

/// Sizes its [child] along the main axis to [visibleExtent] (clamped to
/// [maxExtent]) so the sheet grows/shrinks with its value instead of sliding.
///
/// The child is laid out at least at its own intrinsic main-axis size when
/// [intrinsic] is true (so its content never overflows), anchored to the
/// reveal edge, and clipped to the visible box.
class _SheetRevealBox extends SingleChildRenderObjectWidget {
  final double visibleExtent;
  final double maxExtent;
  final bool intrinsic;
  final VNLOverlayPosition position;

  const _SheetRevealBox({
    required this.visibleExtent,
    required this.maxExtent,
    required this.intrinsic,
    required this.position,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSheetRevealBox(
      visibleExtent: visibleExtent,
      maxExtent: maxExtent,
      intrinsic: intrinsic,
      position: position,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSheetRevealBox renderObject) {
    renderObject
      ..visibleExtent = visibleExtent
      ..maxExtent = maxExtent
      ..intrinsic = intrinsic
      ..position = position;
  }
}

class _RenderSheetRevealBox extends RenderShiftedBox {
  _RenderSheetRevealBox({
    required double visibleExtent,
    required double maxExtent,
    required bool intrinsic,
    required VNLOverlayPosition position,
  })  : _visibleExtent = visibleExtent,
        _maxExtent = maxExtent,
        _intrinsic = intrinsic,
        _position = position,
        super(null);

  double _visibleExtent;
  set visibleExtent(double value) {
    if (_visibleExtent == value) return;
    _visibleExtent = value;
    markNeedsLayout();
  }

  double _maxExtent;
  set maxExtent(double value) {
    if (_maxExtent == value) return;
    _maxExtent = value;
    markNeedsLayout();
  }

  bool _intrinsic;
  set intrinsic(bool value) {
    if (_intrinsic == value) return;
    _intrinsic = value;
    markNeedsLayout();
  }

  VNLOverlayPosition _position;
  set position(VNLOverlayPosition value) {
    if (_position == value) return;
    _position = value;
    markNeedsLayout();
  }

  bool get _vertical =>
      _position == VNLOverlayPosition.top || _position == VNLOverlayPosition.bottom;

  @override
  void performLayout() {
    final child = this.child;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    final cross = _vertical ? constraints.maxWidth : constraints.maxHeight;
    final maxMain = _maxExtent.isFinite && _maxExtent > 0
        ? _maxExtent
        : (_vertical ? constraints.maxHeight : constraints.maxWidth);

    // The intrinsic floor is the child's natural content size (flex children
    // like Spacer count as 0), NOT its size under a loose layout — otherwise a
    // MainAxisSize.max child would report the whole region as its intrinsic and
    // the content would never shrink.
    double floor = 0;
    if (_intrinsic) {
      floor = (_vertical
              ? child.getMaxIntrinsicHeight(cross)
              : child.getMaxIntrinsicWidth(cross))
          .clamp(0.0, maxMain);
    }

    // Phase 1 (visible >= floor): child fills the box exactly, so a
    // MainAxisSize.max child keeps e.g. a bottom-aligned button visible. Phase 2
    // (visible < floor): child stays at its intrinsic size, anchored to the
    // reveal edge, so its far end slides past the edge as the box shrinks.
    final childMain = _visibleExtent.clamp(floor, maxMain);
    child.layout(
      _vertical
          ? BoxConstraints.tightFor(width: cross, height: childMain)
          : BoxConstraints.tightFor(width: childMain, height: cross),
      parentUsesSize: true,
    );

    final boxMain = _visibleExtent.clamp(0.0, maxMain);
    size = _vertical ? Size(cross, boxMain) : Size(boxMain, cross);

    // Anchor the child to the reveal edge (the leading edge that advances into
    // view); the overflow hangs off the far edge and is clipped.
    Offset childOffset;
    switch (_position) {
      case VNLOverlayPosition.top:
        childOffset = Offset(0, boxMain - childMain);
        break;
      case VNLOverlayPosition.left:
        childOffset = Offset(boxMain - childMain, 0);
        break;
      default: // bottom / right
        childOffset = Offset.zero;
    }
    (child.parentData as BoxParentData).offset = childOffset;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null) return;
    final childOffset = (child.parentData as BoxParentData).offset;
    context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      (ctx, off) => ctx.paintChild(child, off + childOffset),
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // Restrict hits to the visible box so a collapsed sheet doesn't intercept
    // pointers meant for the content behind it.
    if (!(Offset.zero & size).contains(position)) return false;
    return super.hitTest(result, position: position);
  }
}
