import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class CollapsibleTile extends StatelessWidget implements IComponentPage {
  const CollapsibleTile({super.key});

  @override
  String get title => 'VNLCollapsible';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'collapsible',
      title: 'VNLCollapsible',
      reverse: true,
      example: VNLCard(
        child: VNLCollapsible(
          children: [
            const VNLCollapsibleTrigger(
              child: Text('@sunarya starred 3 repositories'),
            ),
            VNLOutlinedContainer(
              child: const Text('@sunarya/shadcn_flutter')
                  .small()
                  .mono()
                  .withPadding(horizontal: 16, vertical: 8),
            ).withPadding(top: 8),
            VNLCollapsibleContent(
              child: VNLOutlinedContainer(
                child: const Text('@flutter/flutter')
                    .small()
                    .mono()
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            VNLCollapsibleContent(
              child: VNLOutlinedContainer(
                child: const Text('@dart-lang/sdk')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            const VNLCollapsibleTrigger(
              child: Text('@flutter starred 1 repository'),
            ).withPadding(top: 16),
            VNLOutlinedContainer(
              child: const Text('@sunarya/shadcn_flutter')
                  .small()
                  .mono()
                  .withPadding(horizontal: 16, vertical: 8),
            ).withPadding(top: 8),
            VNLCollapsibleContent(
              child: VNLOutlinedContainer(
                child: const Text('@flutter/flutter')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            VNLCollapsibleContent(
              child: VNLOutlinedContainer(
                child: const Text('@dart-lang/sdk')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
          ],
        ),
      ),
    );
  }
}
