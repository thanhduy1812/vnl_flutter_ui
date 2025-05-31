import 'package:docs/pages/docs_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class VNLColorsPage extends StatefulWidget {
  const VNLColorsPage({super.key});

  @override
  _VNLColorsPageState createState() => _VNLColorsPageState();
}

class _VNLColorsPageState extends State<VNLColorsPage> {
  Map<String, ColorShades> shadeMap = {
    'Slate': VNLColors.slate,
    'Gray': VNLColors.gray,
    'Zinc': VNLColors.zinc,
    'Neutral': VNLColors.neutral,
    'Stone': VNLColors.stone,
    'Red': VNLColors.red,
    'Orange': VNLColors.orange,
    'Amber': VNLColors.amber,
    'Yellow': VNLColors.yellow,
    'Lime': VNLColors.lime,
    'Green': VNLColors.green,
    'Emerald': VNLColors.emerald,
    'Teal': VNLColors.teal,
    'Cyan': VNLColors.cyan,
    'Sky': VNLColors.sky,
    'Blue': VNLColors.blue,
    'Indigo': VNLColors.indigo,
    'Violet': VNLColors.violet,
    'Purple': VNLColors.purple,
    'Fuchsia': VNLColors.fuchsia,
    'Pink': VNLColors.pink,
    'Rose': VNLColors.rose,
  };

  final OnThisPage _predefinedVNLColorsKey = OnThisPage();
  final OnThisPage _customColorKey = OnThisPage();

  HSLColor _customColor = VNLColors.red.toHSL();
  static const _defaultHueShift = 0;
  static const _defaultSaturationStepUp = 0;
  static const _defaultSaturationStepDown = 0;
  static const _defaultLightnessStepUp = 8;
  static const _defaultLightnessStepDown = 9;

  int _hueShift = 0;
  int _saturationStepUp = 0;
  int _saturationStepDown = 0;
  int _lightnessStepUp = 8;
  int _lightnessStepDown = 9;
  int _tabIndex = 0;

  int? _hoverIndex;

