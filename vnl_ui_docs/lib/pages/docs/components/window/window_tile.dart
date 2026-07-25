import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class WindowTile extends StatelessWidget implements IComponentPage {
  const WindowTile({super.key});

  @override
  String get title => 'VNLWindow';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'window',
      title: 'VNLWindow',
      scale: 1.2,
      example: VNLCard(
        child: Container(
          width: 320,
          height: 240,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // VNLWindow title bar
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    // VNLWindow controls
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: VNLColors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: VNLColors.yellow,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: VNLColors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(16),
                    const Text('VNLWindow Title').medium(),
                    const Spacer(),
                    const Icon(Icons.minimize, size: 16),
                    const Gap(8),
                    const Icon(Icons.crop_square, size: 16),
                    const Gap(8),
                    const Icon(Icons.close, size: 16),
                  ],
                ),
              ),
              // VNLWindow content
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('VNLWindow Content Area'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
