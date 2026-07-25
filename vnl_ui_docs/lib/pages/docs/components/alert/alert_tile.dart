import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class AlertTile extends StatelessWidget implements IComponentPage {
  const AlertTile({super.key});

  @override
  String get title => 'VNLAlert';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'alert',
      title: 'VNLAlert',
      center: true,
      example: VNLAlert(
        leading: Icon(Icons.info_outline),
        title: Text('VNLAlert'),
        content: Text('This is an alert.'),
      ),
    );
  }
}
