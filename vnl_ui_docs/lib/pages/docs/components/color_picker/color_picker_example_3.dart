import 'package:vnl_common_ui/vnl_ui.dart';

class ColorPickerExample3 extends StatelessWidget {
  const ColorPickerExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VNLPrimaryButton(
          onPressed: () {
            showColorPicker(
              context: context,
              offset: const Offset(0, 8),
              color: ColorDerivative.fromColor(VNLColors.blue),
              onColorChanged: (value) {
                // Handle color change
              },
            );
          },
          child: const Text('Open Color Picker Popover'),
        ),
        const Gap(16),
        VNLPrimaryButton(
          onPressed: () {
            showColorPickerDialog(
              context: context,
              title: const Text('Select Color'),
              onColorChanged: (value) {
                // Handle color change
              },
              color: ColorDerivative.fromColor(VNLColors.blue),
            );
          },
          child: const Text('Open Color Picker Dialog'),
        ),
      ],
    );
  }
}
