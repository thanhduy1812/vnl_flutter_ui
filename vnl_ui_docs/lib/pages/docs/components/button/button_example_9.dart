import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample9 extends StatelessWidget {
  const ButtonExample9({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VNLPrimaryButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        VNLSecondaryButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        VNLOutlineButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        GhostButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        VNLTextButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        DestructiveButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
