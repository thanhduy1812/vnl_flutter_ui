
class AppRouterPath {
  static const String splash = "splashscreen";
  static const String theme = "theme";
  static const String home = "home";
  static const String login = "login";
  static const String register = "register";
  static const String forgotPassword = "forgot-password";
  static const String profile = "profile";
  static const String settings = "settings";
  static const String about = "about";
  static const String contactUs = "contact-us";
}

class AppRouter {
  String name;
  String path;
  AppRouter({required this.name, required this.path});

  factory AppRouter.withName(String name) {
    return AppRouter(name: name, path: name);
  }
}
