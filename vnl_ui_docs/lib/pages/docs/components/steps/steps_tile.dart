import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class StepsTile extends StatelessWidget implements IComponentPage {
  const StepsTile({super.key});

  @override
  String get title => 'VNLSteps';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'steps',
      title: 'VNLSteps',
      example: VNLCard(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: VNLSteps(children: [
          VNLStepItem(
            title: Text('Create a project'),
            content: [
              Text('Create a new flutter project'),
            ],
          ),
          VNLStepItem(
            title: Text('Add dependencies'),
            content: [
              Text('Add dependencies to pubspec.yaml'),
            ],
          ),
          VNLStepItem(
            title: Text('Run the project'),
            content: [
              Text('Run the project using flutter run'),
            ],
          ),
        ]),
      ),
    );
  }
}
