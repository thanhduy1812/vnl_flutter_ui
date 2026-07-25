// App example page: lists and renders VNLookApp demos.
//
// This wrapper page composes ComponentPage with WidgetUsageExample entries that
// link to the actual app demo files under components/app/*. Comments only.
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/app/app_example_3.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class GoRouterAppExample extends StatelessWidget {
  const GoRouterAppExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'go_router_app_example',
      description:
          'The VNLookApp.router widget enables multi-page navigation in Flutter apps using GoRouter,'
          'while providing global theming, localization, and other global configurations for your Flutter app.',
      displayName: 'App Example with GoRouter',
      children: [
        WidgetUsageExample(
          title: 'App Example with GoRouter',
          path: 'lib/pages/docs/components/app/app_example_3.dart',
          child: const AppExample3().sized(height: 300),
        ),
      ],
    );
  }
}
