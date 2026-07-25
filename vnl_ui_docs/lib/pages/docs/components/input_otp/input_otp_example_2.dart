import 'package:vnl_common_ui/vnl_ui.dart';

class InputOTPExample2 extends StatelessWidget {
  const InputOTPExample2({super.key});

  @override
  Widget build(BuildContext context) {
    // Pre-populate the first group using the characters from the string '123'.
    // VNLInputOTP takes a list of code units for its initial value.
    return VNLInputOTP(
      initialValue: '123'.codeUnits,
      children: [
        VNLInputOTPChild.character(allowDigit: true),
        VNLInputOTPChild.character(allowDigit: true),
        VNLInputOTPChild.character(allowDigit: true),
        VNLInputOTPChild.separator,
        VNLInputOTPChild.character(allowDigit: true),
        VNLInputOTPChild.character(allowDigit: true),
        VNLInputOTPChild.character(allowDigit: true),
      ],
    );
  }
}
