import 'package:vnl_common_ui/shadcn_flutter.dart';

// Demonstrates an "expandable" navigation rail that can collapse/expand labels
// while keeping the same selection model. The left rail hosts sections and items;
// the right side is just an empty content area for demo framing.

class ExpandableSidebarExample1 extends StatefulWidget {
  const ExpandableSidebarExample1({super.key});

  @override
  State<ExpandableSidebarExample1> createState() =>
      _ExpandableSidebarExample1State();
}

class _ExpandableSidebarExample1State extends State<ExpandableSidebarExample1> {
  // When true, the rail expands to show labels; when false, it collapses to
  // an icon-only sidebar.
  bool expanded = false;

  String selected = 'Home';

  VNLNavigationItem buildButton(String text, IconData icon) {
    // Convenience factory for a selectable navigation item with left alignment
    // and a primary icon style when selected.
    return VNLNavigationItem(
      label: Text(text),
      // alignment: Alignment.centerLeft,
      selectedStyle: const VNLButtonStyle.primaryIcon(),
      selected: selected == text,
      onChanged: (selected) {
        if (selected) {
          setState(() {
            this.selected = text;
          });
        }
      },
      child: Icon(icon),
    );
  }

  VNLNavigationGroup buildLabel(String label, List<Widget> children) {
    // Section header used to group related navigation items.
    return VNLNavigationGroup(
      labelAlignment: Alignment.centerLeft,
      label: Text(label).semiBold.muted.xSmall,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return VNLOutlinedContainer(
      // Frame the example and fix a size so expansion is obvious.
      height: 600,
      width: 800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VNLNavigationRail(
            backgroundColor: theme.colorScheme.accent.withValues(alpha: 0.4),
            // Expand/collapse behavior is handled by the `expanded` boolean.
            // With labelType.expanded, labels are hidden when collapsed.
            labelType: VNLNavigationLabelType.expanded,
            labelPosition: VNLNavigationLabelPosition.end,
            alignment: VNLNavigationRailAlignment.start,
            expandedSize: 250,
            expanded: expanded,
            header: [
              Builder(builder: (context) {
                return VNLNavigationSlot(
                  leading: VNLIconContainer(
                    backgroundColor: VNLColors.blue,
                    icon: const Icon(LucideIcons.galleryVerticalEnd).iconMedium,
                  ),
                  title: const Text('Acme Inc').medium.small,
                  subtitle: const Text('Enterprise').xSmall.normal,
                  trailing: const Icon(LucideIcons.chevronsUpDown).iconSmall,
                  onPressed: () {
                    showDropdown(
                        context: context,
                        anchorAlignment: AlignmentDirectional.centerEnd,
                        alignment: AlignmentDirectional.centerStart,
                        offset: const Offset(16, 0),
                        builder: (context) {
                          return VNLDropdownMenu(children: [
                            VNLMenuButton(
                                leading: const Icon(Icons.person),
                                child: const Text('Profile'),
                                onPressed: (ctx) {}),
                            VNLMenuButton(
                                leading: const Icon(Icons.settings),
                                child: const Text('Settings'),
                                onPressed: (ctx) {}),
                            const VNLMenuDivider(),
                            VNLMenuButton(
                                leading: const Icon(Icons.logout),
                                child: const Text('Logout'),
                                onPressed: (ctx) {}),
                          ]);
                        });
                  },
                );
              }),
            ],
            footer: [
              VNLNavigationSlot(
                leading: VNLAvatar(
                  size: 32,
                  initials: 'SU',
                  backgroundColor: VNLColors.green.shade800,
                ),
                title: const Text('sunarya-thito').medium.small,
                subtitle: const Text('m@gmail.com').xSmall.normal,
                trailing: const Icon(LucideIcons.chevronsUpDown).iconSmall,
                onPressed: () {},
              ),
            ],
            children: [
              buildLabel('You', [
                buildButton('Home', Icons.home_filled),
                buildButton('Trending', Icons.trending_up),
                buildButton('Subscription', Icons.subscriptions),
              ]),
              const VNLNavigationDivider(),
              VNLNavigationCollapsible(
                leading: const Icon(Icons.history),
                label: const Text('History'),
                children: [
                  buildButton('History', Icons.history),
                  buildButton('Watch Later', Icons.access_time_rounded),
                ],
              ),
              const VNLNavigationDivider(),
              buildLabel('Movie', [
                buildButton('Action', Icons.movie_creation_outlined),
                buildButton('Horror', Icons.movie_creation_outlined),
                buildButton('Thriller', Icons.movie_creation_outlined),
              ]),
              const VNLNavigationDivider(),
              VNLNavigationCollapsible(
                leading: const Icon(Icons.movie_filter_outlined),
                label: const Text('Short Films'),
                children: [
                  buildButton('Action', Icons.movie_creation_outlined),
                  buildButton('Horror', Icons.movie_creation_outlined),
                ],
              ),
            ],
          ),
          const VNLVerticalDivider(),
          // Placeholder for the main content area.
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VNLIconButton.ghost(
                    onPressed: () {
                      setState(() {
                        // VNLToggle between expanded and collapsed rail.
                        expanded = !expanded;
                      });
                    },
                    icon: const Icon(LucideIcons.panelLeft),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
