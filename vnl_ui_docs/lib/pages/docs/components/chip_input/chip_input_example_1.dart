import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLChipInput with inline autocomplete suggestions.
///
/// Shows how to:
/// - Listen to a [VNLChipEditingController] to compute suggestions based on
///   the current token being typed (using [textAtCursor]).
/// - Wrap [VNLChipInput] with [VNLAutoComplete] to display suggestions.
/// - Transform submitted chips (here we prepend '@').
class ChipInputExample1 extends StatefulWidget {
  const ChipInputExample1({super.key});

  @override
  State<ChipInputExample1> createState() => _ChipInputExample1State();
}

class _ChipInputExample1State extends State<ChipInputExample1> {
  // Current filtered suggestions for the token at the cursor.
  List<String> _suggestions = [];
  // Controller manages both chips and text entry.
  final VNLChipEditingController<String> _controller = VNLChipEditingController();
  // Static suggestion pool to match against.
  static const List<String> _availableSuggestions = [
    'hello world',
    'lorem ipsum',
    'do re mi',
    'foo bar',
    'flutter dart',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        setState(() {
          // IMPORTANT: use textAtCursor instead of text so we only consider
          // the current token under the caret when filtering suggestions.
          var value = _controller.textAtCursor;
          if (value.isNotEmpty) {
            _suggestions = _availableSuggestions.where((element) {
              return element.startsWith(value);
            }).toList();
          } else {
            _suggestions = [];
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VNLAutoComplete(
          // Provide suggestions to show below the input as the user types.
          suggestions: _suggestions,
          child: VNLChipInput<String>(
            controller: _controller,
            onChipSubmitted: (value) {
              setState(() {
                _suggestions = [];
              });
              // Transform the chip value before storing it.
              return '@$value';
            },
            chipBuilder: (context, chip) {
              return Text(chip);
            },
          ),
        ),
        gap(24),
        ListenableBuilder(
          listenable: _controller,
          builder: (context, child) {
            // Reflect the current chip list for demonstration.
            return Text('Current chips: ${_controller.chips.join(', ')}');
          },
        ),
      ],
    );
  }
}
