import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/services.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class MenubarTile extends StatelessWidget implements IComponentPage {
  const MenubarTile({super.key});

  @override
  String get title => 'VNLMenubar';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      title: 'VNLMenubar',
      name: 'menubar',
      scale: 1,
      example: VNLCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            VNLOutlinedContainer(
              borderColor: theme.colorScheme.border,
              backgroundColor: theme.colorScheme.background,
              borderRadius: theme.borderRadiusMd,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VNLButton(
                        onPressed: () {},
                        style: const VNLButtonStyle.menubar(),
                        child: const Text('File'),
                      ),
                      VNLButton(
                        onPressed: () {},
                        style: const VNLButtonStyle.menubar().copyWith(
                          decoration: (context, states, value) {
                            return (value as BoxDecoration).copyWith(
                              color: theme.colorScheme.accent,
                              borderRadius:
                                  BorderRadius.circular(theme.radiusSm),
                            );
                          },
                        ),
                        child: const Text('Edit'),
                      ),
                      VNLButton(
                        onPressed: () {},
                        style: const VNLButtonStyle.menubar(),
                        child: const Text('View'),
                      ),
                      VNLButton(
                        onPressed: () {},
                        style: const VNLButtonStyle.menubar(),
                        child: const Text('Help'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(4),
            Container(
              width: 192,
              margin: const EdgeInsets.only(left: 48),
              child: VNLMenuPopup(children: [
                VNLButton(
                  style: const VNLButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const VNLMenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyZ, control: true),
                  ),
                  child: const Text('Undo'),
                ),
                VNLButton(
                  style: const VNLButtonStyle.menu().copyWith(
                      decoration: (context, states, value) {
                    return (value as BoxDecoration).copyWith(
                      color: theme.colorScheme.accent,
                      borderRadius: BorderRadius.circular(theme.radiusSm),
                    );
                  }),
                  onPressed: () {},
                  trailing: const VNLMenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyY, control: true),
                  ),
                  child: const Text('Redo'),
                ),
                const VNLMenuDivider(),
                VNLButton(
                  style: const VNLButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const VNLMenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyX, control: true),
                  ),
                  child: const Text('Cut'),
                ),
                VNLButton(
                  style: const VNLButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const VNLMenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyC, control: true),
                  ),
                  child: const Text('Copy'),
                ),
                VNLButton(
                  style: const VNLButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const VNLMenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyV, control: true),
                  ),
                  child: const Text('Paste'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
