import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample11 extends StatelessWidget {
  const ButtonExample11({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        VNLPrimaryButton(
          onPressed: () {},
          density: ButtonDensity.compact,
          child: const Text('Compact'),
        ),
        VNLPrimaryButton(
          onPressed: () {},
          density: ButtonDensity.dense,
          child: const Text('Dense'),
        ),
        VNLPrimaryButton(
          onPressed: () {},
          density: ButtonDensity.normal,
          child: const Text('Normal'),
        ),
        VNLPrimaryButton(
          onPressed: () {},
          density: ButtonDensity.comfortable,
          child: const Text('Comfortable'),
        ),
        VNLPrimaryButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Text('Icon'),
        ),
        VNLPrimaryButton(
          onPressed: () {},
          density: ButtonDensity.iconComfortable,
          child: const Text('Icon Comfortable'),
        ),
      ],
    );
  }
}
