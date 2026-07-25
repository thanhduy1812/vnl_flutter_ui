import 'package:vnl_common_ui/shadcn_flutter.dart';

/// A grid widget that displays a history of previously used colors.
///
/// [VNLColorHistoryGrid] presents colors from a [VNLColorHistoryStorage] in a grid
/// layout, allowing users to quickly reuse recently selected colors. The grid
/// can highlight the currently selected color and supports custom layouts.
///
/// Example:
/// ```dart
/// VNLColorHistoryGrid(
///   storage: myColorHistory,
///   onColorPicked: (color) {
///     print('Selected from history: $color');
///   },
///   crossAxisCount: 8,
/// )
/// ```
class VNLColorHistoryGrid extends StatelessWidget {
  /// The storage containing the color history.
  final VNLColorHistoryStorage storage;

  /// Called when a color from the history is picked.
  final ValueChanged<Color>? onColorPicked;

  /// Spacing between grid items.
  final double? spacing;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// The currently selected color to highlight.
  final Color? selectedColor;

  /// The amount of colors to display in the history.
  final int? maxTotalColors;

  /// Creates a [VNLColorHistoryGrid].
  const VNLColorHistoryGrid({
    super.key,
    required this.storage,
    this.onColorPicked,
    this.spacing,
    this.crossAxisCount = 10,
    this.selectedColor,
    this.maxTotalColors,
  });

