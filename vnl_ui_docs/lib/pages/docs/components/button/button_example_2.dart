import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample2 extends StatelessWidget {
  const ButtonExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLSecondaryButton(
      onPressed: () {},
      child: const Text('Secondary'),
    );
  }
}
