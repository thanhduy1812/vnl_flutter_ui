import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample13 extends StatelessWidget {
  const ButtonExample13({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          onPressed: () {},
          shape: ButtonShape.circle,
          child: const Icon(Icons.add),
        ),
        PrimaryButton(
          onPressed: () {},
          shape: ButtonShape.rectangle,
          child: const Text('Rectangle'),
        ),
      ],
    );
  }
}
