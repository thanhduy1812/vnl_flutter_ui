import 'package:vnl_common_ui/vnl_ui.dart';

class InputExample2 extends StatefulWidget {
  const InputExample2({super.key});

  @override
  State<InputExample2> createState() => _InputExample2State();
}

class _InputExample2State extends State<InputExample2> {
  @override
  Widget build(BuildContext context) {
    // Demonstrates input features:
    // - A leading search icon that reacts to the hover state when the field is empty
    // - A clear button that appears when there's text and the field is focused or hovered
    return VNLTextField(
        initialValue: 'Hello World!',
        placeholder: const Text('Search something...'),
        features: [
          // Leading icon only visible when the text is empty
          VNLInputFeature.leading(VNLStatedWidget.builder(
            builder: (context, states) {
              // Use a muted icon normally, switch to the full icon on hover
              if (states.hovered) {
                return const Icon(Icons.search);
              } else {
                return const Icon(Icons.search).iconMutedForeground();
              }
            },
          ), visibility: VNLInputFeatureVisibility.textEmpty),
          // Clear button visible when there is text and the field is focused,
          // or whenever the field is hovered
          VNLInputFeature.clear(
            visibility: (VNLInputFeatureVisibility.textNotEmpty &
                    VNLInputFeatureVisibility.focused) |
                VNLInputFeatureVisibility.hovered,
          ),
        ]);
  }
}
