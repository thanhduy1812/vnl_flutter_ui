import 'package:docs/pages/docs/components/tooltip/tooltip_example_1.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TooltipExample extends StatelessWidget {
  const TooltipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tooltip',
      description: 'A floating message that appears when a user interacts with a target.',
      displayName: 'VNLTooltip',
      children: [
        WidgetUsageExample(
          title: 'VNLTooltip Example',
          path: 'lib/pages/docs/components/tooltip/tooltip_example_1.dart',
          child: TooltipExample1(),
        ),
      ],
    );
  }
}
