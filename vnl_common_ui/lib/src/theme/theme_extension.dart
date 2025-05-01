import 'package:vnl_common_ui/vnl_ui.dart';

/// Theme extension for [BuildContext]
extension ThemeExtension on BuildContext {
  /// Get the theme data
  VNLThemeData get theme => VNLTheme.of(this);

  /// Get component theme
  T? componentTheme<T>() => ComponentTheme.maybeOf<T>(this);
}
