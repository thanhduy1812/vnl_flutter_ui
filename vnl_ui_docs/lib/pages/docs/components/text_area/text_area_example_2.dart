import 'package:vnl_common_ui/vnl_ui.dart';

class TextAreaExample2 extends StatelessWidget {
  const TextAreaExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      expandableWidth: true,
      initialWidth: 500,
    );
  }
}
