// Docs page scaffold and navigation structure.
//
// Provides the high-level layout for documentation pages, including:
// - Sidebar sections and pages (DocsPageState.sections) with routing names.
// - On-this-page anchors with visibility tracking for in-page nav.
// - Optional scrollability and per-page navigation items.
//
// This is part of the docs framework (a wrapper/renderer), not a component demo.
// Comments added for clarity; behavior unchanged.
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../main.dart';
import 'docs/sidebar_nav.dart';

const double breakpointWidth = 768;
const double breakpointWidth2 = 1024;

extension CustomWidgetExtension on Widget {
  Widget anchored(OnThisPage onThisPage) {
    return PageItemWidget(
      onThisPage: onThisPage,
      child: this,
    );
  }
}

void openInNewTab(String url) {
  launchUrlString(url);
}

class OnThisPage extends LabeledGlobalKey {
  final ValueNotifier<bool> isVisible = ValueNotifier(false);

  OnThisPage([super.debugLabel]);
}

class PageItemWidget extends StatelessWidget {
  final OnThisPage onThisPage;
  final Widget child;

  const PageItemWidget({
    super.key,
    required this.onThisPage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: onThisPage,
      child: child,
      onVisibilityChanged: (info) {
        onThisPage.isVisible.value = info.visibleFraction >= 1;
      },
    );
  }
}

class DocsPage extends StatefulWidget {
  final String name;
  final Widget child;
  final Map<String, OnThisPage> onThisPage;
  final List<Widget> navigationItems;
  final bool scrollable;
  const DocsPage({
    super.key,
    required this.name,
    required this.child,
    this.onThisPage = const {},
    this.navigationItems = const [],
    this.scrollable = true,
  });

  @override
  DocsPageState createState() => DocsPageState();
}

enum VNLFeatureTag {
  newFeature,
  updated,
  experimental,
  workInProgress;

  Widget buildBadge(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ThemeData copy;
    String badgeText;
    switch (this) {
      case VNLFeatureTag.newFeature:
        copy = theme.copyWith(
          colorScheme: () => theme.colorScheme.copyWith(
            primary: () => VNLColors.green,
          ),
        );
        badgeText = 'New';
        break;
      case VNLFeatureTag.updated:
        copy = theme.copyWith(
          colorScheme: () => theme.colorScheme.copyWith(
            primary: () => VNLColors.blue,
          ),
        );
        badgeText = 'Updated';
        break;
      case VNLFeatureTag.workInProgress:
        copy = theme.copyWith(
          colorScheme: () => theme.colorScheme.copyWith(
            primary: () => VNLColors.orange,
          ),
        );
        badgeText = 'WIP';
        break;
      case VNLFeatureTag.experimental:
        copy = theme.copyWith(
          colorScheme: () => theme.colorScheme.copyWith(
            primary: () => VNLColors.purple,
          ),
        );
        badgeText = 'Experimental';
        break;
    }
    return Theme(
      data: copy,
      child: VNLPrimaryBadge(
        child: Text(badgeText),
      ),
    );
  }
}

class VNLDocsPage {
  final String title;
  final String name; // name for go_router
  final VNLFeatureTag? tag;

  VNLDocsPage(this.title, this.name, [this.tag]);
}

class VNLDocsSection {
  final String title;
  final List<VNLDocsPage> pages;
  final IconData icon;

  VNLDocsSection(this.title, this.pages, [this.icon = Icons.book]);
}

