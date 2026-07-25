import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class CircularProgressTile extends StatelessWidget implements IComponentPage {
  const CircularProgressTile({super.key});

  @override
  String get title => 'Circular VNLProgress';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'circular_progress',
      title: 'Circular VNLProgress',
      center: true,
      example: Transform.scale(
        scale: 3,
        child: const VNLCircularProgressIndicator(),
      ),
    );
  }
}
