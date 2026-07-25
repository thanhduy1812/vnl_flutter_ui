import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLCheckbox with two states (checked/unchecked).
///
/// Demonstrates controlling [VNLCheckbox] via a local [VNLCheckboxState]
/// and updating it from [onChanged].
class CheckboxExample1 extends StatefulWidget {
  const CheckboxExample1({super.key});

  @override
  State<CheckboxExample1> createState() => _CheckboxExample1State();
}

class _CheckboxExample1State extends State<CheckboxExample1> {
  // Start unchecked; toggle when the user taps the control.
  VNLCheckboxState _state = VNLCheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return VNLCheckbox(
      state: _state,
      onChanged: (value) {
        setState(() {
          _state = value;
        });
      },
      // Optional label placed on the trailing side.
      trailing: const Text('Remember me'),
    );
  }
}
