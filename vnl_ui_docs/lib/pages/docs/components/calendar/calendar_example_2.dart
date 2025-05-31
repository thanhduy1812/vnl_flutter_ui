import 'package:vnl_common_ui/vnl_ui.dart';

class CalendarExample2 extends StatefulWidget {
  const CalendarExample2({super.key});

  @override
  State<CalendarExample2> createState() => _CalendarExample2State();
}

class _CalendarExample2State extends State<CalendarExample2> {
  CalendarValue? _value;
  CalendarView _view = CalendarView.now();
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
                  density: ButtonDensity.icon,
                  onPressed: () {
                    setState(() {
                      _view = _view.previous;
                    });
                  },
                  child: const Icon(Icons.arrow_back).iconXSmall(),
                ),
                Text('${localizations.getMonth(_view.month)} ${_view.year}').small().medium().center().expanded(),
                VNLOutlineButton(
                  density: ButtonDensity.icon,
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
              selectionMode: CalendarSelectionMode.single,
              now: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
