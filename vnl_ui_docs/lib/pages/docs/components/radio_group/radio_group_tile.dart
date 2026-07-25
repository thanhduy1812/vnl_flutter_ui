import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class RadioGroupTile extends StatelessWidget implements IComponentPage {
  const RadioGroupTile({super.key});

  @override
  String get title => 'VNLRadio Group';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'radio_group',
      title: 'VNLRadio Group',
      scale: 2,
      example: VNLCard(
        child: RadioGroup<int>(
          value: 1,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioItem<int>(
                trailing: Text('Option 1'),
                value: 0,
              ),
              RadioItem<int>(
                trailing: Text('Option 2'),
                value: 1,
              ),
              RadioItem<int>(
                trailing: Text('Option 3'),
                value: 2,
              ),
            ],
          ).gap(4),
        ).sized(width: 300),
      ),
    );
  }
}
