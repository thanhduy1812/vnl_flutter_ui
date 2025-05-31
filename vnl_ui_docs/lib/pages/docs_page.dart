import 'package:flutter/foundation.dart';
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

enum VNLookFeatureTag {
  newFeature,
  updated,
  experimental,
  workInProgress;

  Widget buildBadge(BuildContext context) {
    VNLThemeData theme = VNLTheme.of(context);
    VNLThemeData copy;
    String badgeText;
    switch (this) {
      case VNLookFeatureTag.newFeature:
        copy = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: VNLColors.green,
          ),
        );
        badgeText = 'New';
        break;
      case VNLookFeatureTag.updated:
        copy = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: VNLColors.blue,
          ),
        );
        badgeText = 'Updated';
        break;
      case VNLookFeatureTag.workInProgress:
        copy = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: VNLColors.orange,
          ),
        );
        badgeText = 'WIP';
        break;
      case VNLookFeatureTag.experimental:
        copy = theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: VNLColors.purple,
          ),
        );
        badgeText = 'Experimental';
        break;
    }
    return VNLTheme(
      data: copy,
      child: VNLPrimaryBadge(
        child: Text(badgeText),
      ),
    );
  }
}

class VNLookDocsPage {
  final String title;
  final String name; // name for go_router
  final VNLookFeatureTag? tag;

  VNLookDocsPage(this.title, this.name, [this.tag]);
}

class VNLookDocsSection {
  final String title;
  final List<VNLookDocsPage> pages;
  final IconData icon;

  VNLookDocsSection(this.title, this.pages, [this.icon = Icons.book]);
}

