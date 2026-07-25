import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class ProgressTile extends StatelessWidget implements IComponentPage {
  const ProgressTile({super.key});

  @override
  String get title => 'VNLProgress';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'VNLProgress',
      name: 'progress',
      example: const VNLProgress(
        progress: 0.75,
      ).sized(width: 200),
      center: true,
    );
  }
}
