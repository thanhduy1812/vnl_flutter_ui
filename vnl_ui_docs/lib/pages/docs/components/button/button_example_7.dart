import 'package:vnl_common_ui/vnl_ui.dart';

class ButtonExample7 extends StatelessWidget {
  const ButtonExample7({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VNLPrimaryButton(
          child: Text('Disabled'),
        ),
        VNLSecondaryButton(
          child: Text('Disabled'),
        ),
        VNLOutlineButton(
          child: Text('Disabled'),
        ),
        GhostButton(
          child: Text('Disabled'),
        ),
        VNLTextButton(
          child: Text('Disabled'),
        ),
        DestructiveButton(
          child: Text('Disabled'),
        ),
      ],
    );
  }
}
