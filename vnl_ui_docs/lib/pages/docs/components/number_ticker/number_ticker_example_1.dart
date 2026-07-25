import 'package:intl/intl.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates VNLNumberTicker animating from its previous value to a new value.
// The VNLTextField lets you enter a target integer; committing the edit triggers
// the ticker to animate the change. A formatter compact-prints large numbers.

class NumberTickerExample1 extends StatefulWidget {
  const NumberTickerExample1({super.key});

  @override
  State<NumberTickerExample1> createState() => _NumberTickerExample1State();
}

class _NumberTickerExample1State extends State<NumberTickerExample1> {
  // Current target number. Changing this causes VNLNumberTicker to animate
  // from the old value to the new value.
  int _number = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VNLNumberTicker(
          // Starting point for the first animation frame.
          initialNumber: 0,
          // The live value to animate toward. When this changes, the ticker
          // interpolates between the previous and the new value.
          number: _number,
          style: const TextStyle(fontSize: 32),
          formatter: (number) {
            // Optional display formatter: 1200 -> 1.2K, etc.
            return NumberFormat.compact().format(number);
          },
        ),
        const Gap(24),
        VNLTextField(
          // Show the current number as the initial text.
          initialValue: _number.toString(),
          controller: _controller,
          onEditingComplete: () {
            // Commit input on edit complete and update the ticker target.
            int? number = int.tryParse(_controller.text);
            if (number != null) {
              setState(() {
                _number = number;
              });
            }
          },
        )
      ],
    );
  }
}