class DocsPageState extends State<DocsPage> {
  static final List<VNLookDocsSection> sections = [
    VNLookDocsSection(
        'Getting Started',
        List.unmodifiable([
          VNLookDocsPage('Introduction', 'introduction'),
          VNLookDocsPage('Installation', 'installation'),
          VNLookDocsPage('Theme', 'theme'),
          VNLookDocsPage('Typography', 'typography'),
          VNLookDocsPage('Layout', 'layout'),
          VNLookDocsPage('Web Preloader', 'web_preloader'),
          VNLookDocsPage('Components', 'components'),
          VNLookDocsPage('Icons', 'icons'),
          VNLookDocsPage('VNLColors', 'colors'),
          VNLookDocsPage('Material/Cupertino', 'external'),
          VNLookDocsPage('State Management', 'state'),
        ]),
        Icons.book),
    // COMPONENTS BEGIN
    VNLookDocsSection(
      'Animation',
      [
        VNLookDocsPage('Animated Value', 'animated_value_builder'),
        // https://nyxbui.design/docs/components/number-ticker
        VNLookDocsPage('Number Ticker', 'number_ticker'),
        VNLookDocsPage('Repeated Animation', 'repeated_animation_builder'),
        VNLookDocsPage('Timeline Animation', 'timeline_animation'),
      ],
    ),
    VNLookDocsSection('Control', [
      VNLookDocsPage('Button', 'button'),
      VNLookDocsPage('Audio Control', 'audio_control', VNLookFeatureTag.workInProgress),
      VNLookDocsPage('Video Control', 'video_control', VNLookFeatureTag.workInProgress),
    ]),
    VNLookDocsSection(
      'Disclosure',
      [
        VNLookDocsPage('Accordion', 'accordion'),
        VNLookDocsPage('Collapsible', 'collapsible'),
      ],
    ),
    VNLookDocsSection(
      'Display',
      [
        VNLookDocsPage('VNLAvatar', 'VNLAvatar'),
        VNLookDocsPage('VNLAvatar Group', 'avatar_group'),
        // VNLookDocsPage(
        // 'Data Table', 'data_table', VNLookFeatureTag.experimental),
        // TODO also make it zoomable like: https://zoom-chart-demo.vercel.app/
        // VNLookDocsPage('Chart', 'chart', VNLookFeatureTag.workInProgress),
        VNLookDocsPage('Code Snippet', 'code_snippet'),
        VNLookDocsPage('Table', 'table'),
        VNLookDocsPage('Tracker', 'tracker'),
      ],
    ),
    VNLookDocsSection(
      'Feedback',
      [
        VNLookDocsPage('Alert', 'alert'),
        VNLookDocsPage('Alert Dialog', 'alert_dialog'),
        VNLookDocsPage('Circular Progress', 'circular_progress'),
        VNLookDocsPage('Progress', 'progress'),
        VNLookDocsPage('Linear Progress', 'linear_progress'),
        VNLookDocsPage('Skeleton', 'skeleton'),
        VNLookDocsPage('Toast', 'toast'),
      ],
    ),
    VNLookDocsSection(
      'Form',
      [
        // mostly same as file input, except it only accepts audio file
        // and adds the ability to play the audio
        // VNLookDocsPage(
        //     'Audio Input', 'audio_input', VNLookFeatureTag.workInProgress),
        // update: NVM, merge the component with file input
        // VNLookDocsPage('Button', 'button'),
        // moved to control
        VNLookDocsPage('Checkbox', 'checkbox'),
        VNLookDocsPage('Chip Input', 'chip_input'),
        VNLookDocsPage('Color Picker', 'color_picker'),
        VNLookDocsPage('Date Picker', 'date_picker'),
        // TODO: https://file-vault-delta.vercel.app/ also https://uploader.sadmn.com/
        VNLookDocsPage('File Picker', 'file_picker', VNLookFeatureTag.workInProgress),
        VNLookDocsPage('Form', 'form'),
        VNLookDocsPage('Formatted Input', 'formatted_input', VNLookFeatureTag.experimental),
        // TODO: Image Input (with cropper and rotate tool, upload from file or take photo from camera)
        // VNLookDocsPage(
        // 'Image Input', 'image_input', VNLookFeatureTag.workInProgress),
        // replaced with File Input
        VNLookDocsPage('Text Input', 'input'),
        // TODO: same as text input, but has dropdown autocomplete like chip input, the difference is, it does not convert
        // the value into chips
        VNLookDocsPage('AutoComplete', 'autocomplete'),
        // TODO: same as input, except it only accepts number, and can be increased or decreased
        // using scroll, also has increment and decrement button
        // in between increment and decrement button, theres
        // a divider that can be dragged to increase or decrease the value
        VNLookDocsPage('Number Input', 'number_input'),
        VNLookDocsPage('Input OTP', 'input_otp'),
        VNLookDocsPage('Phone Input', 'phone_input'),
        VNLookDocsPage('VNLRadio Group', 'radio_group'),
        //https://www.radix-ui.com/themes/docs/components/radio-cards
        VNLookDocsPage('VNLRadio Card', 'radio_card'),
        VNLookDocsPage('Select', 'select'),
        VNLookDocsPage('Slider', 'slider'),
        VNLookDocsPage('Star Rating', 'star_rating'),
        VNLookDocsPage('Switch', 'switch'),
        VNLookDocsPage('Text Area', 'text_area'),
        VNLookDocsPage('Time Picker', 'time_picker'),
        VNLookDocsPage('Toggle', 'toggle'),
        VNLookDocsPage('Multi Select', 'multiselect'),
        VNLookDocsPage('Item Picker', 'item_picker', VNLookFeatureTag.experimental),
      ],
    ),
    VNLookDocsSection(
      'Layout',
      [
        VNLookDocsPage('Card', 'card'),
        VNLookDocsPage('Carousel', 'carousel'),
        VNLookDocsPage('Divider', 'divider'),
        VNLookDocsPage('Resizable', 'resizable'),
        // https://nextjs-shadcn-dnd.vercel.app/ (make it headless)
        VNLookDocsPage('Sortable', 'sortable'),
        VNLookDocsPage('Steps', 'steps'),
        VNLookDocsPage('Stepper', 'stepper'),
        VNLookDocsPage('Timeline', 'timeline'),
        VNLookDocsPage('Scaffold', 'scaffold'),
        VNLookDocsPage('App Bar', 'app_bar'),
        VNLookDocsPage('Card Image', 'card_image'),
      ],
    ),
    VNLookDocsSection(
      'Navigation',
      [
        VNLookDocsPage('Breadcrumb', 'breadcrumb'),
        VNLookDocsPage('Menubar', 'menubar'),
        VNLookDocsPage('Navigation Menu', 'navigation_menu'),
        VNLookDocsPage('VNLPagination', 'pagination'),
        VNLookDocsPage('Tabs', 'tabs'),
        VNLookDocsPage('Tab List', 'tab_list'),
        // TODO: like a chrome tab, complete with its view
        VNLookDocsPage('Tab Pane', 'tab_pane'),
        VNLookDocsPage('Tree', 'tree'),
        // aka Bottom Navigation Bar
        VNLookDocsPage('Navigation Bar', 'navigation_bar'),
        VNLookDocsPage('Navigation Rail', 'navigation_rail'),
        VNLookDocsPage('Expandable Sidebar', 'expandable_sidebar'),
        // aka Drawer
        VNLookDocsPage('Navigation Sidebar', 'navigation_sidebar'),
        VNLookDocsPage('Dot Indicator', 'dot_indicator'),
      ],
    ),
    VNLookDocsSection(
      'Overlay',
      [
        VNLookDocsPage('Dialog', 'dialog'),
        VNLookDocsPage('Drawer', 'drawer'),
        VNLookDocsPage('Hover Card', 'hover_card'),
        VNLookDocsPage('Popover', 'popover'),
        VNLookDocsPage('Sheet', 'sheet'),
        VNLookDocsPage('Swiper', 'swiper', VNLookFeatureTag.newFeature),
        VNLookDocsPage('VNLTooltip', 'tooltip'),
        // TODO: window as in like a window in desktop
        VNLookDocsPage('Window', 'window', VNLookFeatureTag.experimental),
      ],
    ),

    VNLookDocsSection(
      'Utility',
      [
        VNLookDocsPage('Badge', 'badge'),
        VNLookDocsPage('Chip', 'chip'),
        VNLookDocsPage('Calendar', 'calendar'),
        VNLookDocsPage('Command', 'command'),
        VNLookDocsPage('Context Menu', 'context_menu'),
        VNLookDocsPage('Dropdown Menu', 'dropdown_menu'),
        // TODO https://www.radix-ui.com/themes/docs/components/kbd
        VNLookDocsPage('Keyboard Display', 'keyboard_display'),
        // TODO: Same progress as image input
        VNLookDocsPage('Image Tools', 'image_tools', VNLookFeatureTag.workInProgress),
        // TODO: Mostly same as refresh indicator, but it does not provide indicator
        // the indicator itself is provided by scaffold
        VNLookDocsPage('Refresh Trigger', 'refresh_trigger'),
        VNLookDocsPage('Overflow Marquee', 'overflow_marquee'),
      ],
    ),
    // COMPONENTS END
  ];

