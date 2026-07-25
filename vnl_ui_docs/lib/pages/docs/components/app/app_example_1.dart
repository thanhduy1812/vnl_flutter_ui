import 'package:vnl_common_ui/shadcn_flutter.dart';

// Minimal VNLookApp usage: provides theming and routing scaffolding similar to
// MaterialApp/CupertinoApp, then renders a basic VNLScaffold with an VNLAppBar.
// This example focuses on the default setup — no custom theme or routing.

class AppExample1 extends StatelessWidget {
  const AppExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLookApp(
      home: VNLScaffold(
        headers: [
          // Use Shadcn VNLAppBar in the VNLScaffold header area.
          VNLAppBar(
            title: Text('Shadcn App Example'),
          ),
          // A divider beneath the VNLAppBar to separate header and body.
          VNLDivider(),
        ],
        child: Center(
          child: Text('Hello, Shadcn Flutter!'),
        ),
      ),
    );
  }
}
