import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class SortableTile extends StatelessWidget implements IComponentPage {
  const SortableTile({super.key});

  @override
  String get title => 'Sortable';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'sortable',
      title: 'Sortable',
      scale: 1.2,
      example: VNLCard(
        child: Column(
          children: [
            const Text('Sortable List:').bold(),
            const Gap(16),
            const Column(
              children: [
                VNLCard(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.drag_handle),
                        Gap(8),
                        Text('Item 1'),
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
                        Icon(Icons.drag_handle),
                        Gap(8),
                        Text('Item 2'),
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
                        Icon(Icons.drag_handle),
                        Gap(8),
                        Text('Item 3'),
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
