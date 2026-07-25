import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class CalendarTile extends StatelessWidget implements IComponentPage {
  const CalendarTile({super.key});

  @override
  String get title => 'VNLCalendar';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'calendar',
      title: 'VNLCalendar',
      scale: 1,
      example: VNLCalendar(
          view: VNLCalendarView.now(), selectionMode: VNLCalendarSelectionMode.none),
    );
  }
}
