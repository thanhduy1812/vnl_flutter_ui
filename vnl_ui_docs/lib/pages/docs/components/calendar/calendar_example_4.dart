import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLCalendar in read-only mode (no selection).
///
/// [VNLCalendarSelectionMode.none] displays the month grid without allowing
/// user selections; useful for a visual calendar-only view.
class CalendarExample4 extends StatefulWidget {
  const CalendarExample4({super.key});

  @override
  State<CalendarExample4> createState() => _CalendarExample4State();
}

class _CalendarExample4State extends State<CalendarExample4> {
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
              now: DateTime.now(),
              // Disable all selection (view-only).
              selectionMode: VNLCalendarSelectionMode.none,
            ),
          ],
        ),
      ),
    );
  }
}
