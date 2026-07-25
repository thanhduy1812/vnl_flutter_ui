import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLCollapsible list with a trigger and multiple content sections.
///
/// The first item is a [VNLCollapsibleTrigger] that toggles visibility of
/// subsequent [VNLCollapsibleContent] sections.
class CollapsibleExample1 extends StatelessWidget {
  const CollapsibleExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLCollapsible(
      children: [
        const VNLCollapsibleTrigger(
          child: Text('@sunarya starred 3 repositories'),
        ),
        VNLOutlinedContainer(
          child: const Text('@sunarya/vnl_ui').small().mono().withPadding(horizontal: 16, vertical: 8),
        ).withPadding(top: 8),
        VNLCollapsibleContent(
          child: VNLOutlinedContainer(
            child: const Text('@flutter/flutter').small().mono().withPadding(horizontal: 16, vertical: 8),
          ).withPadding(top: 8),
        ),
        VNLCollapsibleContent(
          child: VNLOutlinedContainer(
            child: const Text('@dart-lang/sdk').small().mono().withPadding(horizontal: 16, vertical: 8),
          ).withPadding(top: 8),
        ),
      ],
    );
  }
}