class DocsPageState extends State<DocsPage> {
  static final List<VNLDocsSection> sections = [
    VNLDocsSection(
        'Getting Started',
        List.unmodifiable([
          VNLDocsPage('Introduction', 'introduction'),
          VNLDocsPage('Installation', 'installation'),
          VNLDocsPage('Theme', 'theme'),
          VNLDocsPage('Typography', 'typography'),
          VNLDocsPage('Layout', 'layout'),
          VNLDocsPage('Web Preloader', 'web_preloader'),
          VNLDocsPage('Components', 'components'),
          VNLDocsPage('Icons', 'icons'),
          VNLDocsPage('Colors', 'colors'),
          VNLDocsPage('Material/Cupertino', 'external'),
          VNLDocsPage('State Management', 'state'),
        ]),
        Icons.book),
    // COMPONENTS BEGIN
    VNLDocsSection(
      'Application',
      [
        VNLDocsPage('App Example', 'app'),
        VNLDocsPage('GoRouter Example', 'go_router_app_example'),
        VNLDocsPage('VNLLayer', 'wrapper'),
      ],
    ),
    VNLDocsSection(
      'Animation',
      [
        VNLDocsPage('Animated Value', 'animated_value_builder'),
        // https://nyxbui.design/docs/components/number-ticker
        VNLDocsPage('Number Ticker', 'number_ticker'),
        VNLDocsPage('Repeated Animation', 'repeated_animation_builder'),
        VNLDocsPage('VNLTimeline Animation', 'timeline_animation'),
      ],
    ),
    VNLDocsSection('Control', [
      VNLDocsPage('VNLButton', 'button'),
      VNLDocsPage(
          'Audio Control', 'audio_control', VNLFeatureTag.workInProgress),
      VNLDocsPage(
          'Video Control', 'video_control', VNLFeatureTag.workInProgress),
    ]),
    VNLDocsSection(
      'Disclosure',
      [
        VNLDocsPage('VNLAccordion', 'accordion'),
        VNLDocsPage('VNLCollapsible', 'collapsible'),
      ],
    ),
    VNLDocsSection(
      'Display',
      [
        VNLDocsPage('VNLAvatar', 'avatar'),
        VNLDocsPage('VNLAvatarGroup', 'avatar_group'),
        VNLDocsPage('VNLCodeSnippet', 'code_snippet'),
        VNLDocsPage('VNLChatBubble', 'chat', VNLFeatureTag.newFeature),
        VNLDocsPage('VNLTable', 'table'),
        VNLDocsPage('VNLTracker', 'tracker'),
      ],
    ),
    VNLDocsSection(
      'Feedback',
      [
        VNLDocsPage('VNLAlert', 'alert'),
        VNLDocsPage('VNLAlertDialog', 'alert_dialog'),
        VNLDocsPage('VNLCircularProgress', 'circular_progress'),
        VNLDocsPage('VNLProgress', 'progress'),
        VNLDocsPage('VNLLinearProgress', 'linear_progress'),
        VNLDocsPage('VNLSkeleton', 'skeleton'),
        VNLDocsPage('VNLToast', 'toast'),
      ],
    ),
    VNLDocsSection(
      'VNLForm',
      [
        VNLDocsPage('VNLCheckbox', 'checkbox'),
        VNLDocsPage('VNLChipInput', 'chip_input'),
        VNLDocsPage('VNLColorPicker', 'color_picker'),
        VNLDocsPage('VNLLinearGradientPicker', 'linear_gradient_picker',
            VNLFeatureTag.workInProgress),
        VNLDocsPage('VNLRadialGradientPicker', 'radial_gradient_picker',
            VNLFeatureTag.workInProgress),
        VNLDocsPage('VNLSweepGradientPicker', 'sweep_gradient_picker',
            VNLFeatureTag.workInProgress),
        VNLDocsPage('VNLDatePicker', 'date_picker'),
        VNLDocsPage('VNLForm', 'form'),
        VNLDocsPage('VNLFormattedInput', 'formatted_input'),
        VNLDocsPage('VNLTextInput', 'input'),
        VNLDocsPage('VNLAutoComplete', 'autocomplete'),
        VNLDocsPage('VNLNumberInput', 'number_input'),
        VNLDocsPage('VNLInputOTP', 'input_otp'),
        VNLDocsPage('VNLPhoneInput', 'phone_input'),
        VNLDocsPage('VNLRadioGroup', 'radio_group'),
        VNLDocsPage('VNLRadioCard', 'radio_card'),
        VNLDocsPage('VNLSelect', 'select'),
        VNLDocsPage('VNLSlider', 'slider'),
        VNLDocsPage('VNLStarRating', 'star_rating'),
        VNLDocsPage('VNLSwitch', 'switch'),
        VNLDocsPage('VNLTextArea', 'text_area'),
        VNLDocsPage('VNLTimePicker', 'time_picker'),
        VNLDocsPage('VNLToggle', 'toggle'),
        VNLDocsPage('VNLMultiSelect', 'multiselect'),
        VNLDocsPage('VNLItemPicker', 'item_picker'),
      ],
    ),
    VNLDocsSection(
      'Layout',
      [
        VNLDocsPage('VNLCard', 'card'),
        VNLDocsPage('VNLCarousel', 'carousel'),
        VNLDocsPage('VNLDivider', 'divider'),
        VNLDocsPage('VNLResizable', 'resizable'),
        VNLDocsPage('VNLSortable', 'sortable'),
        VNLDocsPage('VNLSteps', 'steps'),
        VNLDocsPage('VNLStepper', 'stepper'),
        VNLDocsPage('VNLTimeline', 'timeline'),
        VNLDocsPage('VNLScaffold', 'scaffold'),
        VNLDocsPage('VNLAppBar', 'app_bar'),
        VNLDocsPage('VNLCardImage', 'card_image'),
      ],
    ),
    VNLDocsSection(
      'Navigation',
      [
        VNLDocsPage('VNLBreadcrumb', 'breadcrumb'),
        VNLDocsPage('VNLMenubar', 'menubar'),
        VNLDocsPage('VNLNavigationMenu', 'navigation_menu'),
        VNLDocsPage('VNLPagination', 'pagination'),
        VNLDocsPage('VNLTabs', 'tabs'),
        VNLDocsPage('VNLTabList', 'tab_list'),
        VNLDocsPage('VNLTabPane', 'tab_pane'),
        VNLDocsPage('VNLTreeView', 'tree'),
        // aka Bottom Navigation Bar
        VNLDocsPage('VNLNavigationBar', 'navigation_bar'),
        VNLDocsPage('VNLNavigationRail', 'navigation_rail'),
        VNLDocsPage('VNLExpandableSidebar', 'expandable_sidebar'),
        // aka Drawer
        VNLDocsPage('VNLNavigationSidebar', 'navigation_sidebar'),
        VNLDocsPage('VNLDotIndicator', 'dot_indicator'),
        //
        VNLDocsPage('VNLSwitcher', 'switcher'),
      ],
    ),
    VNLDocsSection(
      'Overlay',
      [
        VNLDocsPage('VNLDialog', 'dialog'),
        VNLDocsPage('VNLDrawer', 'drawer'),
        VNLDocsPage('VNLHoverCard', 'hover_card'),
        VNLDocsPage('VNLPopover', 'popover'),
        VNLDocsPage('VNLSheet', 'sheet'),
        VNLDocsPage('VNLSwiper', 'swiper'),
        VNLDocsPage('VNLTooltip', 'tooltip'),
        VNLDocsPage('VNLWindow', 'window', VNLFeatureTag.experimental),
      ],
    ),

    VNLDocsSection(
      'Utility',
      [
        VNLDocsPage('VNLBadge', 'badge'),
        VNLDocsPage('VNLChip', 'chip'),
        VNLDocsPage('VNLCalendar', 'calendar'),
        VNLDocsPage('VNLCommand', 'command'),
        VNLDocsPage('VNLContextMenu', 'context_menu'),
        VNLDocsPage('VNLDropdownMenu', 'dropdown_menu'),
        VNLDocsPage('VNLKeyboardDisplay', 'keyboard_display'),
        VNLDocsPage('VNLRefreshTrigger', 'refresh_trigger'),
        VNLDocsPage('VNLOverflowMarquee', 'overflow_marquee'),
      ],
    ),
    // COMPONENTS END
  ];

