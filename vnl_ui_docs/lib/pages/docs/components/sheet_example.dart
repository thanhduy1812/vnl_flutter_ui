import 'package:docs/pages/docs/components/sheet/sheet_example_1.dart';
import 'package:docs/pages/docs/components/sheet/sheet_example_2.dart';
import 'package:docs/pages/docs/components/sheet/sheet_example_3.dart';
import 'package:docs/pages/docs/components/sheet/sheet_example_4.dart';
import 'package:docs/pages/docs/components/sheet/sheet_example_5.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SheetExample extends StatelessWidget {
  const SheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'sheet',
      description: 'A draggable panel that snaps between multiple stages. '
          'Pinned to an edge with backdrop transform support.',
      displayName: 'Pinned Sheet',
      children: const [
        WidgetUsageExample(
          title: 'Controller-driven with backdrop scale',
          path: 'lib/pages/docs/components/sheet/sheet_example_1.dart',
          child: PinnedSheetExample1(),
        ),
        WidgetUsageExample(
          title: 'Peek drag handle',
          path: 'lib/pages/docs/components/sheet/sheet_example_2.dart',
          child: PinnedSheetExample2(),
        ),
        WidgetUsageExample(
          title: 'Centered sheet',
          path: 'lib/pages/docs/components/sheet/sheet_example_3.dart',
          child: PinnedSheetExample3(),
        ),
        WidgetUsageExample(
          title: 'Form in sheet',
          path: 'lib/pages/docs/components/sheet/sheet_example_4.dart',
          child: PinnedSheetExample4(),
        ),
        WidgetUsageExample(
          title: 'Edge positions',
          path: 'lib/pages/docs/components/sheet/sheet_example_5.dart',
          child: PinnedSheetExample5(),
        ),
      ],
    );
  }
}
