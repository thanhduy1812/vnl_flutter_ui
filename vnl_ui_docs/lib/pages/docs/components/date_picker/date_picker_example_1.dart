import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLDatePicker in popover and dialog modes with disabled future dates.
///
/// Demonstrates single-date selection with two different prompt UIs:
/// - [VNLPromptMode.popover]: inline, anchored overlay.
/// - [VNLPromptMode.dialog]: modal dialog with a custom [dialogTitle].
class DatePickerExample1 extends StatefulWidget {
  const DatePickerExample1({super.key});

  @override
  State<DatePickerExample1> createState() => _DatePickerExample1State();
}

class _DatePickerExample1State extends State<DatePickerExample1> {
  DateTime? _value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VNLDatePicker(
          value: _value,
          mode: VNLPromptMode.popover,
          // Disable selecting dates after "today".
          stateBuilder: (date) {
            if (date.isAfter(DateTime.now())) {
              return VNLDateState.disabled;
            }
            return VNLDateState.enabled;
          },
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        const Gap(16),
        VNLDatePicker(
          value: _value,
          mode: VNLPromptMode.dialog,
          // Title shown at the top of the dialog variant.
          dialogTitle: const Text('Select Date'),
          stateBuilder: (date) {
            if (date.isAfter(DateTime.now())) {
              return VNLDateState.disabled;
            }
            return VNLDateState.enabled;
          },
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
      ],
    );
  }
}
