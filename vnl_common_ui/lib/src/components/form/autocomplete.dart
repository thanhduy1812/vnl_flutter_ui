import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class AutoComplete extends StatefulWidget {
  final List<String> suggestions;
  final Widget child;
  final BoxConstraints? popoverConstraints;
  final PopoverConstraint? popoverWidthConstraint;
  final AlignmentDirectional? popoverAnchorAlignment;
  final AlignmentDirectional? popoverAlignment;
  final AutoCompleteMode mode;
  const AutoComplete({
    super.key,
    required this.suggestions,
    required this.child,
    this.popoverConstraints,
    this.popoverWidthConstraint,
    this.popoverAnchorAlignment,
    this.popoverAlignment,
    this.mode = AutoCompleteMode.replaceWord,
  });

  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteItem extends StatefulWidget {
  final String suggestion;
  final bool selected;
  final VoidCallback onSelected;

  const _AutoCompleteItem({required this.suggestion, required this.selected, required this.onSelected});

  @override
  State<_AutoCompleteItem> createState() => _AutoCompleteItemState();
}

class _AutoCompleteItemState extends State<_AutoCompleteItem> {
  @override
  Widget build(BuildContext context) {
    return SelectedButton(
      value: widget.selected,
      alignment: AlignmentDirectional.centerStart,
      onChanged: (value) {
        if (value) {
          widget.onSelected();
        }
      },
      child: Text(widget.suggestion),
    );
  }

  @override
  void didUpdateWidget(covariant _AutoCompleteItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (!mounted) {
          return;
        }
        if (widget.selected) {
          Scrollable.ensureVisible(context);
        }
      });
    }
  }
}

class _AutoCompleteState extends State<AutoComplete> {
  final ValueNotifier<List<String>> _suggestions = ValueNotifier([]);
  final ValueNotifier<int> _selectedIndex = ValueNotifier(-1);
  final PopoverController _popoverController = PopoverController();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _suggestions.addListener(_onSuggestionsChanged);
    if (widget.suggestions.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _suggestions.value = widget.suggestions;
        _selectedIndex.value = widget.suggestions.isEmpty ? -1 : 0;
      });
    }
  }

  void _onSuggestionsChanged() {
    if ((_suggestions.value.isEmpty && _popoverController.hasOpenPopover) || !_isFocused) {
      _popoverController.close();
    } else if (!_popoverController.hasOpenPopover && _suggestions.value.isNotEmpty) {
      _selectedIndex.value = -1;
      _popoverController.show(
        context: context,
        handler: const PopoverOverlayHandler(),
        builder: (context) {
          final theme = Theme.of(context);
          return TextFieldTapRegion(
            child: ConstrainedBox(
              constraints: widget.popoverConstraints ?? BoxConstraints(maxHeight: 300 * theme.scaling),
              child: SurfaceCard(
                padding: const EdgeInsets.all(4) * theme.scaling,
                child: AnimatedBuilder(
                  animation: Listenable.merge([_suggestions, _selectedIndex]),
                  builder: (context, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.value.length,
                      itemBuilder: (context, index) {
                        final suggestion = _suggestions.value[index];
                        return _AutoCompleteItem(
                          suggestion: suggestion,
                          selected: index == _selectedIndex.value,
                          onSelected: () {
                            _selectedIndex.value = index;
                            _handleProceed();
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
        widthConstraint: widget.popoverWidthConstraint ?? PopoverConstraint.anchorFixedSize,
        anchorAlignment: widget.popoverAnchorAlignment ?? AlignmentDirectional.bottomStart,
        alignment: widget.popoverAlignment ?? AlignmentDirectional.topStart,
      );
    }
  }

  void _handleProceed() {
    final selectedIndex = _selectedIndex.value;
    if (selectedIndex == -1) {
      return;
    }
    _popoverController.close();
    switch (widget.mode) {
      case AutoCompleteMode.append:
        final suggestion = _suggestions.value[selectedIndex];
        TextFieldAppendTextIntent intent = TextFieldAppendTextIntent(text: suggestion);
        invokeActionOnFocusedWidget(intent);
        break;
      case AutoCompleteMode.replaceWord:
        final suggestion = _suggestions.value[selectedIndex];
        TextFieldReplaceCurrentWordIntent intent = TextFieldReplaceCurrentWordIntent(text: suggestion);
        invokeActionOnFocusedWidget(intent);
        break;
      case AutoCompleteMode.replaceAll:
        final suggestion = _suggestions.value[selectedIndex];
        TextFieldSetTextIntent intent = TextFieldSetTextIntent(text: suggestion);
        invokeActionOnFocusedWidget(intent);
        break;
    }
  }

  @override
  void didUpdateWidget(covariant AutoComplete oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.suggestions, widget.suggestions)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _suggestions.value = widget.suggestions;
        _selectedIndex.value = widget.suggestions.isEmpty ? -1 : 0;
      });
    }
  }

  void _onFocusChanged(bool focused) {
    _isFocused = focused;
    if (!focused) {
      _popoverController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _selectedIndex,
      builder: (context, child) {
        return FocusableActionDetector(
          onFocusChange: _onFocusChanged,
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.arrowDown): const _MoveSelectionIntent(1),
            LogicalKeySet(LogicalKeyboardKey.arrowUp): const _MoveSelectionIntent(-1),
            if (widget.suggestions.isNotEmpty && _selectedIndex.value != -1)
              LogicalKeySet(LogicalKeyboardKey.tab): const _AcceptSelectionIntent(),
          },
          actions: {
            _MoveSelectionIntent: CallbackAction<_MoveSelectionIntent>(
              onInvoke: (intent) {
                final direction = intent.direction;
                final selectedIndex = _selectedIndex.value;
                final suggestions = _suggestions.value;
                if (suggestions.isEmpty) {
                  return;
                }
                final newSelectedIndex = (selectedIndex + direction) % suggestions.length;
                _selectedIndex.value = newSelectedIndex < 0 ? suggestions.length - 1 : newSelectedIndex;
                return;
              },
            ),
            _AcceptSelectionIntent: CallbackAction<_AcceptSelectionIntent>(
              onInvoke: (intent) {
                _handleProceed();
                return;
              },
            ),
          },
          child: widget.child,
        );
      },
    );
  }
}

enum AutoCompleteMode { append, replaceWord, replaceAll }

class _MoveSelectionIntent extends Intent {
  final int direction;

  const _MoveSelectionIntent(this.direction);
}

class _AcceptSelectionIntent extends Intent {
  const _AcceptSelectionIntent();
}
