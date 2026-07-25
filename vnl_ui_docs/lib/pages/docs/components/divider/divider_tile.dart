import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../divider/divider_example_3.dart';

class DividerTile extends StatelessWidget implements IComponentPage {
  const DividerTile({super.key});

  @override
  String get title => 'VNLDivider';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'divider',
      title: 'VNLDivider',
      scale: 1.2,
      example: VNLCard(child: DividerExample3()),
    );
  }
}
