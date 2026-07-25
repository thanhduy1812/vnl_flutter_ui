import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLCalendar with range selection mode.
///
/// Demonstrates navigating months using a custom header and binding
/// a [VNLCalendarValue] for a date range via [VNLCalendarSelectionMode.range].
class CalendarExample1 extends StatefulWidget {
  const CalendarExample1({super.key});

  @override
  State<CalendarExample1> createState() => _CalendarExample1State();
}

class _CalendarExample1State extends State<CalendarExample1> {
  // Holds the current selection (start/end) when in range mode.
  VNLCalendarValue? _value;
  // Tracks the current month/year view independent of selection.
  VNLCalendarView _view = VNLCalendarView.now();
  @override
  Widget build(BuildContext context) {
    VNLookLocalizations localizations = VNLookLocalizations.of(context);
    return VNLCard(
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                VNLOutlineButton(
                  density: VNLButtonDensity.icon,
                  onPressed: () {
                    setState(() {
                      // Move the calendar view to the previous month.
                      _view = _view.previous;
                    });
                  },
                  child: const Icon(Icons.arrow_back).iconXSmall(),
                ),
                Text('${localizations.getMonth(_view.month)} ${_view.year}').small().medium().center().expanded(),
                VNLOutlineButton(
                  density: VNLButtonDensity.icon,
                  onPressed: () {
                    setState(() {
                      // Move the calendar view to the next month.
                      _view = _view.next;
                    });
                  },
                  child: const Icon(Icons.arrow_forward).iconXSmall(),
                ),
              ],
            ),
            const Gap(16),
            VNLCalendar(
              value: _value,
              view: _view,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              // Range selection allows choosing a start and end date.
              selectionMode: VNLCalendarSelectionMode.range,
            ),
          ],
        ),
      ),
    );
  }
}
