import 'package:vnl_common_ui/vnl_ui.dart';

class InputOTPExample2 extends StatelessWidget {
  const InputOTPExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLInputOTP(
      initialValue: '123'.codeUnits,
      children: [
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.separator,
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.character(allowDigit: true),
      ],
    );
  }
}
