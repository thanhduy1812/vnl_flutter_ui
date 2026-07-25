import 'package:flutter/material.dart' as material;
import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class InputTile extends StatelessWidget implements IComponentPage {
  const InputTile({super.key});

  @override
  String get title => 'Text Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'input',
      title: 'Text Input',
      scale: 2,
      example: VNLCard(
        child: const VNLTextField(
          initialValue: 'Hello World',
          features: [
            VNLInputFeature.leading(Icon(material.Icons.edit)),
          ],
        ).sized(width: 250, height: 32),
      ).sized(height: 400),
    );
  }
}
