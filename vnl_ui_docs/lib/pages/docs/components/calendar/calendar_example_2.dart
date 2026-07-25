import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLCalendar with single-date selection and a "today" marker.
///
/// Uses [VNLCalendarSelectionMode.single] to allow selecting exactly one date,
/// and passes `now` to highlight the current day in the view.
class CalendarExample2 extends StatefulWidget {
  const CalendarExample2({super.key});

  @override
  State<CalendarExample2> createState() => _CalendarExample2State();
}

class _CalendarExample2State extends State<CalendarExample2> {
  VNLCalendarValue? _value;
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
              selectionMode: VNLCalendarSelectionMode.single,
              // Provide a "today" reference for visual emphasis.
              now: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
