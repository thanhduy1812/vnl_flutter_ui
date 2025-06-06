import 'package:vnl_common_ui/vnl_ui.dart';

class CheckboxExample1 extends StatefulWidget {
  const CheckboxExample1({super.key});

  @override
  State<CheckboxExample1> createState() => _CheckboxExample1State();
}

class _CheckboxExample1State extends State<CheckboxExample1> {
  CheckboxState _state = CheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return VNLCheckbox(
      state: _state,
      onChanged: (value) {
        setState(() {
          _state = value;
        });
      },
      trailing: const Text('Remember me'),
    );
  }
}
