import 'package:flutter/services.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class KeyboardDisplayExample1 extends StatelessWidget {
  const KeyboardDisplayExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        VNLKeyboardDisplay(keys: [
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.alt,
          LogicalKeyboardKey.delete,
        ]),
        Gap(24),
        VNLKeyboardDisplay.fromActivator(
          activator: SingleActivator(
            LogicalKeyboardKey.keyA,
            control: true,
            shift: true,
          ),
        )
      ],
    ).textSmall();
  }
}
