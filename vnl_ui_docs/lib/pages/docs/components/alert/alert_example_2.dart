import 'package:vnl_common_ui/vnl_ui.dart';

/// Destructive VNLAlert example.
///
/// Demonstrates using the `destructive` style via the named constructor
/// [VNLAlert.destructive], which is suitable for critical or dangerous states.
class AlertExample2 extends StatelessWidget {
  const AlertExample2({super.key});

  @override
  Widget build(BuildContext context) {
    // Destructive styling typically emphasizes caution to the user.
    return const VNLAlert.destructive(
      title: Text('VNLAlert title'),
      content: Text('This is alert content.'),
      trailing: Icon(Icons.dangerous_outlined),
    );
  }
}
