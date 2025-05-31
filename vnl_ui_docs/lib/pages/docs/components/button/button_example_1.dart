import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample1 extends StatelessWidget {
  const ButtonExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLPrimaryButton(
      onPressed: () {},
      child: const Text('Primary'),
    );
  }
}
