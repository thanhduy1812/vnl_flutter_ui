import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample5 extends StatelessWidget {
  const ButtonExample5({super.key});

  @override
  Widget build(BuildContext context) {
    return DestructiveButton(
      onPressed: () {},
      child: const Text('Destructive'),
    );
  }
}
