import 'package:vnl_common_ui/vnl_ui.dart';

class NavigationMenuExample1 extends StatelessWidget {
  const NavigationMenuExample1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // VNLNavigationMenu displays a horizontal menu with items that can reveal
    // rich content on hover/press. Each VNLNavigationMenuItem below demonstrates
    // different kinds of content lists and grid layouts.
    return VNLNavigationMenu(
      children: [
        VNLNavigationMenuItem(
          content: VNLNavigationMenuContentList(
            // Reverse places the text/content list before the hero card.
            reverse: true,
            children: [
              VNLNavigationMenuContent(
                title: const Text('Introduction'),
                content: const Text(
                    'Component library for Flutter based on Shadcn/UI design.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('Installation'),
                content: const Text(
                    'How to install this package in your Flutter project.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('Typography'),
                content: const Text(
                    'Styles and usage of typography in this package.'),
                onPressed: () {},
              ),
              VNLClickable(
                mouseCursor:
                    const WidgetStatePropertyAll(SystemMouseCursors.click),
                child: VNLCard(
                  borderRadius: theme.borderRadiusMd,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const FlutterLogo(
                        size: 32,
                      ),
                      const Gap(16),
                      const Text('vnl_flutter_ui').mono().semiBold().large(),
                      const Gap(8),
                      const Text(
                              'Beautifully designed components from Shadcn/UI is now available for Flutter')
                          .muted(),
                    ],
                  ),
                ).constrained(maxWidth: 192),
              ),
            ],
          ),
          child: const Text('Getting started'),
        ),
        VNLNavigationMenuItem(
          content: VNLNavigationMenuContentList(
            children: [
              VNLNavigationMenuContent(
                title: const Text('VNLAccordion'),
                content: const Text('VNLAccordion component for Flutter.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('VNLAlert'),
                content: const Text('VNLAlert component for Flutter.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('VNLAlert Dialog'),
                content: const Text('VNLAlert Dialog component for Flutter.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('Animation'),
                content: const Text('Animation component for Flutter.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('VNLAvatar'),
                content: const Text('VNLAvatar component for Flutter.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('Badge'),
                content: const Text('Badge component for Flutter.'),
                onPressed: () {},
              ),
            ],
          ),
          child: const Text('Components'),
        ),
        VNLNavigationMenuItem(
          content: VNLNavigationMenuContentList(
            // Use a simple 2-column grid for a more "news board" feel.
            crossAxisCount: 2,
            children: [
              // latest news
              VNLNavigationMenuContent(
                title: const Text('Latest news'),
                content: const Text('Stay updated with the latest news.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('Change log'),
                content: const Text('View the change log of this package.'),
                onPressed: () {},
              ),
              VNLNavigationMenuContent(
                title: const Text('Contributors'),
                content: const Text('List of contributors to this package.'),
                onPressed: () {},
              ),
            ],
          ),
          child: const Text('Blog'),
        ),
        VNLNavigationMenuItem(
          onPressed: () {},
          child: const Text('Documentation'),
        ),
      ],
    );
  }
}
