import 'dart:ui';
import 'package:flutter/material.dart' as mat;

import 'package:vnl_common_ui/shadcn_flutter.dart';

// =============================================================================
// VNLThemeExtension — carries VNL design tokens inside Material ThemeData
// =============================================================================

/// Theme extension that carries VNL design tokens inside a Material [ThemeData].
///
/// Access via `context.vnlTheme` or
/// `Theme.of(context).extension<VNLThemeExtension>()`.
class VNLThemeExtension extends mat.ThemeExtension<VNLThemeExtension> {
  /// The VNL color scheme (keeps all VNL property names).
  final ColorScheme colorScheme;

  /// The VNL typography (keeps all VNL property names).
  final Typography typography;

  /// Scale factor for sizes and spacing.
  final double scaling;

  /// Default opacity for surface overlays (0.0 to 1.0).
  final double? surfaceOpacity;

  /// Default blur radius for surface effects.
  final double? surfaceBlur;

  /// VNL density settings that scale spacing and padding.
  final VNLDensity density;

  /// Base radius multiplier for border radius calculations.
  final double radius;

  const VNLThemeExtension({
    required this.colorScheme,
    required this.typography,
    this.scaling = 1.0,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.density = VNLDensity.defaultDensity,
    this.radius = 0.5,
  });

  // -- Density-scaled radius computation --

  double get _densityRadiusScale {
    final base = VNLDensity.defaultDensity.baseContentPadding;
    if (base == 0) return 1;
    return density.baseContentPadding / base;
  }

  /// At normal radius, scaled radius is 24.
  double get radiusXxl => radius * 24 * _densityRadiusScale;

  /// At normal radius, scaled radius is 20.
  double get radiusXl => radius * 20 * _densityRadiusScale;

  /// At normal radius, scaled radius is 16.
  double get radiusLg => radius * 16 * _densityRadiusScale;

  /// At normal radius, scaled radius is 12.
  double get radiusMd => radius * 12 * _densityRadiusScale;

  /// At normal radius, scaled radius is 8.
  double get radiusSm => radius * 8 * _densityRadiusScale;

  /// At normal radius, scaled radius is 4.
  double get radiusXs => radius * 4 * _densityRadiusScale;

  /// BorderRadius.circular([radiusXxl]).
  mat.BorderRadius get borderRadiusXxl => mat.BorderRadius.circular(radiusXxl);

  /// BorderRadius.circular([radiusXl]).
  mat.BorderRadius get borderRadiusXl => mat.BorderRadius.circular(radiusXl);

  /// BorderRadius.circular([radiusLg]).
  mat.BorderRadius get borderRadiusLg => mat.BorderRadius.circular(radiusLg);

  /// BorderRadius.circular([radiusMd]).
  mat.BorderRadius get borderRadiusMd => mat.BorderRadius.circular(radiusMd);

  /// BorderRadius.circular([radiusSm]).
  mat.BorderRadius get borderRadiusSm => mat.BorderRadius.circular(radiusSm);

  /// BorderRadius.circular([radiusXs]).
  mat.BorderRadius get borderRadiusXs => mat.BorderRadius.circular(radiusXs);

  /// Radius.circular([radiusXxl]).
  mat.Radius get radiusXxlRadius => mat.Radius.circular(radiusXxl);

  /// Radius.circular([radiusXl]).
  mat.Radius get radiusXlRadius => mat.Radius.circular(radiusXl);

  /// Radius.circular([radiusLg]).
  mat.Radius get radiusLgRadius => mat.Radius.circular(radiusLg);

  /// Radius.circular([radiusMd]).
  mat.Radius get radiusMdRadius => mat.Radius.circular(radiusMd);

  /// Radius.circular([radiusSm]).
  mat.Radius get radiusSmRadius => mat.Radius.circular(radiusSm);

  /// Radius.circular([radiusXs]).
  mat.Radius get radiusXsRadius => mat.Radius.circular(radiusXs);