  void _onTap(String name, ColorShades swatch, int shade) {
    showDialog(
      context: context,
      builder: (context) {
        final theme = VNLTheme.of(context);
        return VNLAlertDialog(
          title: Text(name),
          leading: Container(
            width: 96,
            height: 112,
            decoration: BoxDecoration(
              color: swatch[shade],
              borderRadius: theme.borderRadiusMd,
            ),
          ),
          content: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Use this code to display this color:'),
                const Gap(8),
                CodeSnippet(
                  code: shade == 500 ? 'VNLColors.${name.toLowerCase()}' : 'VNLColors.${name.toLowerCase()}[$shade]',
                  mode: 'dart',
                ),
              ],
            ),
          ),
          actions: [
            VNLPrimaryButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget buildColorRow(BuildContext context, String name, ColorShades swatch, [bool clickable = true]) {
    final theme = VNLTheme.of(context);
    List<Widget> children = [];
    for (int shade in ColorShades.shadeValues) {
      children.add(
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 16 / 19,
                child: Clickable(
                  enabled: clickable,
                  mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
                  onPressed: () {
                    _onTap(name, swatch, shade);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: swatch[shade],
                      borderRadius: theme.borderRadiusMd,
                      border: shade == 500
                          ? Border.all(
                              width: 3, color: theme.colorScheme.foreground, strokeAlign: BorderSide.strokeAlignOutside)
                          : null,
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Text(
                '${shade == 500 ? '500 (Base)' : shade}',
                textAlign: TextAlign.center,
              ).xSmall().mono().muted(),
            ],
          ),
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ).gap(8);
  }

  Widget buildEditableColorRow(BuildContext context, String name, ColorShades swatch) {
    final theme = VNLTheme.of(context);
    List<Widget> children = [];
    var shadeValues = ColorShades.shadeValues;
    for (int i = 0; i < shadeValues.length; i++) {
      final shade = shadeValues[i];
      children.add(
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 16 / 19,
                child: Builder(builder: (context) {
                  return Clickable(
                    mouseCursor: const WidgetStatePropertyAll(SystemMouseCursors.click),
                    onPressed: () {
                      showColorPicker(
                        context: context,
                        color: ColorDerivative.fromColor(swatch[shade]),
                        offset: const Offset(0, 8),
                        showAlpha: false,
                        onColorChanged: (value) {
                          setState(() {
                            _customColor = ColorShades.shiftHSL(
                              value.toHSLColor(),
                              base: shade,
                              500,
                            );
                          });
                        },
                      );
                    },
                    onHover: (value) {
                      if (value) {
                        setState(() {
                          _hoverIndex = shade;
                        });
                      } else if (_hoverIndex == shade) {
                        setState(() {
                          _hoverIndex = null;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: swatch[shade],
                        borderRadius: theme.borderRadiusMd,
                        border: shade == 500
                            ? Border.all(
                                width: 3,
                                color: theme.colorScheme.foreground,
                                strokeAlign: BorderSide.strokeAlignOutside)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: _hoverIndex == shade,
                        child: Icon(
                          Icons.edit,
                          size: 24,
                          color: swatch[shade].getContrastColor(0.8),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const Gap(8),
              Text(
                '${shade == 500 ? '500 (Base)' : shade}',
                textAlign: TextAlign.center,
              ).xSmall().mono().muted(),
            ],
          ),
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ).gap(8);
  }

  Widget buildCode() {
    return CodeSnippet(
      code: generateCode(ColorShades.fromAccentHSL(
        _customColor,
        hueShift: _hueShift,
        lightnessStepDown: _lightnessStepDown,
        lightnessStepUp: _lightnessStepUp,
        saturationStepDown: _saturationStepDown,
        saturationStepUp: _saturationStepUp,
      )),
      mode: 'dart',
    );
  }

  String generateCode(ColorShades swatch) {
    Map<String, String> named = {};
    if (_hueShift != _defaultHueShift) {
      named['hueShift'] = 'hueShift: $_hueShift';
    }
    if (_saturationStepUp != _defaultSaturationStepUp) {
      named['saturationStepUp'] = 'saturationStepUp: $_saturationStepUp';
    }
    if (_saturationStepDown != _defaultSaturationStepDown) {
      named['saturationStepDown'] = 'saturationStepDown: $_saturationStepDown';
    }
    if (_lightnessStepUp != _defaultLightnessStepUp) {
      named['lightnessStepUp'] = 'lightnessStepUp: $_lightnessStepUp';
    }
    if (_lightnessStepDown != _defaultLightnessStepDown) {
      named['lightnessStepDown'] = 'lightnessStepDown: $_lightnessStepDown';
    }
    String baseColorHex = swatch[500].toHex();
    String code = 'ColorShades.fromAccent(\n'
        '  Color(0x$baseColorHex),\n';
    if (named.isNotEmpty) {
      code += '  ${named.values.join(',\n  ')}\n';
    }
    code += ')';
    return code;
  }

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'colors',
      onThisPage: {
        'Predefined VNLColors': _predefinedVNLColorsKey,
        'Generate Color': _customColorKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('VNLColors').h1(),
          const Text('Color and ColorShades/ColorSwatch constants').lead(),
          const Text('Predefined VNLColors').h2().anchored(_predefinedVNLColorsKey),
          for (final color in shadeMap.entries)
            VNLCard(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(color.key).medium().small()),
                      VNLOutlineButton(
                        onPressed: () {
                          setState(() {
                            _customColor = color.value[500].toHSL();
                            Scrollable.ensureVisible(_customColorKey.currentContext!,
                                duration: kDefaultDuration, alignmentPolicy: ScrollPositionAlignmentPolicy.explicit);
                          });
                        },
                        size: ButtonSize.xSmall,
                        density: ButtonDensity.icon,
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  const Gap(8),
                  buildColorRow(context, color.key, color.value),
                ],
              ),
            ).withMargin(
              top: 32,
            ),
          const Text('Generate Color').h2().anchored(_customColorKey),
          const Gap(32),
          VNLTabList(
            index: _tabIndex,
            onChanged: (value) {
              setState(() {
                _tabIndex = value;
              });
            },
            children: const [
              TabItem(child: Text('Color')),
              TabItem(child: Text('Code')),
            ],
          ),
          const Gap(12),
          Offstage(
            offstage: _tabIndex != 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildColorTab(context),
                const Gap(8),
                _buildColorOptions(context),
              ],
            ),
          ),
          Offstage(
            offstage: _tabIndex != 1,
            child: buildCode(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorTab(BuildContext context) {
    return VNLCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildEditableColorRow(
              context,
              'custom',
              ColorShades.fromAccentHSL(
                _customColor,
                hueShift: _hueShift,
                lightnessStepUp: _lightnessStepDown,
                lightnessStepDown: _lightnessStepUp,
                saturationStepDown: _saturationStepDown,
                saturationStepUp: _saturationStepUp,
              )),
        ],
      ),
    );
  }

  Widget _buildColorOptions(BuildContext context) {
    return VNLCard(
      child: VNLForm(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormField<SliderValue>(
              key: const FormKey(#hueShift),
              label: const Text('Hue Shift'),
              child: VNLSlider(
                value: SliderValue.single(_hueShift.toDouble()),
                min: -360,
                max: 360,
                divisions: 100,
                onChanged: (value) {
                  setState(() {
                    _hueShift = value.value.toInt();
                  });
                },
              ),
            ),
            FormField<SliderValue>(
              key: const FormKey(#saturationStepUp),
              label: const Text('Saturation Step Up'),
              child: VNLSlider(
                value: SliderValue.single(_saturationStepUp.toDouble()),
                min: 0,
                max: 20,
                divisions: 20,
                onChanged: (value) {
                  setState(() {
                    _saturationStepUp = value.value.toInt();
                  });
                },
              ),
            ),
            FormField<SliderValue>(
              key: const FormKey(#saturationStepDown),
              label: const Text('Saturation Step Down'),
              child: VNLSlider(
                value: SliderValue.single(_saturationStepDown.toDouble()),
                min: 0,
                max: 20,
                divisions: 20,
                onChanged: (value) {
                  setState(() {
                    _saturationStepDown = value.value.toInt();
                  });
                },
              ),
            ),
            FormField<SliderValue>(
              key: const FormKey(#lightnessStepUp),
              label: const Text('Lightness Step Up'),
              child: VNLSlider(
                value: SliderValue.single(_lightnessStepUp.toDouble()),
                min: 0,
                max: 20,
                divisions: 20,
                onChanged: (value) {
                  setState(() {
                    _lightnessStepUp = value.value.toInt();
                  });
                },
              ),
            ),
            FormField<SliderValue>(
              key: const FormKey(#lightnessStepDown),
              label: const Text('Lightness Step Down'),
              child: VNLSlider(
                value: SliderValue.single(_lightnessStepDown.toDouble()),
                min: 0,
                max: 20,
                divisions: 20,
                onChanged: (value) {
                  setState(() {
                    _lightnessStepDown = value.value.toInt();
                  });
                },
              ),
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DestructiveButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return VNLAlertDialog(
                          title: const Text('Reset Options'),
                          content: const Text('Are you sure you want to reset the options?'),
                          actions: [
                            VNLPrimaryButton(
                              onPressed: () {
                                setState(() {
                                  _hueShift = _defaultHueShift;
                                  _saturationStepUp = _defaultSaturationStepUp;
                                  _saturationStepDown = _defaultSaturationStepDown;
                                  _lightnessStepUp = _defaultLightnessStepUp;
                                  _lightnessStepDown = _defaultLightnessStepDown;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('Reset'),
                            ),
                            VNLSecondaryButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  leading: const Icon(Icons.restore),
                  child: const Text('Reset'),
                ),
              ],
            )
          ],
        ).gap(8),
      ),
    );
  }
}
