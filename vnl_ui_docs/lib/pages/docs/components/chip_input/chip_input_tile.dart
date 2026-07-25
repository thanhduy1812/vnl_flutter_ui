import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class ChipInputTile extends StatelessWidget implements IComponentPage {
  const ChipInputTile({super.key});

  @override
  String get title => 'VNLChip Input';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'chip_input',
      title: 'VNLChip Input',
      scale: 1,
      example: VNLCard(
        child: SizedBox(
          width: 300,
          height: 300,
          child: VNLOutlinedContainer(
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    // Empty for now - chip input components would go here
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
