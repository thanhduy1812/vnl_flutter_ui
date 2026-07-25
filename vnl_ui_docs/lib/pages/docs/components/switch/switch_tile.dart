import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class SwitchTile extends StatelessWidget implements IComponentPage {
  const SwitchTile({super.key});

  @override
  String get title => 'VNLSwitch';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'switch',
      title: 'VNLSwitch',
      scale: 2,
      center: true,
      example: VNLSwitch(
        value: true,
        onChanged: (value) {},
      ),
    );
  }
}
