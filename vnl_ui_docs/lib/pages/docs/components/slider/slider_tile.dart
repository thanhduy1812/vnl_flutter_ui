import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class SliderTile extends StatelessWidget implements IComponentPage {
  const SliderTile({super.key});

  @override
  String get title => 'VNLSlider';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'slider',
      title: 'VNLSlider',
      center: true,
      scale: 2,
      example: VNLSlider(
        value: const VNLSliderValue.single(0.75),
        onChanged: (value) {},
      ).sized(width: 100),
    );
  }
}
