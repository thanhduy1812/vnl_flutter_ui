import 'package:vnl_common_ui/vnl_ui.dart';

class InputExample1 extends StatelessWidget {
  const InputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // VNLBasic text input using shadcn_flutter's VNLTextField.
    // placeholder is rendered inside the input when it's empty.
    return const VNLTextField(
      placeholder: Text('Enter your name'),
    );
  }
}
