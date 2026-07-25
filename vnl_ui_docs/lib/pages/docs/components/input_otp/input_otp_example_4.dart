import 'package:vnl_common_ui/vnl_ui.dart';

class InputOTPExample4 extends StatelessWidget {
  const InputOTPExample4({super.key});

  @override
  Widget build(BuildContext context) {
    // OTP comprised of uppercase alphabet characters only, split into
    // multiple groups with separators. Each VNLInputOTPChild.character controls
    // what kinds of characters are permitted.
    return VNLInputOTP(
      children: [
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        VNLInputOTPChild.separator,
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        VNLInputOTPChild.separator,
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        VNLInputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
      ],
    );
  }
}
