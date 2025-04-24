import 'package:vnl_common_ui/vnl_ui.dart';

class AutoCompleteExample1 extends StatefulWidget {
  const AutoCompleteExample1({super.key});

  @override
  State<AutoCompleteExample1> createState() => _AutoCompleteExample1State();
}

class _AutoCompleteExample1State extends State<AutoCompleteExample1> {
  final List<String> suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grape',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];

  List<String> _currentSuggestions = [];
  final TextEditingController _controller = TextEditingController();

  void _updateSuggestions(String value) {
    String? currentWord = _controller.currentWord;
    if (currentWord == null || currentWord.isEmpty) {
      setState(() {
        _currentSuggestions = [];
      });
      return;
    }
    setState(() {
      _currentSuggestions =
          suggestions.where((element) => element.toLowerCase().contains(currentWord.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VNLAutoComplete(
      suggestions: _currentSuggestions,
      child: VNLTextField(
        controller: _controller,
        onChanged: _updateSuggestions,
        trailing: const IconButton.text(
          density: ButtonDensity.compact,
          icon: Icon(Icons.clear),
          onPressed: clearActiveTextInput,
        ),
      ),
    );
  }
}