  List<String> componentCategories = [
    'Animation',
    'Disclosure',
    'Feedback',
    'Control',
    'Form',
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
          if (page.tag == VNLookFeatureTag.workInProgress) {
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
      print('Work in Progress: $workInProgress');
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
      currentlyVisible = widget.onThisPage.values.where((element) => element.isVisible.value).toList();
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
            if (query == null || page.title.toLowerCase().contains(query.toLowerCase())) {
              resultItems.add(CommandItem(
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
              CommandCategory(
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
            offset: const Offset(0, 8) * VNLTheme.of(context).scaling,
            builder: (context) {
              return VNLDropdownMenu(
                children: [
                  MenuButton(
                    child: Text(getReleaseTagName()),
                    onPressed: (context) {
                      launchUrlString('https://sunarya-thito.github.io/vnl_ui/');
                    },
                  ),
                  MenuButton(
                    child: const Text('Experimental'),
                    onPressed: (context) {
                      launchUrlString('https://sunarya-thito.github.io/vnl_ui/experimental/');
                    },
                  ),
                ],
              );
            },
          );
        },
        style: const ButtonStyle.primary(
          density: ButtonDensity.dense,
          size: ButtonSize.small,
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
    VNLookDocsPage? page = sections.expand((e) => e.pages).where((e) => e.name == widget.name).firstOrNull;

    final theme = VNLTheme.of(context);

    var hasOnThisPage = onThisPage.isNotEmpty;
    return ClipRect(
      child: PageStorage(
        bucket: docsBucket,
        child: Builder(builder: (context) {
          return StageContainer(
            builder: (context, padding) {
              return VNLScaffold(
                headers: [
                  Container(
                    color: theme.colorScheme.background.scaleAlpha(0.3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MediaQueryVisibility(
                          minWidth: breakpointWidth,
                          alternateChild: VNLAppBar(
                            padding: EdgeInsets.symmetric(
                              vertical: 12 * theme.scaling,
                              horizontal: 18 * theme.scaling,
                            ),
                            leading: [
                              GhostButton(
                                density: ButtonDensity.icon,
                                onPressed: () {
                                  _openDrawer(context);
                                },
                                child: const Icon(Icons.menu),
                              ),
                            ],
                            trailing: [
                              GhostButton(
                                density: ButtonDensity.icon,
                                onPressed: () {
                                  openInNewTab('https://github.com/sunarya-thito/vnl_ui');
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.github,
                                  color: theme.colorScheme.secondaryForeground,
                                ).iconLarge(),
                              ),
                              // pub.dev icon
                              GhostButton(
                                  density: ButtonDensity.icon,
                                  onPressed: () {
                                    openInNewTab('https://pub.dev/packages/vnl_ui');
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
                                  trailing: const Icon(Icons.search).iconSmall().iconMutedForeground(),
                                  child: const Text('Search documentation...').muted().normal(),
                                ),
                              ),
                            ),
                          ),
                          child: MediaQueryVisibility(
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
                    MediaQueryVisibility(
                      minWidth: breakpointWidth,
                      child: FocusTraversalGroup(
                        child: SingleChildScrollView(
                          key: const PageStorageKey('sidebar'),
                          padding: EdgeInsets.only(top: 32, left: 24 + padding.left, bottom: 32) * theme.scaling,
                          child: _DocsSidebar(sections: sections, pageName: widget.name),
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
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        VNLBreadcrumb(
                                          separator: VNLBreadcrumb.arrowSeparator,
                                          children: [
                                            VNLTextButton(
                                              onPressed: () {
                                                context.goNamed('introduction');
                                              },
                                              density: ButtonDensity.compact,
                                              child: const Text('Docs'),
                                            ),
                                            ...widget.navigationItems,
                                            if (page != null) Text(page.title),
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
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    VNLBreadcrumb(
                                      separator: VNLBreadcrumb.arrowSeparator,
                                      children: [
                                        VNLTextButton(
                                          onPressed: () {
                                            context.goNamed('introduction');
                                          },
                                          density: ButtonDensity.compact,
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
                      MediaQueryVisibility(
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
    );
  }

  VNLAppBar _buildAppBar(EdgeInsets padding, VNLThemeData theme) {
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
      title: Basic(
        // leading: FlutterLogo(
        //   size: 32 * theme.scaling,
        // ),
        leading: Image.asset("assets/icon/icon.png", width: 32 * theme.scaling),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'VNLook UI',
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
              trailing: const Icon(Icons.search).iconSmall().iconMutedForeground(),
              child: const Text('Search documentation...').muted().normal(),
            ),
          ),
        ),
        Gap(8 * theme.scaling),
        GhostButton(
          density: ButtonDensity.icon,
          onPressed: () {
            openInNewTab('https://github.com/vnlook');
          },
          child: FaIcon(FontAwesomeIcons.github, color: theme.colorScheme.secondaryForeground).iconLarge(),
        ),
        // pub.dev icon
        GhostButton(
            density: ButtonDensity.icon,
            onPressed: () {
              openInNewTab('https://vnlook.com/');
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
    final theme = VNLTheme.of(context);
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
                    'vnl_ui',
                  ).medium().mono(),
                  Gap(12 * scaling),
                  buildFlavorTag(),
                  const Spacer(),
                  VNLTextButton(
                    density: ButtonDensity.icon,
                    size: ButtonSize.small,
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
                    padding: const EdgeInsets.only(left: 32, right: 32, bottom: 48) * scaling,
                    key: const PageStorageKey('sidebar'),
                    child: SidebarNav(children: [
                      for (var section in sections)
                        SidebarSection(
                          header: Text(section.title),
                          children: [
                            for (var page in section.pages)
                              DocsNavigationButton(
                                onPressed: () {
                                  if (page.tag == VNLookFeatureTag.workInProgress) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return VNLAlertDialog(
                                          title: const Text('Work in Progress'),
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
                                child: Basic(
                                  trailing: page.tag?.buildBadge(context),
                                  trailingAlignment: AlignmentDirectional.centerStart,
                                  content: Text(page.title),
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
      position: OverlayPosition.left,
    );
  }
}

class _DocsSidebar extends StatefulWidget {
  const _DocsSidebar({
    required this.sections,
    required this.pageName,
  });

  final List<VNLookDocsSection> sections;
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
      for (var section in widget.sections) _DocsSidebarSection(section: section, pageName: widget.pageName),
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
              duration: kDefaultDuration, alignmentPolicy: ScrollPositionAlignmentPolicy.explicit);
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
    final theme = VNLTheme.of(context);
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

  final VNLookDocsSection section;
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
      for (var page in widget.section.pages) _DocsSidebarButton(page: page, pageName: widget.pageName),
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

  final VNLookDocsPage page;
  final String pageName;

  @override
  State<_DocsSidebarButton> createState() => _DocsSidebarButtonState();
}

class _DocsSidebarButtonState extends State<_DocsSidebarButton> {
  @override
  Widget build(BuildContext context) {
    return DocsNavigationButton(
      onPressed: _onPressed,
      selected: widget.page.name == widget.pageName,
      trailing: DefaultTextStyle.merge(
        style: const TextStyle(
          decoration: TextDecoration.none,
        ),
        child: widget.page.tag?.buildBadge(context) ?? const SizedBox(),
      ),
      child: Text(widget.page.title),
    );
  }

  void _onPressed() {
    if (widget.page.tag == VNLookFeatureTag.workInProgress) {
      showDialog(
        context: context,
        builder: (context) {
          return VNLAlertDialog(
            title: const Text('Work in Progress'),
            content: const Text('This page is still under development. Please come back later.'),
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
