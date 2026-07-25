import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/tracker/tracker_example_1.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class TrackerTile extends StatelessWidget implements IComponentPage {
  const TrackerTile({super.key});

  @override
  String get title => 'VNLTracker';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'tracker',
      title: 'VNLTracker',
      scale: 2,
      verticalOffset: 48,
      example: const TrackerExample1().sized(width: 500),
    );
  }
}
