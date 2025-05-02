import 'dart:convert';

import 'package:base_app/app/main_app.dart';
import 'package:gtd_helper/gtd_helper.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

import 'app/app_global_const.dart';
import 'app/theme_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Load app configuration
  loadAppConfig();
  // Initialize the app
  final prefs = CacheHelper.shared.prefs;
  var colorScheme = prefs?.getString('colorScheme');
  VNLColorScheme? initialColorScheme;
  if (colorScheme != null) {
    if (colorScheme.startsWith('{')) {
      initialColorScheme = VNLColorScheme.fromMap(jsonDecode(colorScheme));
    } else {
      initialColorScheme = colorSchemes[colorScheme];
    }
  }
  double initialRadius = prefs?.getDouble('radius') ?? 0.5;
  double initialScaling = prefs?.getDouble('scaling') ?? 1.0;
  double initialSurfaceOpacity = prefs?.getDouble('surfaceOpacity') ?? 1.0;
  double initialSurfaceBlur = prefs?.getDouble('surfaceBlur') ?? 0.0;
  String initialPath = prefs?.getString('initialPath') ?? '/';
  runApp(
    VNLMainApp(
      initialColorScheme: initialColorScheme ?? colorSchemes['lightBlue']!,
      initialRadius: initialRadius,
      initialScaling: initialScaling,
      initialSurfaceOpacity: initialSurfaceOpacity,
      initialSurfaceBlur: initialSurfaceBlur,
      initialPath: kEnablePersistentPath ? initialPath : '/',
    ),
  );
}
