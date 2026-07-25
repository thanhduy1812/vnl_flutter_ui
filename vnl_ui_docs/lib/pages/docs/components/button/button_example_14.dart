import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample14 extends StatelessWidget {
  const ButtonExample14({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLButtonGroup(
      children: [
        VNLPrimaryButton(
          child: const Text('Primary'),
          onPressed: () {},
        ),
        VNLSecondaryButton(
          child: const Text('Secondary'),
          onPressed: () {},
        ),
        VNLDestructiveButton(
          child: const Text('Destructive'),
          onPressed: () {},
        ),
        VNLOutlineButton(
          child: const Text('Outlined'),
          onPressed: () {},
        ),
        VNLGhostButton(
          child: const Text('Ghost'),
          onPressed: () {},
        ),
        VNLIconButton.primary(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );
  }
}
