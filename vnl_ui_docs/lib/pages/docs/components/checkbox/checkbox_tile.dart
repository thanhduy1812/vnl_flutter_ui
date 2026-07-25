import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class CheckboxTile extends StatelessWidget implements IComponentPage {
  const CheckboxTile({super.key});

  @override
  String get title => 'VNLCheckbox';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'checkbox',
      title: 'VNLCheckbox',
      scale: 1.8,
      example: VNLCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VNLCheckbox(
              state: VNLCheckboxState.checked,
              trailing: const Text('Checked'),
              onChanged: (value) {},
            ),
            VNLCheckbox(
              state: VNLCheckboxState.indeterminate,
              trailing: const Text('Indeterminate'),
              onChanged: (value) {},
            ),
            VNLCheckbox(
              state: VNLCheckboxState.unchecked,
              trailing: const Text('Unchecked'),
              onChanged: (value) {},
            ),
          ],
        ).gap(4).sized(width: 300),
      ),
    );
  }
}
