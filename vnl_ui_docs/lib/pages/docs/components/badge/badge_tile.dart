import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class BadgeTile extends StatelessWidget implements IComponentPage {
  const BadgeTile({super.key});

  @override
  String get title => 'Badge';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'badge',
      title: 'Badge',
      center: true,
      scale: 1.5,
      example: const Column(
        children: [
          VNLPrimaryBadge(child: Text('Primary')),
          VNLSecondaryBadge(child: Text('Secondary')),
          VNLDestructiveBadge(child: Text('Destructive')),
        ],
      ).gap(8),
    );
  }
}
