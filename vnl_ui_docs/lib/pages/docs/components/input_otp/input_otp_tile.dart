import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../input_otp/input_otp_example_2.dart';

class InputOTPTile extends StatelessWidget implements IComponentPage {
  const InputOTPTile({super.key});

  @override
  String get title => 'Input OTP';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Input OTP',
      name: 'input_otp',
      scale: 1,
      example: Column(
        children: [
          const VNLCard(
            child: InputOTPExample2(),
          ),
          const Gap(24),
          Transform.translate(
            offset: const Offset(-150, 0),
            child: VNLCard(
              child: VNLInputOTP(
                initialValue: '123456'.codeUnits,
                children: [
                  VNLInputOTPChild.character(allowDigit: true, obscured: true),
                  VNLInputOTPChild.character(allowDigit: true, obscured: true),
                  VNLInputOTPChild.character(allowDigit: true, obscured: true),
                  VNLInputOTPChild.separator,
                  VNLInputOTPChild.character(allowDigit: true, obscured: true),
                  VNLInputOTPChild.character(allowDigit: true, obscured: true),
                  VNLInputOTPChild.character(allowDigit: true, obscured: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
