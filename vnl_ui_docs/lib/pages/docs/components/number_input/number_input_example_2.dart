import 'package:vnl_common_ui/vnl_ui.dart';

class NumberInputExample2 extends StatefulWidget {
  const NumberInputExample2({super.key});

  @override
  State<NumberInputExample2> createState() => _NumberInputExample2State();
}

class _NumberInputExample2State extends State<NumberInputExample2> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 150,
          child: VNLTextField(
            initialValue: value.toString(),
            onChanged: (value) {
              setState(() {
                this.value = double.tryParse(value) ?? 0;
              });
            },
            features: const [
              VNLInputFeature.incrementButton(max: 10),
              VNLInputFeature.decrementButton(min: -10),
            ],
            submitFormatters: [
              // Allow math expressions (e.g., 1+2*3) that resolve on submit.
              VNLTextInputFormatters.mathExpression(),
            ],
          ),
        ),
        gap(8),
        Text('Value: $value'),
      ],
    );
  }
}
