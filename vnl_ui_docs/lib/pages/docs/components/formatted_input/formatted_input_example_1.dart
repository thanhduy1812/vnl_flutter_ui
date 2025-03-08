import 'package:vnl_common_ui/vnl_ui.dart';

class FormattedInputExample1 extends StatelessWidget {
  const FormattedInputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return FormattedInput(
      trailing: IconButton.text(
        density: ButtonDensity.compact,
        icon: const Icon(Icons.calendar_month),
        onPressed: () {},
      ),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        List<String> parts = [];
        for (FormattedValuePart part in value.parts) {
          parts.add(part.value ?? '');
        }
        print(parts.join('/'));
      },
      initialValue: FormattedValue([
        const InputPart.editable(length: 2, width: 40, placeholder: Text('MM')).withValue('01'),
        const InputPart.static('/'),
        const InputPart.editable(length: 2, width: 40, placeholder: Text('DD')).withValue('02'),
        const InputPart.static('/'),
        const InputPart.editable(length: 4, width: 60, placeholder: Text('YYYY')).withValue('2021'),
      ]),
    );
  }
}