  List<String> componentCategories = [
    'Animation',
    'Disclosure',
    'Feedback',
    'Control',
    'VNLForm',
    'Layout',
    'Navigation',
    'Overlay',
    'Display',
    'Utility',
  ];
  bool toggle = false;
  List<OnThisPage> currentlyVisible = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    for (final child in widget.onThisPage.values) {
      child.isVisible.addListener(_onVisibilityChanged);
    }
    // count compoents
    int count = 0;
    int workInProgress = 0;
    for (var section in sections) {
      if (componentCategories.contains(section.title)) {
        count += section.pages.length;
        for (var page in section.pages) {
          if (page.tag == VNLFeatureTag.workInProgress) {
            workInProgress++;
          }
        }
      }
    }
    // sort every components category
    for (var section in sections) {
      if (componentCategories.contains(section.title)) {
        section.pages.sort((a, b) => a.title.compareTo(b.title));
      }
    }
    if (kDebugMode) {
      print('Total components: $count');
      print('Work in VNLProgress: $workInProgress');
    }
  }

  @override
  void didUpdateWidget(covariant DocsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!mapEquals(oldWidget.onThisPage, widget.onThisPage)) {
      for (final child in widget.onThisPage.values) {
        child.isVisible.addListener(_onVisibilityChanged);
      }
    }
  }

  @override
  void dispose() {
    for (final child in widget.onThisPage.values) {
      child.isVisible.removeListener(_onVisibilityChanged);
    }
    super.dispose();
  }

  void _onVisibilityChanged() {
    if (!mounted) return;
    setState(() {
      currentlyVisible = widget.onThisPage.values
          .where((element) => element.isVisible.value)
          .toList();
    });
  }

  bool isVisible(OnThisPage onThisPage) {
    return currentlyVisible.isNotEmpty && currentlyVisible[0] == onThisPage;
  }

  void showSearchBar() {
    showCommandDialog(
      context: context,
      builder: (context, query) async* {
        for (final section in sections) {
          final List<Widget> resultItems = [];
          for (final page in section.pages) {
            if (query == null ||
                page.title.toLowerCase().contains(query.toLowerCase())) {
              resultItems.add(VNLCommandItem(
                title: Text(page.title),
                trailing: Icon(section.icon),
                onTap: () {
                  context.goNamed(page.name);
                },
              ));
            }
          }
          if (resultItems.isNotEmpty) {
            yield [
              VNLCommandCategory(
                title: Text(section.title),
                children: resultItems,
              ),
            ];
          }
        }
      },
    );
  }

  Widget buildFlavorTag() {
    String text = 'UKNOWN';
    Color color = VNLColors.green;
    switch (flavor) {
      case 'local':
        text = 'Local';
        color = VNLColors.red;
        break;
      case 'experimental':
        text = 'Experimental';
        color = VNLColors.orange;
        break;
      case 'release':
        text = getReleaseTagName();
        color = VNLColors.green;
        break;
    }
    return Builder(builder: (context) {
      return VNLPrimaryBadge(
        onPressed: () {
          showDropdown(
            context: context,
            offset: const Offset(0, 8) * Theme.of(context).scaling,
            builder: (context) {
              return VNLDropdownMenu(
                children: [
                  VNLMenuButton(
                    child: Text(getReleaseTagName()),
                    onPressed: (context) {
                      launchUrlString(
                          'https://thanhduy1812.github.io/vnl_flutter_ui/');
                    },
                  ),
                  VNLMenuButton(
                    child: const Text('Experimental'),
                    onPressed: (context) {
                      launchUrlString(
                          'https://thanhduy1812.github.io/vnl_flutter_ui/experimental/');
                    },
                  ),
                ],
              );
            },
          );
        },
        style: const VNLButtonStyle.primary(
          density: VNLButtonDensity.dense,
          size: VNLButtonSize.small,
        ).copyWith(
          decoration: (context, states, value) {
            return (value as BoxDecoration).copyWith(
              color: color,
            );
          },
          textStyle: (context, states, value) {
            return value.copyWith(
              color: VNLColors.white,
              fontWeight: FontWeight.w500,
            );
          },
        ),
        child: Text(text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, OnThisPage> onThisPage = widget.onThisPage;
    VNLDocsPage? page = sections
        .expand((e) => e.pages)
        .where((e) => e.name == widget.name)
        .firstOrNull;

    final theme = Theme.of(context);

    var hasOnThisPage = onThisPage.isNotEmpty;
    return FocusableActionDetector(
      autofocus: true,
      actions: {
        OpenSearchCommandIntent: CallbackAction<OpenSearchCommandIntent>(
          onInvoke: (intent) {
            showSearchBar();
            return null;
          },
        ),
      },
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyF, control: true):
            OpenSearchCommandIntent(),
      },
      child: ClipRect(
        child: PageStorage(
          bucket: docsBucket,
          child: Builder(builder: (context) {
            return VNLStageContainer(
              builder: (context, padding) {
                return VNLScaffold(
                  headers: [
                    Container(
                      color: theme.colorScheme.background.scaleAlpha(0.3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          VNLMediaQueryVisibility(
                            minWidth: breakpointWidth,
                            alternateChild: VNLAppBar(
                              padding: EdgeInsets.symmetric(
                                vertical: 12 * theme.scaling,
                                horizontal: 18 * theme.scaling,
                              ),
                              leading: [
                                VNLGhostButton(
                                  density: VNLButtonDensity.icon,
                                  onPressed: () {
                                    _openDrawer(context);
                                  },
                                  child: const Icon(Icons.menu),
                                ),
                              ],
                              trailing: [
                                Semantics(
                                  link: true,
                                  linkUrl: Uri.tryParse(
                                    'https://github.com/thanhduy1812/vnl_flutter_ui',
                                  ),
                                  child: VNLGhostButton(
                                    density: VNLButtonDensity.icon,
                                    onPressed: () {
                                      openInNewTab(
                                          'https://github.com/thanhduy1812/vnl_flutter_ui');
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.github,
                                      color:
                                          theme.colorScheme.secondaryForeground,
                                    ).iconLarge(),
                                  ),
                                ),
                                // pub.dev icon
                                VNLGhostButton(
                                    density: VNLButtonDensity.icon,
                                    onPressed: () {
                                      openInNewTab(
                                          'https://pub.dev/packages/vnl_common_ui');
                                    },
                                    child: ColorFiltered(
                                      // turns into white
                                      colorFilter: ColorFilter.mode(
                                        theme.colorScheme.secondaryForeground,
                                        BlendMode.srcIn,
                                      ),
                                      child: FlutterLogo(
                                        size: 24 * theme.scaling,
                                      ),
                                    )),
                              ],
                              child: Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: VNLOutlineButton(
                                    onPressed: () {
                                      showSearchBar();
                                    },
                                    trailing: const Icon(Icons.search)
                                        .iconSmall()
                                        .iconMutedForeground(),
                                    child: Row(
                                      spacing: 8,
                                      children: [
                                        const Text('Search documentation...')
                                            .muted()
                                            .normal(),
                                        const VNLKeyboardDisplay.fromActivator(
                                          activator: SingleActivator(
                                              LogicalKeyboardKey.keyF,
                                              control: true),
                                        ).xSmall.withOpacity(0.8),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: VNLMediaQueryVisibility(
                              minWidth: breakpointWidth2,
                              alternateChild: _buildAppBar(
                                  padding.copyWith(
                                        top: 12,
                                        bottom: 12,
                                        right: 32,
                                      ) *
                                      theme.scaling,
                                  theme),
                              child: _buildAppBar(
                                  padding.copyWith(
                                        top: 12,
                                        bottom: 12,
                                      ) *
                                      theme.scaling,
                                  theme),
                            ),
                          ),
                          const VNLDivider(),
                        ],
                      ),
                    ),
                  ],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      VNLMediaQueryVisibility(
                        minWidth: breakpointWidth,
                        child: FocusTraversalGroup(
                          child: SingleChildScrollView(
                            key: const PageStorageKey('sidebar'),
                            padding: EdgeInsets.only(
                                    top: 32,
                                    left: 24 + padding.left,
                                    bottom: 32) *
                                theme.scaling,
                            child: _DocsSidebar(
                                sections: sections, pageName: widget.name),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FocusTraversalGroup(
                          child: widget.scrollable
                              ? Builder(builder: (context) {
                                  var mq = MediaQuery.of(context);
                                  return SingleChildScrollView(
                                    controller: scrollController,
                                    clipBehavior: Clip.none,
                                    padding: !hasOnThisPage
                                        ? const EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 32,
                                                ).copyWith(
                                                  right: padding.right + 32,
                                                ) *
                                                theme.scaling +
                                            mq.padding
                                        : const EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 32,
                                                ).copyWith(right: 24) *
                                                theme.scaling +
                                            mq.padding,
                                    child: MediaQuery(
                                      data: mq.copyWith(
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          VNLBreadcrumb(
                                            separator:
                                                VNLBreadcrumb.arrowSeparator,
                                            children: [
                                              VNLTextButton(
                                                onPressed: () {
                                                  context
                                                      .goNamed('introduction');
                                                },
                                                density: VNLButtonDensity.compact,
                                                child: const Text('Docs'),
                                              ),
                                              ...widget.navigationItems,
                                              if (page != null)
                                                Text(page.title),
                                            ],
                                          ),
                                          Gap(16 * theme.scaling),
                                          widget.child,
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              : Container(
                                  clipBehavior: Clip.none,
                                  padding: !hasOnThisPage
                                      ? const EdgeInsets.symmetric(
                                            horizontal: 40,
                                            vertical: 32,
                                          ).copyWith(
                                            right: padding.right + 32,
                                            bottom: 0,
                                          ) *
                                          theme.scaling
                                      : const EdgeInsets.symmetric(
                                            horizontal: 40,
                                            vertical: 32,
                                          ).copyWith(
                                            right: 24,
                                            bottom: 0,
                                          ) *
                                          theme.scaling,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      VNLBreadcrumb(
                                        separator: VNLBreadcrumb.arrowSeparator,
                                        children: [
                                          VNLTextButton(
                                            onPressed: () {
                                              context.goNamed('introduction');
                                            },
                                            density: VNLButtonDensity.compact,
                                            child: const Text('Docs'),
                                          ),
                                          ...widget.navigationItems,
                                          if (page != null) Text(page.title),
                                        ],
                                      ),
                                      Gap(16 * theme.scaling),
                                      Expanded(child: widget.child),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      if (hasOnThisPage)
                        VNLMediaQueryVisibility(
                          minWidth: breakpointWidth2,
                          child: _DocsSecondarySidebar(
                            onThisPage: onThisPage,
                            isVisible: isVisible,
                            padding: padding,
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  VNLAppBar _buildAppBar(EdgeInsets padding, ThemeData theme) {
    return VNLAppBar(
      // padding: (breakpointWidth2 < mediaQuerySize.width
      //         ? padding * theme.scaling
      //         : padding.copyWith(
      //               right: 32,
      //             ) *
      //             theme.scaling)
      //     .copyWith(
      //   top: 12 * theme.scaling,
      //   bottom: 12 * theme.scaling,
      // ),
      padding: padding,
      title: VNLBasic(
        leading: FlutterLogo(
          size: 32 * theme.scaling,
        ),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'vnl_flutter_ui',
            ).textLarge().mono(),
            Gap(16 * theme.scaling),
            buildFlavorTag(),
          ],
        ),
      ),
      trailing: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: 320 - 18,
            child: VNLOutlineButton(
              onPressed: () {
                showSearchBar();
              },
              trailing:
                  const Icon(Icons.search).iconSmall().iconMutedForeground(),
              child: Row(
                spacing: 16,
                children: [
                  const Text('Search documentation...').muted().normal(),
                  const VNLKeyboardDisplay.fromActivator(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyF, control: true),
                  ).xSmall.withOpacity(0.8),
                ],
              ),
            ),
          ),
        ),
        Gap(8 * theme.scaling),
        VNLGhostButton(
          density: VNLButtonDensity.icon,
          onPressed: () {
            openInNewTab('https://github.com/thanhduy1812/vnl_flutter_ui');
          },
          child: FaIcon(FontAwesomeIcons.github,
                  color: theme.colorScheme.secondaryForeground)
              .iconLarge(),
        ),
        // pub.dev icon
        VNLGhostButton(
            density: VNLButtonDensity.icon,
            onPressed: () {
              openInNewTab('https://pub.dev/packages/vnl_common_ui');
            },
            child: ColorFiltered(
              // turns into white
              colorFilter: ColorFilter.mode(
                theme.colorScheme.secondaryForeground,
                BlendMode.srcIn,
              ),
              child: FlutterLogo(
                size: 24 * theme.scaling,
              ),
            )),
      ],
    );
  }

  void _openDrawer(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    openSheet(
      context: context,
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(maxWidth: 400) * scaling,
          padding: const EdgeInsets.only(top: 32) * scaling,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlutterLogo(
                    size: 24 * scaling,
                  ),
                  Gap(18 * scaling),
                  const Text(
                    'vnl_flutter_ui',
                  ).medium().mono(),
                  Gap(12 * scaling),
                  buildFlavorTag(),
                  const Spacer(),
                  VNLTextButton(
                    density: VNLButtonDensity.icon,
                    size: VNLButtonSize.small,
                    onPressed: () {
                      closeDrawer(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ).withPadding(left: 32 * scaling, right: 32 * scaling),
              Gap(32 * scaling),
              Expanded(
                child: FocusTraversalGroup(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(left: 32, right: 32, bottom: 48) *
                            scaling,
                    key: const PageStorageKey('sidebar'),
                    child: SidebarNav(children: [
                      for (var section in sections)
                        SidebarSection(
                          header: Text(section.title),
                          children: [
                            for (var page in section.pages)
                              Semantics(
                                link: true,
                                linkUrl: Uri.tryParse(
                                  'https://thanhduy1812.github.io/vnl_flutter_ui${_goRouterNamedLocation(context, page.name)}',
                                ),
                                child: DocsNavigationButton(
                                  onPressed: () {
                                    if (page.tag ==
                                        VNLFeatureTag.workInProgress) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return VNLAlertDialog(
                                            title:
                                                const Text('Work in VNLProgress'),
                                            content: const Text(
                                                'This page is still under development. Please come back later.'),
                                            actions: [
                                              VNLPrimaryButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Close')),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    }
                                    context.goNamed(page.name);
                                  },
                                  selected: page.name == widget.name,
                                  child: VNLBasic(
                                    trailing: page.tag?.buildBadge(context),
                                    trailingAlignment:
                                        AlignmentDirectional.centerStart,
                                    content: Text(page.title),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ]),
                  ),
                ),
              )
            ],
          ),
        );
      },
      position: VNLOverlayPosition.left,
    );
  }
}

class OpenSearchCommandIntent extends Intent {
  const OpenSearchCommandIntent();
}

class _DocsSidebar extends StatefulWidget {
  const _DocsSidebar({
    required this.sections,
    required this.pageName,
  });

  final List<VNLDocsSection> sections;
  final String pageName;

  @override
  State<_DocsSidebar> createState() => _DocsSidebarState();
}

class _DocsSidebarState extends State<_DocsSidebar> {
  late List<Widget> children;

  @override
  void initState() {
    super.initState();
    children = [
      for (var section in widget.sections)
        _DocsSidebarSection(section: section, pageName: widget.pageName),
    ];
    // do we need didUpdateWidget? nope
    // we don't update the children anyway
  }

  @override
  Widget build(BuildContext context) {
    return SidebarNav(children: children);
  }
}

class _DocsSecondarySidebar extends StatefulWidget {
  final Map<String, OnThisPage> onThisPage;
  final bool Function(OnThisPage) isVisible;
  final EdgeInsets padding;

  const _DocsSecondarySidebar({
    required this.onThisPage,
    required this.isVisible,
    required this.padding,
  });

  @override
  State<_DocsSecondarySidebar> createState() => _DocsSecondarySidebarState();
}

class _DocsSecondarySidebarState extends State<_DocsSecondarySidebar> {
  final List<Widget> _sideChildren = [];
  @override
  void initState() {
    super.initState();
    var side = <Widget>[];
    for (var key in widget.onThisPage.keys) {
      side.add(SidebarButton(
        onPressed: () {
          Scrollable.ensureVisible(widget.onThisPage[key]!.currentContext!,
              duration: kDefaultDuration,
              alignmentPolicy: ScrollPositionAlignmentPolicy.explicit);
        },
        selected: widget.isVisible(widget.onThisPage[key]!),
        child: Text(key),
      ));
    }
    _sideChildren.add(SidebarSection(
      header: const Text('On This Page'),
      children: side,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: (widget.padding.right + 180) * theme.scaling,
      alignment: Alignment.topLeft,
      child: FocusTraversalGroup(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
                top: 32,
                right: 24,
                bottom: 32,
                left: 24,
              ) *
              theme.scaling,
          child: SidebarNav(children: _sideChildren),
        ),
      ),
    );
  }
}

class _DocsSidebarSection extends StatefulWidget {
  const _DocsSidebarSection({
    required this.section,
    required this.pageName,
  });

  final VNLDocsSection section;
  final String pageName;

  @override
  State<_DocsSidebarSection> createState() => _DocsSidebarSectionState();
}

class _DocsSidebarSectionState extends State<_DocsSidebarSection> {
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      for (var page in widget.section.pages)
        _DocsSidebarButton(page: page, pageName: widget.pageName),
    ];
    // do we need didUpdateWidget? nope
    // we don't update the pages anyway
  }

  @override
  Widget build(BuildContext context) {
    return SidebarSection(
      header: Text(widget.section.title),
      children: pages,
    );
  }
}

class _DocsSidebarButton extends StatefulWidget {
  const _DocsSidebarButton({
    required this.page,
    required this.pageName,
  });

  final VNLDocsPage page;
  final String pageName;

  @override
  State<_DocsSidebarButton> createState() => _DocsSidebarButtonState();
}

String? _goRouterNamedLocation(BuildContext context, String name) {
  try {
    return '/#${GoRouter.of(context).namedLocation(name)}';
  } catch (e) {
    return null;
  }
}

class _DocsSidebarButtonState extends State<_DocsSidebarButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: widget.page.title,
      linkUrl: Uri.tryParse(
        'https://thanhduy1812.github.io/vnl_flutter_ui${_goRouterNamedLocation(context, widget.page.name)}',
      ),
      child: DocsNavigationButton(
        onPressed: _onPressed,
        selected: widget.page.name == widget.pageName,
        trailing: DefaultTextStyle.merge(
          style: const TextStyle(
            decoration: TextDecoration.none,
          ),
          child: widget.page.tag?.buildBadge(context) ?? const SizedBox(),
        ),
        child: Text(widget.page.title),
      ),
    );
  }

  void _onPressed() {
    if (widget.page.tag == VNLFeatureTag.workInProgress) {
      showDialog(
        context: context,
        builder: (context) {
          return VNLAlertDialog(
            title: const Text('Work in VNLProgress'),
            content: const Text(
                'This page is still under development. Please come back later.'),
            actions: [
              VNLPrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close')),
            ],
          );
        },
      );
      return;
    }
    context.goNamed(widget.page.name);
  }
}
