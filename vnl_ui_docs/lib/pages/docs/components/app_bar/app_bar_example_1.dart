import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLAppBar with header, title, subtitle, and action buttons.
///
/// Demonstrates the structure of [VNLAppBar] and how to provide leading and
/// trailing actions using outline-styled icon buttons.
class AppBarExample1 extends StatelessWidget {
  const AppBarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLOutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: VNLAppBar(
        // Optional top line above the main title area.
        header: const Text('This is Header'),
        // Primary title and an optional subtitle.
        title: const Text('This is Title'),
        subtitle: const Text('This is Subtitle'),
        leading: [
          // Leading actions typically appear on the left.
          VNLOutlineButton(
            density: VNLButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.arrow_back),
          ),
        ],
        trailing: [
          // Trailing actions typically appear on the right.
          VNLOutlineButton(
            density: VNLButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.search),
          ),
          VNLOutlineButton(
            density: VNLButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
