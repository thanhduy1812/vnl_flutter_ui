import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class NumberInputTile extends StatelessWidget implements IComponentPage {
  const NumberInputTile({super.key});

  @override
  String get title => 'Number Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'number_input',
      title: 'Number Input',
      scale: 1.2,
      example: VNLCard(
        child: Column(
          children: [
            const Text('Enter a number:').bold(),
            const Gap(16),
            const VNLTextField(
              initialValue: '42',
              keyboardType: TextInputType.number,
              placeholder: Text('Enter number'),
            ).sized(width: 200),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
