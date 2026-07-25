import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class TabsTile extends StatelessWidget implements IComponentPage {
  const TabsTile({super.key});

  @override
  String get title => 'VNLTabs';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'VNLTabs',
      name: 'tabs',
      scale: 1.2,
      example: VNLCard(
        child: Column(
          children: [
            VNLTabs(index: 0, onChanged: (value) {}, children: const [
              // Text('Tab 1'),
              // Text('Tab 2'),
              // Text('Tab 3'),
              VNLTabItem(child: Text('Tab 1')),
              VNLTabItem(child: Text('Tab 2')),
              VNLTabItem(child: Text('Tab 3')),
            ]),
            VNLTabs(index: 1, onChanged: (value) {}, children: const [
              VNLTabItem(child: Text('Tab 1')),
              VNLTabItem(child: Text('Tab 2')),
              VNLTabItem(child: Text('Tab 3')),
            ]),
            VNLTabs(index: 2, onChanged: (value) {}, children: const [
              VNLTabItem(child: Text('Tab 1')),
              VNLTabItem(child: Text('Tab 2')),
              VNLTabItem(child: Text('Tab 3')),
            ]),
          ],
        ).gap(8),
      ),
    );
  }
}
