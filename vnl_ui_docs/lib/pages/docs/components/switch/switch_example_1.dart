import 'package:vnl_common_ui/vnl_ui.dart';

class SwitchExample1 extends StatefulWidget {
  const SwitchExample1({super.key});

  @override
  State<SwitchExample1> createState() => _SwitchExample1State();
}

class _SwitchExample1State extends State<SwitchExample1> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return VNLSwitch(
      value: value,
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
      },
    );
  }
}