  // -- ThemeExtension contract --

  @override
  VNLThemeExtension copyWith({
    ColorScheme? colorScheme,
    Typography? typography,
    double? scaling,
    double? surfaceOpacity,
    double? surfaceBlur,
    VNLDensity? density,
    double? radius,
  }) {
    return VNLThemeExtension(
      colorScheme: colorScheme ?? this.colorScheme,
      typography: typography ?? this.typography,
      scaling: scaling ?? this.scaling,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
      density: density ?? this.density,
      radius: radius ?? this.radius,
    );
  }

  @override
  VNLThemeExtension lerp(
    covariant VNLThemeExtension other,
    double t,
  ) {
    return VNLThemeExtension(
      colorScheme: ColorScheme.lerp(colorScheme, other.colorScheme, t),
      typography: Typography.lerp(typography, other.typography, t),
      scaling: lerpDouble(scaling, other.scaling, t) ?? scaling,
      surfaceOpacity:
          lerpDouble(surfaceOpacity, other.surfaceOpacity, t),
      surfaceBlur: lerpDouble(surfaceBlur, other.surfaceBlur, t),
      density: VNLDensity.lerp(density, other.density, t),
      radius: lerpDouble(radius, other.radius, t) ?? radius,
    );
  }
}

// =============================================================================
// BuildContext extension — shorthand access
// =============================================================================

/// Shorthand access to [VNLThemeExtension] from a [BuildContext].
///
/// Usage:
/// ```dart
/// final bg = context.vnlTheme.colorScheme.background;
/// final h1 = context.vnlTheme.typography.h1;
/// final radius = context.vnlTheme.radiusMd;
/// ```
extension VNLThemeAccess on BuildContext {
  /// Returns the [VNLThemeExtension] registered in the nearest Material [Theme].
  VNLThemeExtension get vnlTheme {
    final ext = mat.Theme.of(this).extension<VNLThemeExtension>();
    assert(ext != null, 'VNLThemeExtension not found in Theme. '
        'Make sure to add it to ThemeData.extensions.');
    return ext!;
  }
}

// =============================================================================
// Internal: VNL → Material mapping
// =============================================================================

/// Maps a VNL [ColorScheme] to a Material [ColorScheme].
///
/// Internal use only — consumer code keeps using VNL [ColorScheme] properties.
mat.ColorScheme _mapVnlToMaterialColorScheme(ColorScheme cs) {
  return mat.ColorScheme(
    brightness: cs.brightness,
    primary: cs.primary,
    onPrimary: cs.primaryForeground,
    secondary: cs.secondary,
    onSecondary: cs.secondaryForeground,
    tertiary: cs.accent,
    onTertiary: cs.accentForeground,
    error: cs.destructive,
    onError: cs.destructiveForeground,
    surface: cs.background,
    onSurface: cs.foreground,
    surfaceContainerHighest: cs.muted,
    onSurfaceVariant: cs.mutedForeground,
    outline: cs.border,
    surfaceContainer: cs.card,
    surfaceContainerHigh: cs.popover,
    // ring, input, chart colors have no direct Material equivalent —
    // they are accessed through VNLThemeExtension.
  );
}

/// Maps a VNL [Typography] to a Material [TextTheme].
///
/// Internal use only — consumer code keeps using VNL [Typography] properties.
mat.TextTheme _mapVnlToMaterialTextTheme(
  Typography typo,
  Color foreground,
) {
  return mat.TextTheme(
    displayLarge: typo.h1,
    displayMedium: typo.h2,
    displaySmall: typo.h3,
    headlineMedium: typo.h4,
    titleLarge: typo.lead,
    titleMedium: typo.textLarge,
    titleSmall: typo.large,
    bodyLarge: typo.p,
    bodyMedium: typo.base,
    bodySmall: typo.textSmall,
    labelLarge: typo.normal,
    labelMedium: typo.small,
    labelSmall: typo.xSmall,
  ).apply(
    fontFamily: typo.sans.fontFamily,
    displayColor: foreground,
    bodyColor: foreground,
  );
}

