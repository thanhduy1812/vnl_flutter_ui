import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates VNLTimePicker in popover and dialog modes, updating state and
// handling cancel by falling back to current time.

class TimePickerExample1 extends StatefulWidget {
  const TimePickerExample1({super.key});

  @override
  State<TimePickerExample1> createState() => _TimePickerExample1State();
}

class _TimePickerExample1State extends State<TimePickerExample1> {
  TimeOfDay _value = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VNLTimePicker(
          value: _value,
          // VNLPopover mode shows a compact inline picker anchored to the field.
          mode: VNLPromptMode.popover,
          onChanged: (value) {
            setState(() {
              // If user cancels, keep time by falling back to now.
              _value = value ?? TimeOfDay.now();
            });
          },
        ),
        const Gap(16),
        VNLTimePicker(
          value: _value,
          // Dialog mode opens a modal sheet/dialog for selection.
          mode: VNLPromptMode.dialog,
          dialogTitle: const Text('Select Time'),
          onChanged: (value) {
            setState(() {
              _value = value ?? TimeOfDay.now();
            });
          },
        ),
      ],
    );
  }
}
