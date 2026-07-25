import 'package:vnl_common_ui/vnl_ui.dart';

/// Secondary button.
///
/// A lower-emphasis action compared to [VNLPrimaryButton].
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
