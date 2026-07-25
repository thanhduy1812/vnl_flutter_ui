import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../text_area/text_area_example_3.dart';

class TextAreaTile extends StatelessWidget implements IComponentPage {
  const TextAreaTile({super.key});

  @override
  String get title => 'Text Area';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      title: 'Text Area',
      name: 'text_area',
      scale: 1.2,
      example: Column(
        children: [
          VNLCard(child: TextAreaExample3()),
          VNLCard(child: TextAreaExample3()),
        ],
      ),
    );
  }
}
