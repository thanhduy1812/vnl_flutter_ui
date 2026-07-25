import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class AutocompleteTile extends StatelessWidget implements IComponentPage {
  const AutocompleteTile({super.key});

  @override
  String get title => 'Autocomplete';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'autocomplete',
      title: 'Autocomplete',
      scale: 1.2,
      example: VNLCard(
        child: Column(
          children: [
            const VNLTextField(
              placeholder: Text('Search fruits...'),
              features: [
                VNLInputFeature.trailing(Icon(LucideIcons.search)),
              ],
            ),
            const Gap(8),
            VNLOutlinedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VNLButton(
                    style: const VNLButtonStyle.ghost(),
                    onPressed: () {},
                    child: const Text('Apple'),
                  ),
                  VNLButton(
                    style: const VNLButtonStyle.ghost(),
                    onPressed: () {},
                    child: const Text('Banana'),
                  ),
                  VNLButton(
                    style: const VNLButtonStyle.ghost(),
                    onPressed: () {},
                    child: const Text('Cherry'),
                  ),
                ],
              ),
            ),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
