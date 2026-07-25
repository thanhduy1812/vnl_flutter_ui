import 'package:docs/debug.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates a VNLWindowNavigator simulating multiple desktop-style windows,
// with an action to add a new window at runtime.

class WindowExample1 extends StatefulWidget {
  const WindowExample1({super.key});

  @override
  State<WindowExample1> createState() => _WindowExample1State();
}

class _WindowExample1State extends State<WindowExample1> {
  final GlobalKey<WindowNavigatorHandle> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        VNLOutlinedContainer(
          height: 600, // for example purpose
          child: VNLWindowNavigator(
            key: navigatorKey,
            // Pre-populate with two windows, each with its own bounds and title.
            initialWindows: [
              VNLWindow(
                bounds: const Rect.fromLTWH(0, 0, 200, 200),
                title: const Text('VNLWindow 1'),
                content: const RebuildCounter(),
              ),
              VNLWindow(
                bounds: const Rect.fromLTWH(200, 0, 200, 200),
                title: const Text('VNLWindow 2'),
                content: const RebuildCounter(),
              ),
            ],
            child: const Center(
              child: Text('Desktop'),
            ),
          ),
        ),
        VNLPrimaryButton(
          child: const Text('Add VNLWindow'),
          onPressed: () {
            // Push a new window via the navigator; title uses the current count.
            navigatorKey.currentState?.pushWindow(
              VNLWindow(
                bounds: const Rect.fromLTWH(0, 0, 200, 200),
                title: Text('VNLWindow ${navigatorKey.currentState!.windows.length + 1}'),
                content: const RebuildCounter(),
              ),
            );
          },
        )
      ],
    );
  }
}
