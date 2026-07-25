import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class TabListTile extends StatelessWidget implements IComponentPage {
  const TabListTile({super.key});

  @override
  String get title => 'Tab List';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'tab_list',
      title: 'Tab List',
      scale: 1,
      reverseVertical: true,
      verticalOffset: 60,
      example: VNLTabList(
        index: 0,
        onChanged: (value) {},
        children: const [
          VNLTabItem(child: Text('Preview')),
          VNLTabItem(child: Text('Code')),
          VNLTabItem(child: Text('Design')),
          VNLTabItem(child: Text('Settings')),
        ],
      ),
    );
  }
}
