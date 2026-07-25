import 'package:vnl_common_ui/shadcn_flutter.dart';

class InputExample3 extends StatelessWidget {
  const InputExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VNLTextField(
          placeholder: const Text('Enter your name'),
          features: [
            const VNLInputFeature.clear(),
            // Hint shows a small tooltip-like popup for the input field.
            VNLInputFeature.hint(
              popupBuilder: (context) {
                return const VNLTooltipContainer(
                    child: Text('This is for your username'));
              },
            ),
            // Convenience actions for copying/pasting directly from the text field UI.
            const VNLInputFeature.copy(),
            const VNLInputFeature.paste(),
          ],
        ),
        const Gap(24),
        const VNLTextField(
          placeholder: Text('Enter your password'),
          features: [
            VNLInputFeature.clear(
              visibility: VNLInputFeatureVisibility.textNotEmpty,
            ),
            // Password toggle configured with `hold` mode: press-and-hold to peek,
            // release to hide again.
            VNLInputFeature.passwordToggle(mode: VNLPasswordPeekMode.hold),
          ],
        ),
      ],
    );
  }
}
