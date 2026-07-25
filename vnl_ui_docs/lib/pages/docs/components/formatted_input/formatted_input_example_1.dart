import 'package:flutter/foundation.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class FormattedInputExample1 extends StatelessWidget {
  const FormattedInputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLFormattedInput(
      // Demonstrates a date-like formatted input built from editable and static parts.
      onChanged: (value) {
        List<String> parts = [];
        for (VNLFormattedValuePart part in value.values) {
          parts.add(part.value ?? '');
        }
        if (kDebugMode) {
          print(parts.join('/'));
        }
      },
      initialValue: VNLFormattedValue([
        const VNLInputPart.editable(length: 2, width: 40, placeholder: Text('MM'))
            .withValue('01'),
        const VNLInputPart.static('/'),
        const VNLInputPart.editable(length: 2, width: 40, placeholder: Text('DD'))
            .withValue('02'),
        const VNLInputPart.static('/'),
        const VNLInputPart.editable(
                length: 4, width: 60, placeholder: Text('YYYY'))
            .withValue('2021'),
      ]),
    );
  }
}
