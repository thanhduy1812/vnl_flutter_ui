import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../toggle/toggle_example_2.dart';

class ToggleTile extends StatelessWidget implements IComponentPage {
  const ToggleTile({super.key});

  @override
  String get title => 'VNLToggle';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'toggle',
      title: 'VNLToggle',
      scale: 1.2,
      example: VNLCard(
        child: const ToggleExample2().withAlign(Alignment.topLeft),
      ).sized(height: 300, width: 300),
    );
  }
}
