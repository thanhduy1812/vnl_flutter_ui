import 'package:vnl_common_ui/shadcn_flutter.dart';

class ColorPickerExample3 extends StatefulWidget {
  const ColorPickerExample3({super.key});

  @override
  State<ColorPickerExample3> createState() => _ColorPickerExample3State();
}

class _ColorPickerExample3State extends State<ColorPickerExample3> {
  final ValueNotifier<VNLColorDerivative> selectedColorNotifier = ValueNotifier(
    VNLColorDerivative.fromColor(VNLColors.blue),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Builder(builder: (context) {
          return VNLPrimaryButton(
            onPressed: () {
              // Show the color picker as a popover anchored to the button.
              showPopover(
                context: context,
                alignment: Alignment.topCenter,
                anchorAlignment: Alignment.bottomCenter,
                widthConstraint: VNLPopoverConstraint.intrinsic,
                heightConstraint: VNLPopoverConstraint.intrinsic,
                offset: const Offset(0, 8),
                builder: (context) {
                  return ListenableBuilder(
                      listenable: selectedColorNotifier,
                      builder: (context, _) {
                        return VNLSurfaceCard(
                          child: VNLColorPicker(
                            value: selectedColorNotifier.value,
                            orientation: Axis.horizontal,
                            showAlpha: true,
                            onChanged: (value) {
                              setState(() {
                                selectedColorNotifier.value = value;
                              });
                            },
                          ),
                        );
                      });
                },
              );
            },
            child: const Text('Open Color Picker VNLPopover'),
          );
        }),
        const Gap(16),
        VNLPrimaryButton(
          onPressed: () {
            // Show the color picker as a dialog with a title.
            showDialog(
              context: context,
              builder: (context) {
                return VNLAlertDialog(
                  title: const Text('Select Color'),
                  content: ListenableBuilder(
                      listenable: selectedColorNotifier,
                      builder: (context, _) {
                        return VNLColorPicker(
                          value: selectedColorNotifier.value,
                          orientation: Axis.horizontal,
                          showAlpha: true,
                          onChanged: (value) {
                            setState(() {
                              selectedColorNotifier.value = value;
                            });
                          },
                        );
                      }),
                  actions: [
                    VNLPrimaryButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Open Color Picker Dialog'),
        ),
      ],
    );
  }
}
