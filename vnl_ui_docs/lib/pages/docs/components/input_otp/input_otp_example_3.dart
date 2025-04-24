import 'package:vnl_common_ui/vnl_ui.dart';

class InputOTPExample3 extends StatelessWidget {
  const InputOTPExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLInputOTP(
      children: [
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.separator,
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.character(allowDigit: true, obscured: true),
      ],
    );
  }
}
