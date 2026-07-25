import 'package:vnl_common_ui/shadcn_flutter.dart';

class NumberInputExample3 extends StatefulWidget {
  const NumberInputExample3({super.key});

  @override
  State<NumberInputExample3> createState() => _NumberInputExample3State();
}

class _NumberInputExample3State extends State<NumberInputExample3> {
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
              // Increment button on the left, decrement button on the right.
              VNLInputFeature.incrementButton(
                  position: VNLInputFeaturePosition.leading),
              VNLInputFeature.decrementButton(),
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
