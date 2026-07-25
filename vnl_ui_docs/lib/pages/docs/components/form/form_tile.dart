import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../form/form_example_1.dart';

class FormTile extends StatelessWidget implements IComponentPage {
  const FormTile({super.key});

  @override
  String get title => 'VNLForm';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'form',
      title: 'VNLForm',
      example: VNLCard(child: FormExample1()),
    );
  }
}
