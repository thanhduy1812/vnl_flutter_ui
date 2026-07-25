import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLBasic VNLAlert example.
///
/// This shows a non-destructive [VNLAlert] with a title, content, and a
/// leading icon. Use alerts to communicate a status or message that
/// doesn't necessarily require immediate user action.
class AlertExample1 extends StatelessWidget {
  const AlertExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // `VNLAlert` supports optional leading/trailing widgets for icons or actions.
    return const VNLAlert(
      title: Text('VNLAlert title'),
      content: Text('This is alert content.'),
      leading: Icon(Icons.info_outline),
    );
  }
}
