import 'package:intl/intl.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class NumberTickerExample1 extends StatefulWidget {
  const NumberTickerExample1({super.key});

  @override
  State<NumberTickerExample1> createState() => _NumberTickerExample1State();
}

class _NumberTickerExample1State extends State<NumberTickerExample1> {
  int _number = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberTicker(
          initialNumber: 0,
          number: _number,
          style: const TextStyle(fontSize: 32),
          formatter: (number) {
            return NumberFormat.compact().format(number);
          },
        ),
        const Gap(24),
        VNLTextField(
          initialValue: _number.toString(),
          controller: _controller,
          onEditingComplete: () {
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
