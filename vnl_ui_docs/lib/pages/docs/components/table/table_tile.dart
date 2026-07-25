import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class TableTile extends StatelessWidget implements IComponentPage {
  const TableTile({super.key});

  @override
  String get title => 'VNLTable';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'table',
      title: 'VNLTable',
      scale: 1.2,
      example: VNLCard(
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: const Text('Name').bold()),
                    Expanded(flex: 2, child: const Text('Role').bold()),
                    Expanded(flex: 1, child: const Text('Status').bold()),
                  ],
                ),
              ),
              // Rows
              Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Expanded(flex: 2, child: Text('John Doe')),
                    const Expanded(flex: 2, child: Text('Developer')),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: VNLColors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('Active',
                            style: TextStyle(color: VNLColors.green)),
                      ),
                    ),
                  ],
                ),
              ),
              const VNLDivider(height: 1),
              Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Expanded(flex: 2, child: Text('Jane Smith')),
                    const Expanded(flex: 2, child: Text('Designer')),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: VNLColors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('Away',
                            style: TextStyle(color: VNLColors.orange)),
                      ),
                    ),
                  ],
                ),
              ),
              const VNLDivider(height: 1),
              Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Expanded(flex: 2, child: Text('Bob Johnson')),
                    const Expanded(flex: 2, child: Text('Manager')),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: VNLColors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('Active',
                            style: TextStyle(color: VNLColors.green)),
                      ),
                    ),
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
