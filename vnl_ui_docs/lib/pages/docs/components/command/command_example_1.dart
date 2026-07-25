import 'package:vnl_common_ui/vnl_ui.dart';

class CommandExample1 extends StatelessWidget {
  const CommandExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLCommand(
      // The builder is an async generator producing lists of VNLCommandCategory
      // based on the current search query. Each yield updates the UI.
      builder: (context, query) async* {
        Map<String, List<String>> items = {
          'Suggestions': ['VNLCalendar', 'Search Emoji', 'Launch'],
          'Settings': ['Profile', 'Mail', 'Settings'],
        };
        Map<String, Widget> icons = {
          'VNLCalendar': const Icon(Icons.calendar_today),
          'Search Emoji': const Icon(Icons.emoji_emotions_outlined),
          'Launch': const Icon(Icons.rocket_launch_outlined),
          'Profile': const Icon(Icons.person_outline),
          'Mail': const Icon(Icons.mail_outline),
          'Settings': const Icon(Icons.settings_outlined),
        };
        for (final values in items.entries) {
          List<Widget> resultItems = [];
          for (final item in values.value) {
            if (query == null ||
                item.toLowerCase().contains(query.toLowerCase())) {
              resultItems.add(VNLCommandItem(
                title: Text(item),
                leading: icons[item],
                onTap: () {},
              ));
            }
          }
          if (resultItems.isNotEmpty) {
            // Simulate latency to showcase incremental results.
            await Future.delayed(const Duration(seconds: 1));
            yield [
              VNLCommandCategory(
                title: Text(values.key),
                children: resultItems,
              ),
            ];
          }
        }
      },
    ).sized(width: 300, height: 300);
  }
}
