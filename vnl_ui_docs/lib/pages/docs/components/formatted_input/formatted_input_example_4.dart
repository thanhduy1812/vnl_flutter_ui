import 'package:vnl_common_ui/vnl_ui.dart';

class FormattedInputExample4 extends StatefulWidget {
  const FormattedInputExample4({super.key});

  @override
  State<FormattedInputExample4> createState() => _FormattedInputExample4State();
}

class _FormattedInputExample4State extends State<FormattedInputExample4> {
  Duration? _selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DurationInput(
          onChanged: (value) => setState(() => _selected = value),
          showSeconds: true,
        ),
        const Gap(16),
        if (_selected != null) Text('Selected duration: $_selected'),
      ],
    );
  }
}
