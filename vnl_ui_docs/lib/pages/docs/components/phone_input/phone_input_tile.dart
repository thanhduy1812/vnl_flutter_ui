import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class PhoneInputTile extends StatelessWidget implements IComponentPage {
  const PhoneInputTile({super.key});

  @override
  String get title => 'Phone Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'phone_input',
      title: 'Phone Input',
      scale: 1.5,
      example: VNLCard(
        child: const VNLPhoneInput(
          initialValue: VNLPhoneNumber(Country.indonesia, '81234567890'),
        ).withAlign(Alignment.topLeft),
      ).sized(height: 300),
    );
  }
}
