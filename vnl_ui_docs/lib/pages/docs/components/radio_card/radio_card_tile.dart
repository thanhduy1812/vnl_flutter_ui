import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class RadioCardTile extends StatelessWidget implements IComponentPage {
  const RadioCardTile({super.key});

  @override
  String get title => 'VNLRadio VNLCard';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'radio_card',
      title: 'VNLRadio VNLCard',
      scale: 1.2,
      example: VNLCard(
        child: Column(
          children: [
            const Text('Select an option:').bold(),
            const Gap(16),
            const Column(
              children: [
                VNLCard(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        VNLRadio(value: true),
                        Gap(8),
                        Text('Option 1'),
                      ],
                    ),
                  ),
                ),
                Gap(8),
                VNLCard(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        VNLRadio(value: false),
                        Gap(8),
                        Text('Option 2'),
                      ],
                    ),
                  ),
                ),
                Gap(8),
                VNLCard(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        VNLRadio(value: false),
                        Gap(8),
                        Text('Option 3'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
