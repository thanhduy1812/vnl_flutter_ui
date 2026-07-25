import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class NavigationMenuTile extends StatelessWidget implements IComponentPage {
  const NavigationMenuTile({super.key});

  @override
  String get title => 'Navigation Menu';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      title: 'Navigation Menu',
      name: 'navigation_menu',
      scale: 1,
      example: VNLCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            VNLNavigationMenu(
              children: [
                VNLButton(
                  onPressed: () {},
                  style: const VNLButtonStyle.ghost().copyWith(
                    decoration: (context, states, value) {
                      return (value as BoxDecoration).copyWith(
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        color: theme.colorScheme.muted.scaleAlpha(0.8),
                      );
                    },
                  ),
                  trailing: const Icon(
                    RadixIcons.chevronUp,
                    size: 12,
                  ),
                  child: const Text('Getting Started'),
                ),
                const VNLNavigationMenuItem(
                  content: SizedBox(),
                  child: Text('Components'),
                ),
              ],
            ),
            const Gap(8),
            VNLOutlinedContainer(
              borderRadius: theme.borderRadiusMd,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: VNLNavigationMenuContentList(
                  children: [
                    VNLButton(
                      style: VNLButtonVariance.ghost.copyWith(
                        padding: (context, states, value) {
                          return const EdgeInsets.all(12);
                        },
                        decoration: (context, states, value) {
                          return (value as BoxDecoration).copyWith(
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                            color: theme.colorScheme.muted.scaleAlpha(0.8),
                          );
                        },
                      ),
                      onPressed: () {},
                      alignment: Alignment.topLeft,
                      child: VNLBasic(
                        title: const Text('Installation').medium(),
                        content:
                            const Text('How to install Shadcn/UI for Flutter')
                                .muted(),
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ).constrained(maxWidth: 16 * 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
