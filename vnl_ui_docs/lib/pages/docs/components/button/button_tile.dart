import 'package:vnl_common_ui/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ButtonTile extends StatelessWidget implements IComponentPage {
  const ButtonTile({super.key});

  @override
  String get title => 'VNLButton';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'button',
      title: 'VNLButton',
      scale: 1.5,
      example: SizedBox(
        width: 250,
        child: VNLCard(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              VNLPrimaryButton(
                onPressed: () {},
                child: const Text('Primary'),
              ),
              VNLSecondaryButton(
                onPressed: () {},
                child: const Text('Secondary'),
              ),
              VNLOutlineButton(
                onPressed: () {},
                child: const Text('Outline'),
              ),
              VNLGhostButton(
                onPressed: () {},
                child: const Text('Ghost'),
              ),
              VNLDestructiveButton(
                child: const Text('Destructive'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
