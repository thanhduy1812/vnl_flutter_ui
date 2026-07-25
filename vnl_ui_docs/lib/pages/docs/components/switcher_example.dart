import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/switcher/switcher_example_1.dart';
import 'package:docs/pages/docs/components/switcher/switcher_example_2.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class SwitcherExample extends StatelessWidget {
  const SwitcherExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'switcher',
      description:
          'A VNLSwitcher widget allows you to switch between different widgets with a transition effect.',
      displayName: 'VNLSwitcher',
      children: [
        WidgetUsageExample(
          title: 'VNLSwitcher Example 1',
          path: 'lib/pages/docs/components/switcher/switcher_example_1.dart',
          child: SwitcherExample1(),
        ),
        WidgetUsageExample(
          title: 'VNLSwitcher Example 2',
          path: 'lib/pages/docs/components/switcher/switcher_example_2.dart',
          child: SwitcherExample2(),
        ),
      ],
    );
  }
}
