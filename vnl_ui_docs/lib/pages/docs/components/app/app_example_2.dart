import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates VNLookApp with custom light/dark themes.
// Highlights theme knobs like colorScheme, radius, scaling, surfaceOpacity,
// surfaceBlur, and custom typography families.

class AppExample2 extends StatelessWidget {
  const AppExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const VNLookApp(
      theme: ThemeData(
          // Customize light mode colors and design tokens.
          colorScheme: ColorSchemes.lightSlate,
          // Corner radius scale applied across components.
          radius: 0.25,
          // Global size scale multiplier.
          scaling: 1.2,
          // Semi-translucent surfaces with blur create a glassy look.
          surfaceOpacity: 0.8,
          surfaceBlur: 10,
          // Swap default fonts for sans/mono text styles.
          typography: Typography.geist(
            sans: TextStyle(
              fontFamily: 'Inter',
            ),
            mono: TextStyle(
              fontFamily: 'FiraCode',
            ),
          )),
      darkTheme: ThemeData.dark(
          // Mirror customizations for dark mode.
          colorScheme: ColorSchemes.darkSlate,
          radius: 0.25,
          scaling: 1.2,
          surfaceOpacity: 0.8,
          surfaceBlur: 10,
          typography: Typography.geist(
            sans: TextStyle(
              fontFamily: 'Inter',
            ),
            mono: TextStyle(
              fontFamily: 'FiraCode',
            ),
          )),
      home: VNLScaffold(
        headers: [
          VNLAppBar(
            title: Text('Shadcn App Example'),
          ),
          VNLDivider(),
        ],
        child: Center(
          child: Text('Hello, Shadcn Flutter!'),
        ),
      ),
    );
  }
}
