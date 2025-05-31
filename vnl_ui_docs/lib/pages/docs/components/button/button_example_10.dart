import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample10 extends StatelessWidget {
  const ButtonExample10({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        VNLPrimaryButton(
          size: ButtonSize.xSmall,
          onPressed: () {},
          child: const Text('Extra Small'),
        ),
        VNLPrimaryButton(
          onPressed: () {},
          size: ButtonSize.small,
          child: const Text('Small'),
        ),
        VNLPrimaryButton(
          size: ButtonSize.normal,
          onPressed: () {},
          child: const Text('Normal'),
        ),
        VNLPrimaryButton(
          size: ButtonSize.large,
          onPressed: () {},
          child: const Text('Large'),
        ),
        VNLPrimaryButton(
          size: ButtonSize.xLarge,
          onPressed: () {},
          child: const Text('Extra Large'),
        ),
      ],
    );
  }
}
