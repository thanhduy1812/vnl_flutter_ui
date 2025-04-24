import 'package:vnl_common_ui/vnl_ui.dart';

class TextAreaExample1 extends StatelessWidget {
  const TextAreaExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLTextArea(
      initialValue: 'Hello, World!',
      expandableHeight: true,
      initialHeight: 300,
    );
  }
}
