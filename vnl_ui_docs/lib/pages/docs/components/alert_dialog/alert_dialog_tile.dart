import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class AlertDialogTile extends StatelessWidget implements IComponentPage {
  const AlertDialogTile({super.key});

  @override
  String get title => 'VNLAlert Dialog';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'alert_dialog',
      title: 'VNLAlert Dialog',
      center: true,
      example: VNLAlertDialog(
        title: const Text('VNLAlert Dialog'),
        content: const Text('This is an alert dialog.'),
        actions: [
          VNLSecondaryButton(
            onPressed: () {},
            child: const Text('Cancel'),
          ),
          VNLPrimaryButton(
            onPressed: () {},
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
