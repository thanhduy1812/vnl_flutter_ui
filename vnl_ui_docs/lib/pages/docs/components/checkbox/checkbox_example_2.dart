import 'package:vnl_common_ui/vnl_ui.dart';

class CheckboxExample2 extends StatefulWidget {
  const CheckboxExample2({super.key});

  @override
  State<CheckboxExample2> createState() => _CheckboxExample2State();
}

class _CheckboxExample2State extends State<CheckboxExample2> {
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
      tristate: true,
    );
  }
}
