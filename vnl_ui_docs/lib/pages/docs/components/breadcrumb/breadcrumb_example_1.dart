import 'package:vnl_common_ui/shadcn_flutter.dart';

/// VNLBreadcrumb with arrow separators.
///
/// Demonstrates how to compose a [VNLBreadcrumb] from a series of items,
/// mixing interactive [VNLTextButton]s and static labels. The `separator`
/// controls the visual delimiter between items.
class BreadcrumbExample1 extends StatelessWidget {
  const BreadcrumbExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLBreadcrumb(
      // Use a built-in arrow separator for a conventional look.
      separator: VNLBreadcrumb.arrowSeparator,
      children: [
        VNLTextButton(
          onPressed: () {},
          density: VNLButtonDensity.compact,
          child: const Text('Home'),
        ),
        const VNLMoreDots(),
        VNLTextButton(
          onPressed: () {},
          density: VNLButtonDensity.compact,
          child: const Text('Components'),
        ),
        // Final segment as a non-interactive label.
        const Text('VNLBreadcrumb'),
      ],
    );
  }
}