  Widget _buildGridTile(BuildContext context, Color? color, ThemeData theme) {
    if (color == null) {
      return const AspectRatio(
        aspectRatio: 1,
        child: VNLButton(
          style: VNLButtonStyle.outline(
            density: VNLButtonDensity.compact,
          ),
          child: SizedBox.shrink(),
        ),
      );
    }
    return Container(
      decoration: selectedColor != null && color == selectedColor
          ? BoxDecoration(
              border: Border.all(
                  color: theme.colorScheme.primary, width: 2 * theme.scaling),
              borderRadius: BorderRadius.circular(theme.radiusMd),
            )
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: VNLButton(
          style: const VNLButtonStyle.outline(
            density: VNLButtonDensity.compact,
          ),
          onPressed: () {
            onColorPicked?.call(color);
          },
          child: Stack(
            children: [
              Positioned.fill(
                // readjust to prevent visual glitch
                top: selectedColor != null && color == selectedColor ? -2 : 0,
                left: selectedColor != null && color == selectedColor ? -2 : 0,
                child: ClipRRect(
                  borderRadius: theme.borderRadiusSm,
                  child: CustomPaint(
                    painter: AlphaPainter(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double spacing = this.spacing ?? (4 * theme.scaling);
    return ListenableBuilder(
        listenable: storage,
        builder: (context, child) {
          List<Widget> rows = [];
          for (int i = 0;
              i < storage.capacity &&
                  (maxTotalColors == null || i < maxTotalColors!);
              i += crossAxisCount) {
            List<Widget> tiles = [];
            for (int j = 0; j < crossAxisCount; j++) {
              final index = i + j;
              final color = index < storage.recentColors.length
                  ? storage.recentColors[index]
                  : null;
              if (index >= storage.capacity ||
                  (maxTotalColors != null && index >= maxTotalColors!)) {
                tiles.add(
                  const Expanded(
                    child: SizedBox(),
                  ),
                );
              } else {
                tiles.add(
                  Expanded(
                    child: SizedBox(
                      width: 32 * theme.scaling,
                      height: 32 * theme.scaling,
                      child: _buildGridTile(context, color, theme),
                    ),
                  ),
                );
              }
              if (j < crossAxisCount - 1) {
                tiles.add(Gap(spacing));
              }
            }
            rows.add(IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: tiles,
              ),
            ));
            if (i < storage.capacity - crossAxisCount) {
              rows.add(Gap(spacing));
            }
          }
          return IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rows,
            ),
          );
        }).constrained(
      minHeight: 100,
    );
  }
}

/// An abstract interface for storing and managing color history.
///
/// [VNLColorHistoryStorage] defines the contract for color history management,
/// including adding new colors, clearing history, and accessing recent colors.
/// Implementations should provide storage mechanisms (in-memory, persistent, etc.).
abstract class VNLColorHistoryStorage implements Listenable {
  /// Adds a color to the history.
  ///
  /// Parameters:
  /// - [color]: The color to add to the history.
  void addHistory(Color color);

  /// Replaces the entire color history with a new list.
  ///
  /// Parameters:
  /// - [colors]: The new list of colors to set as the history.
  void setHistory(List<Color> colors);

  /// Clears all colors from the history.
  void clear();

  /// The maximum number of colors that can be stored in the history.
  int get capacity;

  /// The list of recent colors, ordered from most to least recent.
  List<Color> get recentColors;

  /// Finds and listens the [VNLColorHistoryStorage] in the widget tree.
  static VNLColorHistoryStorage of(BuildContext context) {
    return Data.of<VNLColorHistoryStorage>(context);
  }

  /// Finds the [VNLColorHistoryStorage] in the widget tree.
  static VNLColorHistoryStorage find(BuildContext context) {
    return Data.maybeFind<VNLColorHistoryStorage>(context) ??
        Data.maybeFindMessenger<VNLColorHistoryStorage>(context) ??
        (throw FlutterError(
          'No VNLColorHistoryStorage found in context. Make sure to wrap your widget tree with a VNLRecentColorsScope.',
        ));
  }
}

/// Provides color history storage in the widget tree.
///
/// [VNLRecentColorsScope] manages a list of recently used colors and makes it
/// available to descendant widgets through [VNLColorHistoryStorage]. It supports
/// a configurable maximum capacity and notifies listeners of changes.
///
/// Example:
/// ```dart
/// VNLRecentColorsScope(
///   maxRecentColors: 20,
///   onRecentColorsChanged: (colors) {
///     // Save colors to persistent storage
///   },
///   child: MyColorPicker(),
/// )
/// ```
class VNLRecentColorsScope extends StatefulWidget {
  /// Initial colors to populate the history.
  final List<Color> initialRecentColors;

  /// Maximum number of colors to keep in the history.
  final int maxRecentColors;

  /// Called when the recent colors list changes.
  final ValueChanged<List<Color>>? onRecentColorsChanged;

  /// The child widget.
  final Widget child;

  /// Creates a [VNLRecentColorsScope].
  const VNLRecentColorsScope({
    super.key,
    this.initialRecentColors = const [],
    this.maxRecentColors = 50,
    this.onRecentColorsChanged,
    required this.child,
  });

  @override
  State<VNLRecentColorsScope> createState() => VNLRecentColorsScopeState();
}

class _ColorListNotifier extends ChangeNotifier {
  List<Color> _recentColors;

  _ColorListNotifier(this._recentColors);

  void _notify() {
    notifyListeners();
  }
}

/// State class for [VNLRecentColorsScope] implementing color history storage.
///
/// Manages the list of recently used colors and provides storage functionality
/// for color history tracking.
class VNLRecentColorsScopeState extends State<VNLRecentColorsScope>
    implements VNLColorHistoryStorage {
  late _ColorListNotifier _recentColors;

  @override
  int get capacity => widget.maxRecentColors;

  @override
  void initState() {
    super.initState();
    _recentColors = _ColorListNotifier(List.from(widget.initialRecentColors));
  }

  @override
  List<Color> get recentColors =>
      List.unmodifiable(_recentColors._recentColors);

  @override
  void addHistory(Color color) {
    var recentColors = _recentColors._recentColors;
    if (recentColors.contains(color)) {
      recentColors.remove(color);
    }
    recentColors.insert(0, color);
    if (recentColors.length > widget.maxRecentColors) {
      recentColors.removeLast();
    }
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  void dispose() {
    super.dispose();
    _recentColors.dispose();
  }

  @override
  void clear() {
    _recentColors._recentColors.clear();
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  void setHistory(List<Color> colors) {
    _recentColors._recentColors = colors;
    widget.onRecentColorsChanged?.call(recentColors);
    _recentColors._notify();
  }

  @override
  Widget build(BuildContext context) {
    return ForwardableData<VNLColorHistoryStorage>(
      data: this,
      child: Data<VNLColorHistoryStorage>.inherit(
        data: this,
        child: widget.child,
      ),
    );
  }

  @override
  void addListener(VoidCallback listener) {
    _recentColors.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _recentColors.removeListener(listener);
  }
}
