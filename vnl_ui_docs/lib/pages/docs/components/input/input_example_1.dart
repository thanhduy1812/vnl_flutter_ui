import 'package:vnl_common_ui/vnl_ui.dart';

class InputExample1 extends StatelessWidget {
  const InputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLTextField(
      placeholder: Text('Enter your name'),
    );
  }
}
