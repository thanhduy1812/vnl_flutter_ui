import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class ChipTile extends StatelessWidget implements IComponentPage {
  const ChipTile({super.key});

  @override
  String get title => 'VNLChip';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'chip',
      title: 'VNLChip',
      scale: 1.5,
      example: VNLCard(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            VNLChip(
              child: const Text('Default'),
              onPressed: () {},
            ),
            VNLChip(
              leading: const Icon(LucideIcons.user),
              child: const Text('With Icon'),
              onPressed: () {},
            ),
            VNLChip(
              trailing: const Icon(LucideIcons.x),
              onPressed: () {},
              child: const Text('Removable'),
            ),
            const VNLChip(
              child: Text('Disabled'),
            ),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
