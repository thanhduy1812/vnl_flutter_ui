import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLDateRangePicker in popover and dialog modes.
///
/// Similar to the single-date picker, but selects a [VNLDateTimeRange].
class DatePickerExample2 extends StatefulWidget {
  const DatePickerExample2({super.key});

  @override
  State<DatePickerExample2> createState() => _DatePickerExample2State();
}

class _DatePickerExample2State extends State<DatePickerExample2> {
  VNLDateTimeRange? _value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VNLDateRangePicker(
          value: _value,
          mode: VNLPromptMode.popover,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
        ),
        const Gap(16),
        VNLDateRangePicker(
          value: _value,
          mode: VNLPromptMode.dialog,
          // Title for the dialog variant.
          dialogTitle: const Text('Select Date Range'),
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
