import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:docs/pages/docs/components/calendar/calendar_example_2.dart';

class PopoverTile extends StatelessWidget implements IComponentPage {
  const PopoverTile({super.key});

  @override
  String get title => 'VNLPopover';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'popover',
      title: 'VNLPopover',
      scale: 1,
      example: VNLCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VNLDatePicker(
              value: DateTime.now(),
              mode: VNLPromptMode.popover,
              stateBuilder: (date) {
                if (date.isAfter(DateTime.now())) {
                  return VNLDateState.disabled;
                }
                return VNLDateState.enabled;
              },
              onChanged: (value) {},
            ),
            const Gap(4),
            const CalendarExample2(),
          ],
        ),
      ),
    );
  }
}
