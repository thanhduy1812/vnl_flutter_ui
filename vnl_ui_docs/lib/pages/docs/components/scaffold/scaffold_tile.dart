import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class ScaffoldTile extends StatelessWidget implements IComponentPage {
  const ScaffoldTile({super.key});

  @override
  String get title => 'VNLScaffold';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'scaffold',
      title: 'VNLScaffold',
      scale: 1.2,
      example: VNLCard(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // VNLAppBar
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu,
                        color: theme.colorScheme.primaryForeground),
                    const Gap(16),
                    Text(
                      'VNLScaffold',
                      style: TextStyle(
                        color: theme.colorScheme.primaryForeground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Body
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('VNLScaffold Body Content'),
                  ),
                ),
              ),
              // Bottom Navigation
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.home),
                    Icon(Icons.search),
                    Icon(Icons.settings),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
