import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample17 extends StatelessWidget {
  const ButtonExample17({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLButton(
      style: const ButtonStyle.primary()
          .withBackgroundColor(color: VNLColors.red, hoverColor: VNLColors.purple)
          .withForegroundColor(color: VNLColors.white)
          .withBorderRadius(hoverBorderRadius: BorderRadius.circular(16)),
      onPressed: () {},
      leading: const Icon(Icons.sunny),
      child: const Text('Custom Button'),
    );
  }
}
