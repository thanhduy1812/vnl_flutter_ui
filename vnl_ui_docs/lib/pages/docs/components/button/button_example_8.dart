import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample8 extends StatelessWidget {
  const ButtonExample8({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: [
        VNLIconButton.primary(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        VNLIconButton.secondary(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        VNLIconButton.outline(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        VNLIconButton.ghost(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        VNLIconButton.text(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        VNLIconButton.destructive(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
