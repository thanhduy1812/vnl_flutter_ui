import 'dart:js_interop';

import 'package:vnl_common_ui/vnl_ui.dart';

@JS("Window")
extension type _Window(JSObject _) implements JSObject {
  // dispatchEvent method
  external void dispatchEvent(JSObject event);

  external _GlobalThis get globalThis;
  external set vnLookAppLoaded(bool value);
}

@JS()
extension type _GlobalThis(JSObject _) implements JSObject {
  external JSObject? get VNLookApp;
}

@JS("Event")
extension type _Event._(JSObject _) implements JSObject {
  external _Event(String type);
}

@JS("window")
external _Window get _window;

@JS('vnLookAppLoaded')
external bool get vnLookAppLoaded;

@JS('vnLookAppLoaded')
external set vnLookAppLoaded(bool value);

@JS('VNLookApp')
external JSObject? get VNLookApp;

@JS("VNLookAppThemeChangedEvent")
extension type _VNLookAppThemeChangedEvent._(JSObject _) implements JSObject {
  external _VNLookAppThemeChangedEvent(_VNLookAppTheme theme);
}

@JS("VNLookAppTheme")
extension type _VNLookAppTheme._(JSObject _) implements JSObject {
  external _VNLookAppTheme(String background, String foreground, String primary);
}

class VNLookPlatformImplementations {
  bool get _isPreloaderAvailable {
    return _window.globalThis.VNLookApp != null;
  }

  void onAppInitialized() {
    if (!_isPreloaderAvailable) {
      return;
    }
    _window.vnLookAppLoaded = true;
    final event = _Event("vnl_ui_app_ready");
    _window.dispatchEvent(event);
  }

  void onThemeChanged(VNLThemeData theme) {
    if (!_isPreloaderAvailable) {
      return;
    }
    final vnLookAppTheme = _VNLookAppTheme(
      _colorToCssRgba(theme.colorScheme.background),
      _colorToCssRgba(theme.colorScheme.foreground),
      _colorToCssRgba(theme.colorScheme.primary),
    );
    final event = _VNLookAppThemeChangedEvent(vnLookAppTheme);
    _window.dispatchEvent(event);
  }
}

String _colorToCssRgba(Color color) {
  return 'rgba(${color.r}, ${color.g}, ${color.b}, ${color.a})';
}
