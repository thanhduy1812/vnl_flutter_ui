import 'package:go_router/go_router.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

// VNLookApp.router example using GoRouter for declarative navigation.
// Defines two routes ('/' and '/about') and renders a simple VNLScaffold for each.

class AppExample3 extends StatelessWidget {
  const AppExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLookApp.router(
      routerConfig: GoRouter(routes: [
        GoRoute(
          path: '/',
          // Home page with VNLAppBar and greeting text.
          builder: (context, state) => const VNLScaffold(
            headers: [
              VNLAppBar(
                title: Text('Shadcn App Example with GoRouter'),
              ),
              VNLDivider(),
            ],
            child: Center(
              child: Text('Hello, Shadcn Flutter with GoRouter!'),
            ),
          ),
        ),
        GoRoute(
          path: '/about',
          // About page demonstrates a second route.
          builder: (context, state) => const VNLScaffold(
            headers: [
              VNLAppBar(
                title: Text('About Page'),
              ),
              VNLDivider(),
            ],
            child: Center(
              child: Text('This is the about page.'),
            ),
          ),
        ),
      ]),
      theme: const ThemeData(
        colorScheme: ColorSchemes.lightSlate,
      ),
      darkTheme: const ThemeData.dark(
        colorScheme: ColorSchemes.darkSlate,
      ),
    );
  }
}
