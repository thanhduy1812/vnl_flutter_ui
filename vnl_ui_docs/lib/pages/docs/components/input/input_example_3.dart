import 'package:vnl_common_ui/vnl_ui.dart';

class InputExample3 extends StatelessWidget {
  const InputExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VNLTextField(
          placeholder: const Text('Enter your name'),
          features: [
            const InputFeature.clear(),
            InputFeature.hint(
              popupBuilder: (context) {
                return const TooltipContainer(child: Text('This is for your username'));
              },
            ),
            const InputFeature.copy(),
            const InputFeature.paste(),
          ],
        ),
        const Gap(24),
        const VNLTextField(
          placeholder: Text('Enter your password'),
          features: [
            InputFeature.clear(),
            InputFeature.passwordToggle(mode: PasswordPeekMode.hold),
          ],
        ),
      ],
    );
  }
}