/// Converts a VNL [ThemeData] to a Material [ThemeData].
///
/// This is the bridge function that creates a Material theme carrying
/// the VNL design tokens via [VNLThemeExtension].
mat.ThemeData vnlToMaterialTheme(ThemeData vnlTheme) {
  final vnlColorScheme = vnlTheme.colorScheme;
  final vnlTypography = vnlTheme.typography;
  final scaling = vnlTheme.scaling;

  final matColorScheme = _mapVnlToMaterialColorScheme(vnlColorScheme);
  // Do NOT apply VNL scaling to Material textTheme — VNL components
  // handle their own scaling internally. Material widgets should use
  // the base VNL sizes.
  final matTextTheme =
      _mapVnlToMaterialTextTheme(vnlTypography, vnlColorScheme.foreground);
  return mat.ThemeData(
    brightness: vnlColorScheme.brightness,
    colorScheme: matColorScheme,
    textTheme: matTextTheme,
    useMaterial3: true,
    scaffoldBackgroundColor: vnlColorScheme.background,
    visualDensity: vnlTheme.density.materialVisualDensity,
    inputDecorationTheme: mat.InputDecorationTheme(
      border: mat.OutlineInputBorder(
        borderRadius: BorderRadius.circular(vnlTheme.radiusMd),
        borderSide: BorderSide(color: vnlColorScheme.border),
      ),
      enabledBorder: mat.OutlineInputBorder(
        borderRadius: BorderRadius.circular(vnlTheme.radiusMd),
        borderSide: BorderSide(color: vnlColorScheme.border),
      ),
      focusedBorder: mat.OutlineInputBorder(
        borderRadius: BorderRadius.circular(vnlTheme.radiusMd),
        borderSide: BorderSide(color: vnlColorScheme.ring),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: vnlTheme.density.baseContentPadding * scaling * 0.75,
        vertical: vnlTheme.density.baseContentPadding * scaling * 0.5,
      ),
      isDense: true,
    ),
    extensions: <mat.ThemeExtension<dynamic>>[
      VNLThemeExtension(
        colorScheme: vnlColorScheme,
        typography: vnlTypography,
        scaling: scaling,
        surfaceOpacity: vnlTheme.surfaceOpacity,
        surfaceBlur: vnlTheme.surfaceBlur,
        density: vnlTheme.density,
        radius: vnlTheme.radius,
      ),
    ],
  );
}

// =============================================================================
// VNLDensity → VisualDensity mapping
// =============================================================================

/// Maps VNL density values to Material [VisualDensity].
extension VNLDensityMaterial on VNLDensity {
  /// Converts this [VNLDensity] to a Material [VisualDensity].
  ///
  /// The conversion is based on the ratio of [baseContentPadding] to
  /// [VNLDensity.defaultDensity]'s base content padding (16.0):
  /// - ratio 0.5 (compact, 8px) → VisualDensity -2
  /// - ratio 0.75 (reduced, 12px) → VisualDensity -1
  /// - ratio 1.0 (default, 16px) → VisualDensity 0 (standard)
  /// - ratio 1.25 (spacious, 20px) → VisualDensity +1
  mat.VisualDensity get materialVisualDensity {
    final base = VNLDensity.defaultDensity.baseContentPadding;
    if (base == 0) return mat.VisualDensity.standard;
    final ratio = baseContentPadding / base;
    // Scale: 0.5→-2, 0.75→-1, 1.0→0, 1.25→1, clamped -4..4
    final value = ((ratio - 1.0) * 4.0).clamp(-4.0, 4.0);
    return mat.VisualDensity(
      horizontal: value,
      vertical: value,
    );
  }
}
