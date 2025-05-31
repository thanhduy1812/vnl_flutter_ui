import 'package:docs/pages/docs/components/avatar/avatar_example_1.dart';
import 'package:docs/pages/docs/components/avatar/avatar_example_2.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'avatar/avatar_example_3.dart';

class AvatarExample extends StatelessWidget {
  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'VNLAvatar',
      description: 'Avatars are used to represent people or objects.',
      displayName: 'VNLAvatar',
      children: [
        WidgetUsageExample(
          title: 'VNLAvatar Example',
          path: 'lib/pages/docs/components/VNLAvatar/avatar_example_1.dart',
          child: AvatarExample1(),
        ),
        WidgetUsageExample(
          title: 'VNLAvatar Example with Username Initials',
          path: 'lib/pages/docs/components/VNLAvatar/avatar_example_2.dart',
          child: AvatarExample2(),
        ),
        WidgetUsageExample(
          title: 'VNLAvatar Example with Badge',
          path: 'lib/pages/docs/components/VNLAvatar/avatar_example_3.dart',
          child: AvatarExample3(),
        ),
      ],
    );
  }
}
