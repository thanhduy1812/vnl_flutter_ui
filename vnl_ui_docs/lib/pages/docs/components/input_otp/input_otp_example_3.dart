import 'package:vnl_common_ui/vnl_ui.dart';

class InputOTPExample3 extends StatelessWidget {
  const InputOTPExample3({super.key});

  @override
  Widget build(BuildContext context) {
    // Same layout as before but with obscured input to hide the characters
    // (useful for sensitive OTP codes).
    return VNLInputOTP(
      children: [
        VNLInputOTPChild.character(allowDigit: true, obscured: true),
        VNLInputOTPChild.character(allowDigit: true, obscured: true),
        VNLInputOTPChild.character(allowDigit: true, obscured: true),
        VNLInputOTPChild.separator,
        VNLInputOTPChild.character(allowDigit: true, obscured: true),
        VNLInputOTPChild.character(allowDigit: true, obscured: true),
        VNLInputOTPChild.character(allowDigit: true, obscured: true),
      ],
    );
  }
}
