import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

/// {@template menu_theme}
/// Styling options for menu widgets such as [VNLMenuGroup] and [VNLMenuButton].
/// {@endtemplate}
class VNLMenuTheme extends ComponentThemeData {
  /// Default padding applied to each menu item.
  final EdgeInsets? itemPadding;

  /// Offset applied when showing a submenu.
  final Offset? subMenuOffset;

  /// {@macro menu_theme}
  const VNLMenuTheme({
    this.itemPadding,
    this.subMenuOffset,
  });

  /// Creates a copy of this theme but with the given fields replaced.
  VNLMenuTheme copyWith({
    ValueGetter<EdgeInsets?>? itemPadding,
    ValueGetter<Offset?>? subMenuOffset,
  }) {
    return VNLMenuTheme(
      itemPadding: itemPadding == null ? this.itemPadding : itemPadding(),
      subMenuOffset:
          subMenuOffset == null ? this.subMenuOffset : subMenuOffset(),
    );
  }

  @override
  int get hashCode => Object.hash(itemPadding, subMenuOffset);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VNLMenuTheme &&
        other.itemPadding == itemPadding &&
        other.subMenuOffset == subMenuOffset;
  }

  @override
  String toString() {
    return 'VNLMenuTheme(itemPadding: $itemPadding, subMenuOffset: $subMenuOffset)';
  }
}

/// Displays a keyboard shortcut in a menu.
///
/// Renders the visual representation of a keyboard shortcut, typically
/// displayed on the right side of menu items.
///
/// Example:
/// ```dart
/// VNLMenuShortcut(
///   activator: SingleActivator(LogicalKeyboardKey.keyS, control: true),
/// )
/// ```
class VNLMenuShortcut extends StatelessWidget {
  /// The keyboard shortcut to display.
  final ShortcutActivator activator;

  /// Widget to display between multiple keys.
  final Widget? combiner;

  /// Creates a [VNLMenuShortcut].
  ///
  /// Parameters:
  /// - [activator] (`ShortcutActivator`, required): The shortcut to display.
  /// - [combiner] (`Widget?`, optional): Separator between keys (default: " + ").
  const VNLMenuShortcut({super.key, required this.activator, this.combiner});

  @override
  Widget build(BuildContext context) {
    var activator = this.activator;
    var combiner = this.combiner ?? const Text(' + ');
    final displayMapper = Data.maybeOf<VNLKeyboardShortcutDisplayHandle>(context);
    assert(displayMapper != null, 'Cannot find VNLKeyboardShortcutDisplayMapper');
    List<LogicalKeyboardKey> keys = shortcutActivatorToKeySet(activator);
    List<Widget> children = [];
    for (int i = 0; i < keys.length; i++) {
      if (i > 0) {
        children.add(combiner);
      }
      children.add(displayMapper!.buildKeyboardDisplay(context, keys[i]));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ).xSmall().muted();
  }
}

/// Abstract base class for menu item widgets.
///
/// All menu items (buttons, checkboxes, radio buttons, dividers, etc.) must
/// implement this interface. Menu items can be placed within menu groups and
/// support features like leading icons and popover controllers.
///
/// See also:
/// - [VNLMenuButton], clickable menu item
/// - [VNLMenuCheckbox], checkbox menu item
/// - [MenuRadio], radio button menu item
/// - [VNLMenuDivider], divider between menu items
abstract class VNLMenuItem extends Widget {
  /// Creates a menu item.
  const VNLMenuItem({super.key});

  /// Whether this menu item has a leading widget (icon, checkbox indicator, etc.).
  bool get hasLeading;

  /// Optional popover controller for submenu functionality.
  VNLPopoverController? get popoverController;
}

/// VNLRadio button group container for menu items.
///
/// Groups multiple [MenuRadio] items together with shared selection state.
/// Only one radio button in the group can be selected at a time.
///
/// Example:
/// ```dart
/// MenuRadioGroup<String>(
///   value: selectedOption,
///   onChanged: (context, value) => setState(() => selectedOption = value),
///   children: [
///     MenuRadio(value: 'option1', child: Text('Option 1')),
///     MenuRadio(value: 'option2', child: Text('Option 2')),
///   ],
/// )
/// ```
class MenuRadioGroup<T> extends StatelessWidget implements VNLMenuItem {
  /// Currently selected value.
  final T? value;

  /// Callback when selection changes.
  final ContextedValueChanged<T>? onChanged;

  /// List of [MenuRadio] children.
  final List<Widget> children;

  /// Creates a radio group for menu items.
  ///
  /// Parameters:
  /// - [value] (T?): Currently selected value
  /// - [onChanged] (`ContextedValueChanged<T>?`): Selection change callback
  /// - [children] (`List<Widget>`): VNLRadio button children
  const MenuRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.children,
  });

  @override
  bool get hasLeading => children.isNotEmpty;

  @override
  VNLPopoverController? get popoverController => null;

  @override
  Widget build(BuildContext context) {
    final menuGroupData = Data.maybeOf<VNLMenuGroupData>(context);
    assert(
        menuGroupData != null, 'MenuRadioGroup must be a child of VNLMenuGroup');
    return Data<MenuRadioGroup<T>>.inherit(
      data: this,
      child: Flex(
        direction: menuGroupData!.direction,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

/// Individual radio button item within a [MenuRadioGroup].
///
/// Displays a radio button indicator when selected and integrates with
/// the parent radio group for selection management.
class MenuRadio<T> extends StatelessWidget {
  /// The value this radio button represents.
  final T value;

  /// Content widget displayed for this option.
  final Widget child;

  /// Optional trailing widget (e.g., keyboard shortcut).
  final Widget? trailing;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether this radio button is enabled.
  final bool enabled;

  /// Whether selecting this radio closes the menu automatically.
  final bool autoClose;

  /// Creates a radio button menu item.
  ///
  /// Must be a child of [MenuRadioGroup].
  ///
  /// Parameters:
  /// - [value] (T, required): Value for this option
  /// - [child] (Widget, required): Display content
  /// - [trailing] (Widget?): Optional trailing widget
  /// - [focusNode] (FocusNode?): Focus node for navigation
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [autoClose] (bool): Whether to auto-close menu, defaults to true
  const MenuRadio({
    super.key,
    required this.value,
    required this.child,
    this.trailing,
    this.focusNode,
    this.enabled = true,
    this.autoClose = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final radioGroup = Data.maybeOf<MenuRadioGroup<T>>(context);
    assert(radioGroup != null, 'MenuRadio must be a child of MenuRadioGroup');
    return Data<MenuRadioGroup<T>>.boundary(
      child: VNLMenuButton(
        leading: radioGroup!.value == value
            ? SizedBox(
                width: 16 * scaling,
                height: 16 * scaling,
                child: const Icon(
                  RadixIcons.dotFilled,
                ).iconSmall(),
              )
            : SizedBox(width: 16 * scaling),
        onPressed: (context) {
          radioGroup.onChanged?.call(context, value);
        },
        enabled: enabled,
        focusNode: focusNode,
        autoClose: autoClose,
        trailing: trailing,
        child: child,
      ),
    );
  }
}

/// Visual divider between menu items.
///
/// Renders a horizontal or vertical line to separate groups of menu items.
/// Automatically adapts direction based on the parent menu's orientation.
///
/// Example:
/// ```dart
/// VNLMenuGroup(
///   children: [
///     VNLMenuButton(child: Text('Cut')),
///     VNLMenuButton(child: Text('Copy')),
///     VNLMenuDivider(), // Separator
///     VNLMenuButton(child: Text('Paste')),
///   ],
/// )
/// ```
class VNLMenuDivider extends StatelessWidget implements VNLMenuItem {
  /// Creates a menu divider.
  const VNLMenuDivider({super.key});
  @override
  Widget build(BuildContext context) {
    final menuGroupData = Data.maybeOf<VNLMenuGroupData>(context);
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return AnimatedPadding(
      duration: kDefaultDuration,
      padding:
          (menuGroupData == null || menuGroupData.direction == Axis.vertical
                  ? const EdgeInsets.symmetric(vertical: 4)
                  : const EdgeInsets.symmetric(horizontal: 4)) *
              scaling,
      child: menuGroupData == null || menuGroupData.direction == Axis.vertical
          ? VNLDivider(
              height: 1 * scaling,
              thickness: 1 * scaling,
              indent: -4 * scaling,
              endIndent: -4 * scaling,
              color: theme.colorScheme.border,
            )
          : VNLVerticalDivider(
              width: 1 * scaling,
              thickness: 1 * scaling,
              color: theme.colorScheme.border,
              indent: -4 * scaling,
              endIndent: -4 * scaling,
            ),
    );
  }

  @override
  bool get hasLeading => false;

  @override
  VNLPopoverController? get popoverController => null;
}

/// Spacing gap between menu items.
///
/// Creates empty vertical or horizontal space within a menu, based on
/// the menu's direction. Useful for visually grouping related items.
class VNLMenuGap extends StatelessWidget implements VNLMenuItem {
  /// Size of the gap in logical pixels.
  final double size;

  /// Creates a menu gap.
  ///
  /// Parameters:
  /// - [size] (double, required): Gap size in logical pixels
  const VNLMenuGap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Gap(size);
  }

  @override
  bool get hasLeading => false;

  @override
  VNLPopoverController? get popoverController => null;
}

/// VNLClickable button menu item with optional submenu support.
///
/// Primary menu item type that responds to user interaction. Can display
/// leading icons, trailing widgets (shortcuts), and nested submenus.
///
/// Example:
/// ```dart
/// VNLMenuButton(
///   leading: Icon(Icons.cut),
///   trailing: Text('Ctrl+X').textSmall().muted(),
///   onPressed: (context) => _handleCut(),
///   child: Text('Cut'),
/// )
/// ```
class VNLMenuButton extends StatefulWidget implements VNLMenuItem {
  /// Content widget displayed in the button.
  final Widget child;

  /// Optional submenu items shown on hover or click.
  final List<VNLMenuItem>? subMenu;

  /// Callback when button is pressed.
  final ContextedCallback? onPressed;

  /// Optional trailing widget (e.g., keyboard shortcut indicator).
  final Widget? trailing;

  /// Optional leading widget (e.g., icon).
  final Widget? leading;

  /// Whether the button is enabled for interaction.
  final bool enabled;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether selecting this button closes the menu automatically.
  final bool autoClose;

  @override
  final VNLPopoverController? popoverController;

  /// Creates a menu button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content
  /// - [subMenu] (`List<VNLMenuItem>?`): Optional nested submenu
  /// - [onPressed] (ContextedCallback?): Click handler
  /// - [trailing] (Widget?): Trailing widget
  /// - [leading] (Widget?): Leading icon or widget
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [focusNode] (FocusNode?): Focus node
  /// - [autoClose] (bool): Auto-close behavior, defaults to true
  /// - [popoverController] (VNLPopoverController?): Optional popover controller
  const VNLMenuButton({
    super.key,
    required this.child,
    this.subMenu,
    this.onPressed,
    this.trailing,
    this.leading,
    this.enabled = true,
    this.focusNode,
    this.autoClose = true,
    this.popoverController,
  });

  @override
  State<VNLMenuButton> createState() => _MenuButtonState();

  @override
  bool get hasLeading => leading != null;
}

/// Non-interactive label menu item.
///
/// Displays text or content without click handlers. Useful for section
/// headers or informational text within menus.
///
/// Example:
/// ```dart
/// VNLMenuLabel(
///   leading: Icon(Icons.settings),
///   child: Text('Settings').semiBold(),
/// )
/// ```
class VNLMenuLabel extends StatelessWidget implements VNLMenuItem {
  /// Content widget displayed in the label.
  final Widget child;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Optional leading widget (e.g., icon).
  final Widget? leading;

  /// Creates a menu label.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Main content
  /// - [trailing] (Widget?): Trailing widget
  /// - [leading] (Widget?): Leading icon or widget
  const VNLMenuLabel({
    super.key,
    required this.child,
    this.trailing,
    this.leading,
  });

  @override
  bool get hasLeading => leading != null;

  @override
  VNLPopoverController? get popoverController => null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final densityGap = theme.density.baseGap * scaling;
    final menuGroupData = Data.maybeOf<VNLMenuGroupData>(context);
    assert(menuGroupData != null, 'VNLMenuLabel must be a child of VNLMenuGroup');
    return Padding(
      padding: EdgeInsets.only(
            left: densityGap,
            top: densityGap * 0.75,
            right: densityGap * 0.75,
            bottom: densityGap * 0.75,
          ) +
          menuGroupData!.itemPadding,
      child: VNLBasic(
        contentSpacing: densityGap,
        leading: leading == null && menuGroupData.hasLeading
            ? SizedBox(width: densityGap * 2)
            : leading == null
                ? null
                : SizedBox(
                    width: densityGap * 2,
                    height: densityGap * 2,
                    child: leading!.iconSmall(),
                  ),
        trailing: trailing,
        content: child.semiBold(),
        trailingAlignment: Alignment.center,
        leadingAlignment: Alignment.center,
        contentAlignment: menuGroupData.direction == Axis.vertical
            ? AlignmentDirectional.centerStart
            : Alignment.center,
      ),
    );
  }
}

/// VNLCheckbox menu item with checked/unchecked state.
///
/// Displays a checkmark when selected. Used for togglable menu options.
///
/// Example:
/// ```dart
/// VNLMenuCheckbox(
///   value: showToolbar,
///   onChanged: (context, value) => setState(() => showToolbar = value),
///   child: Text('Show Toolbar'),
/// )
/// ```
class VNLMenuCheckbox extends StatelessWidget implements VNLMenuItem {
  /// Current checked state.
  final bool value;

  /// Callback when checkbox state changes.
  final ContextedValueChanged<bool>? onChanged;

  /// Content widget displayed for this option.
  final Widget child;

  /// Optional trailing widget (e.g., keyboard shortcut).
  final Widget? trailing;

  /// Whether this checkbox is enabled.
  final bool enabled;

  /// Whether checking this box closes the menu automatically.
  final bool autoClose;

  /// Creates a checkbox menu item.
  ///
  /// Parameters:
  /// - [value] (bool): Current checked state, defaults to false
  /// - [onChanged] (`ContextedValueChanged<bool>?`): State change callback
  /// - [child] (Widget, required): Display content
  /// - [trailing] (Widget?): Optional trailing widget
  /// - [enabled] (bool): Whether enabled, defaults to true
  /// - [autoClose] (bool): Whether to auto-close menu, defaults to true
  const VNLMenuCheckbox({
    super.key,
    this.value = false,
    this.onChanged,
    required this.child,
    this.trailing,
    this.enabled = true,
    this.autoClose = true,
  });

  @override
  bool get hasLeading => true;
  @override
  VNLPopoverController? get popoverController => null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return VNLMenuButton(
      leading: value
          ? SizedBox(
              width: 16 * scaling,
              height: 16 * scaling,
              child: const Icon(
                RadixIcons.check,
              ).iconSmall(),
            )
          : SizedBox(width: 16 * scaling),
      onPressed: (context) {
        onChanged?.call(context, !value);
      },
      enabled: enabled,
      autoClose: autoClose,
      trailing: trailing,
      child: child,
    );
  }
}

class _MenuButtonState extends State<VNLMenuButton> {
  final ValueNotifier<List<VNLMenuItem>> _children = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _children.value = widget.subMenu ?? [];
  }

  @override
  void didUpdateWidget(covariant VNLMenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.subMenu, oldWidget.subMenu)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          _children.value = widget.subMenu ?? [];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarData = Data.maybeOf<VNLMenubarState>(context);
    final menuData = Data.maybeOf<VNLMenuData>(context);
    final menuGroupData = Data.maybeOf<VNLMenuGroupData>(context);
    assert(menuGroupData != null, 'VNLMenuButton must be a child of VNLMenuGroup');
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = VNLComponentTheme.maybeOf<VNLMenuTheme>(context);
    final isSheetOverlay = VNLSheetOverlayHandler.isSheetOverlay(context);
    final isDialogOverlay = VNLDialogOverlayHandler.isDialogOverlay(context);
    final isIndependentOverlay = isSheetOverlay || isDialogOverlay;
    void openSubMenu(BuildContext context, bool autofocus) {
      menuGroupData!.closeOthers();
      final overlayManager = VNLOverlayManager.of(context);
      menuData!.popoverController.show(
        context: context,
        regionGroupId: menuGroupData.regionGroupId,
        consumeOutsideTaps: false,
        dismissBackdropFocus: false,
        modal: true,
        handler: VNLMenuOverlayHandler(overlayManager),
        overlayBarrier: VNLOverlayBarrier(
          borderRadius: BorderRadius.circular(theme.radiusMd),
        ),
        builder: (context) {
          final theme = Theme.of(context);
          final scaling = theme.scaling;
          final densityGap = theme.density.baseGap * scaling;
          var itemPadding = menuGroupData.itemPadding;
          final isSheetOverlay = VNLSheetOverlayHandler.isSheetOverlay(context);
          if (isSheetOverlay) {
            itemPadding = EdgeInsets.symmetric(horizontal: densityGap * 0.5);
          }
          return ConstrainedBox(
            constraints: const BoxConstraints(
                  minWidth: 192, // 12rem
                ) *
                scaling,
            child: AnimatedBuilder(
                animation: _children,
                builder: (context, child) {
                  return VNLMenuGroup(
                      direction: menuGroupData.direction,
                      parent: menuGroupData,
                      onDismissed: menuGroupData.onDismissed,
                      regionGroupId: menuGroupData.regionGroupId,
                      subMenuOffset: compTheme?.subMenuOffset ??
                          Offset(densityGap, -densityGap * 0.625),
                      itemPadding: itemPadding,
                      autofocus: autofocus,
                      builder: (context, children) {
                        return VNLMenuPopup(
                          children: children,
                        );
                      },
                      children: _children.value);
                }),
          );
        },
        alignment: Alignment.topLeft,
        anchorAlignment:
            menuBarData != null ? Alignment.bottomLeft : Alignment.topRight,
        offset: menuGroupData.subMenuOffset ?? compTheme?.subMenuOffset,
      );
    }

    return Actions(
      actions: {
        VNLOpenSubMenuIntent: ContextCallbackAction<VNLOpenSubMenuIntent>(
          onInvoke: (intent, [context]) {
            if (widget.subMenu?.isNotEmpty ?? false) {
              openSubMenu(this.context, true);
              return true;
            }
            return false;
          },
        ),
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) {
            widget.onPressed?.call(context);
            if (widget.subMenu?.isNotEmpty ?? false) {
              openSubMenu(context, true);
            }
            if (widget.autoClose) {
              menuGroupData!.closeAll();
            }
            return;
          },
        ),
      },
      child: VNLSubFocus(
          enabled: widget.enabled,
          builder: (context, subFocusState) {
            bool hasFocus = subFocusState.isFocused && menuBarData == null;
            return Data<VNLMenuData>.boundary(
              child: Data<VNLMenubarState>.boundary(
                child: TapRegion(
                  groupId: menuGroupData!.root,
                  child: AnimatedBuilder(
                      animation: menuData!.popoverController,
                      builder: (context, child) {
                        final theme = Theme.of(context);
                        final densityGap = theme.density.baseGap * scaling;
                        return VNLButton(
                          disableFocusOutline: true,
                          alignment: menuGroupData.direction == Axis.vertical
                              ? AlignmentDirectional.centerStart
                              : Alignment.center,
                          style: (menuBarData == null
                                  ? VNLButtonVariance.menu
                                  : VNLButtonVariance.menubar)
                              .copyWith(
                            padding: (context, states, value) {
                              return value.optionallyResolve(context) +
                                  menuGroupData.itemPadding;
                            },
                            decoration: (context, states, value) {
                              final theme = Theme.of(context);
                              return (value as BoxDecoration).copyWith(
                                color:
                                    menuData.popoverController.hasOpenPopover ||
                                            hasFocus
                                        ? theme.colorScheme.accent
                                        : null,
                                borderRadius:
                                    BorderRadius.circular(theme.radiusMd),
                              );
                            },
                          ),
                          trailing: menuBarData != null
                              ? widget.trailing
                              : widget.trailing != null ||
                                      (widget.subMenu != null &&
                                          menuBarData == null)
                                  ? Row(
                                      children: [
                                        if (widget.trailing != null)
                                          widget.trailing!,
                                        if (widget.subMenu != null &&
                                            menuBarData == null)
                                          const Icon(
                                            RadixIcons.chevronRight,
                                          ).iconSmall(),
                                      ],
                                    ).gap(densityGap)
                                  : null,
                          leading: widget.leading == null &&
                                  menuGroupData.hasLeading &&
                                  menuBarData == null
                              ? SizedBox(width: densityGap * 2)
                              : widget.leading == null
                                  ? null
                                  : SizedBox(
                                      width: densityGap * 2,
                                      height: densityGap * 2,
                                      child: widget.leading!.iconSmall(),
                                    ),
                          disableTransition: true,
                          enabled: widget.enabled,
                          focusNode: widget.focusNode,
                          onHover: (value) {
                            if (value) {
                              subFocusState.requestFocus();
                              if ((menuBarData == null ||
                                      menuGroupData.hasOpenPopovers) &&
                                  widget.subMenu != null &&
                                  widget.subMenu!.isNotEmpty) {
                                if (!menuData
                                        .popoverController.hasOpenPopover &&
                                    !isIndependentOverlay) {
                                  openSubMenu(context, false);
                                }
                              } else {
                                menuGroupData.closeOthers();
                              }
                            } else {
                              subFocusState.unfocus();
                            }
                          },
                          onPressed: () {
                            widget.onPressed?.call(context);
                            if (widget.subMenu != null &&
                                widget.subMenu!.isNotEmpty) {
                              if (!menuData.popoverController.hasOpenPopover) {
                                openSubMenu(context, false);
                              }
                            } else {
                              if (widget.autoClose) {
                                menuGroupData.closeAll();
                              }
                            }
                          },
                          child: widget.child,
                        );
                      }),
                ),
              ),
            );
          }),
    );
  }
}

/// Data class containing menu group state and configuration.
///
/// Manages the hierarchical structure of menu groups, tracking parent-child
/// relationships, popover state, and layout properties. Used internally by
/// the menu system to coordinate behavior across nested menus.
class VNLMenuGroupData {
  /// Parent menu group, null for root menus.
  final VNLMenuGroupData? parent;

  /// Child menu items' data.
  final List<VNLMenuData> children;

  /// Whether any child items have leading widgets.
  final bool hasLeading;

  /// Offset for positioning submenus relative to parent.
  final Offset? subMenuOffset;

  /// Callback when menu is dismissed.
  final VoidCallback? onDismissed;

  /// Region group ID for tap region management.
  final Object? regionGroupId;

  /// Layout direction (horizontal or vertical).
  final Axis direction;

  /// Padding around menu items.
  final EdgeInsets itemPadding;

  /// Focus scope state for keyboard navigation.
  final SubFocusScopeState focusScope;

  /// Creates menu group data.
  ///
  /// Parameters:
  /// - [parent] (VNLMenuGroupData?): Parent group
  /// - [children] (`List<VNLMenuData>`): Child items
  /// - [hasLeading] (bool): Whether items have leading widgets
  /// - [subMenuOffset] (Offset?): Submenu offset
  /// - [onDismissed] (VoidCallback?): Dismissal callback
  /// - [regionGroupId] (Object?): Region group ID
  /// - [direction] (Axis): Layout direction
  /// - [itemPadding] (EdgeInsets): Item padding
  /// - [focusScope] (SubFocusScopeState): Focus scope
  VNLMenuGroupData(
    this.parent,
    this.children,
    this.hasLeading,
    this.subMenuOffset,
    this.onDismissed,
    this.regionGroupId,
    this.direction,
    this.itemPadding,
    this.focusScope,
  );

  /// Checks if any child menu items have open popovers.
  ///
  /// Returns true if at least one child has an open submenu popover.
  bool get hasOpenPopovers {
    for (final child in children) {
      if (child.popoverController.hasOpenPopover) {
        return true;
      }
    }
    return false;
  }

  /// Closes all open popovers in child menu items.
  ///
  /// Iterates through children and closes any open submenu popovers.
  void closeOthers() {
    for (final child in children) {
      child.popoverController.close();
    }
  }

  /// Closes all menus in the hierarchy by bubbling up to root.
  ///
  /// Recursively closes popovers in parent groups and invokes the
  /// dismissal callback at the root level.
  void closeAll() {
    var menuGroupData = parent;
    if (menuGroupData == null) {
      onDismissed?.call();
      return;
    }
    menuGroupData.closeOthers();
    menuGroupData.closeAll();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is VNLMenuGroupData) {
      return listEquals(children, other.children) &&
          parent == other.parent &&
          hasLeading == other.hasLeading &&
          subMenuOffset == other.subMenuOffset &&
          onDismissed == other.onDismissed;
    }
    return false;
  }

  /// Gets the root menu group in the hierarchy.
  ///
  /// Traverses up the parent chain to find the topmost menu group.
  ///
  /// Returns the root [VNLMenuGroupData].
  VNLMenuGroupData get root {
    var menuGroupData = parent;
    if (menuGroupData == null) {
      return this;
    }
    return menuGroupData.root;
  }

  @override
  int get hashCode => Object.hash(
        children,
        parent,
        hasLeading,
        subMenuOffset,
        onDismissed,
      );

  @override
  String toString() {
    return 'VNLMenuGroupData{parent: $parent, children: $children, hasLeading: $hasLeading, subMenuOffset: $subMenuOffset, onDismissed: $onDismissed, regionGroupId: $regionGroupId, direction: $direction}';
  }
}

/// Data container for individual menu item state.
///
/// Wraps a popover controller for each menu item, managing submenu
/// display and interaction state.
class VNLMenuData {
  /// Controller for this item's submenu popover.
  final VNLPopoverController popoverController;

  /// Creates menu item data.
  ///
  /// Parameters:
  /// - [popoverController] (VNLPopoverController?): Optional controller, creates default if null
  VNLMenuData({VNLPopoverController? popoverController})
      : popoverController = popoverController ?? VNLPopoverController();
}

/// Container widget for organizing menu items into a group.
///
/// Provides layout, focus management, and keyboard navigation for a collection
/// of menu items. Supports both horizontal and vertical orientations, nested
/// submenus, and customizable actions.
///
/// Example:
/// ```dart
/// VNLMenuGroup(
///   direction: Axis.vertical,
///   builder: (context, children) => Column(children: children),
///   children: [
///     VNLMenuButton(child: Text('Cut')),
///     VNLMenuButton(child: Text('Copy')),
///     VNLMenuDivider(),
///     VNLMenuButton(child: Text('Paste')),
///   ],
/// )
/// ```
class VNLMenuGroup extends StatefulWidget {
  /// List of menu item widgets.
  final List<VNLMenuItem> children;

  /// Builder function that layouts the menu items.
  final Widget Function(BuildContext context, List<Widget> children) builder;

  /// Parent menu group for nested submenus.
  final VNLMenuGroupData? parent;

  /// Offset for positioning submenus.
  final Offset? subMenuOffset;

  /// Callback when menu is dismissed.
  final VoidCallback? onDismissed;

  /// Region group ID for tap region management.
  final Object? regionGroupId;

  /// Layout direction (horizontal or vertical).
  final Axis direction;

  /// Custom keyboard actions.
  final Map<Type, Action> actions;

  /// Padding around menu items.
  final EdgeInsets? itemPadding;

  /// Whether to autofocus on mount.
  final bool autofocus;

  /// Optional focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Creates a menu group.
  ///
  /// Parameters:
  /// - [children] (`List<VNLMenuItem>`, required): Menu items
  /// - [builder] (Function, required): Layout builder
  /// - [direction] (Axis, required): Layout direction
  /// - [parent] (VNLMenuGroupData?): Parent group for nesting
  /// - [subMenuOffset] (Offset?): Submenu positioning offset
  /// - [onDismissed] (VoidCallback?): Dismissal callback
  /// - [regionGroupId] (Object?): Tap region group ID
  /// - [actions] (`Map<Type, Action>`): Custom actions, defaults to empty
  /// - [itemPadding] (EdgeInsets?): Item padding
  /// - [autofocus] (bool): Auto-focus behavior, defaults to true
  /// - [focusNode] (FocusNode?): Focus node
  const VNLMenuGroup({
    super.key,
    required this.children,
    required this.builder,
    this.parent,
    this.subMenuOffset,
    this.onDismissed,
    this.regionGroupId,
    this.actions = const {},
    required this.direction,
    this.itemPadding,
    this.autofocus = true,
    this.focusNode,
  });

  @override
  State<VNLMenuGroup> createState() => _MenuGroupState();
}

class _MenuGroupState extends State<VNLMenuGroup> {
  late List<VNLMenuData> _data;

  @override
  void initState() {
    super.initState();
    _data = List.generate(widget.children.length, (i) {
      return VNLMenuData();
    });
  }

  @override
  void didUpdateWidget(covariant VNLMenuGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.children, widget.children)) {
      Map<Key, VNLMenuData> oldKeyedData = {};
      for (int i = 0; i < oldWidget.children.length; i++) {
        oldKeyedData[oldWidget.children[i].key ?? ValueKey(i)] = _data[i];
      }
      _data = List.generate(widget.children.length, (i) {
        var child = widget.children[i];
        var key = child.key ?? ValueKey(i);
        var oldData = oldKeyedData[key];
        if (oldData != null) {
          if (child.popoverController != null &&
              oldData.popoverController != child.popoverController) {
            oldData.popoverController.dispose();
            oldData = VNLMenuData(popoverController: child.popoverController);
          }
        } else {
          oldData = VNLMenuData(popoverController: child.popoverController);
        }
        return oldData;
      });
      // dispose unused data
      for (var data in oldKeyedData.values) {
        if (!_data.contains(data)) {
          data.popoverController.dispose();
        }
      }
    }
  }

  @override
  void dispose() {
    for (var data in _data) {
      data.popoverController.dispose();
    }
    super.dispose();
  }

  void closeAll() {
    VNLMenuGroupData? data = widget.parent;
    if (data == null) {
      widget.onDismissed?.call();
      return;
    }
    data.closeOthers();
    data.closeAll();
  }

  @override
  Widget build(BuildContext context) {
    final parentGroupData = Data.maybeOf<VNLMenuGroupData>(context);
    final menubarData = Data.maybeOf<VNLMenubarState>(context);
    final compTheme = VNLComponentTheme.maybeOf<VNLMenuTheme>(context);
    final itemPadding =
        widget.itemPadding ?? compTheme?.itemPadding ?? EdgeInsets.zero;
    final subMenuOffset = widget.subMenuOffset ?? compTheme?.subMenuOffset;
    List<Widget> children = [];
    bool hasLeading = false;
    for (int i = 0; i < widget.children.length; i++) {
      final child = widget.children[i];
      final data = _data[i];
      if (child.hasLeading) {
        hasLeading = true;
      }
      children.add(
        Data<VNLMenuData>.inherit(
          data: data,
          child: child,
        ),
      );
    }
    final direction = Directionality.of(context);
    return VNLSubFocusScope(
        autofocus: widget.autofocus,
        builder: (context, scope) {
          return Actions(
            actions: {
              VNLNextMenuFocusIntent: CallbackAction<VNLNextMenuFocusIntent>(
                onInvoke: (intent) {
                  scope.nextFocus(intent.forward
                      ? widget.direction == Axis.horizontal
                          ? TraversalDirection.left
                          : TraversalDirection.up
                      : widget.direction == Axis.horizontal
                          ? TraversalDirection.right
                          : TraversalDirection.down);
                  return;
                },
              ),
              VNLDirectionalMenuFocusIntent:
                  CallbackAction<VNLDirectionalMenuFocusIntent>(
                onInvoke: (intent) {
                  if (widget.direction == Axis.vertical) {
                    if (intent.direction == TraversalDirection.left) {
                      if (direction == TextDirection.ltr) {
                        for (final menu in parentGroupData?.children ?? []) {
                          menu.popoverController.close();
                        }
                        return;
                      } else {}
                    } else if (intent.direction == TraversalDirection.right) {
                      if (direction == TextDirection.ltr) {
                        bool? result = scope.invokeActionOnFocused(
                            const VNLOpenSubMenuIntent()) as bool?;
                        if (result != true) {
                          parentGroupData?.root.focusScope
                              .nextFocus(TraversalDirection.right);
                        }
                        return;
                      } else {}
                    }
                  }
                  if (!scope.nextFocus(intent.direction)) {
                    for (final menu in parentGroupData?.children ?? []) {
                      menu.popoverController.close();
                    }
                    parentGroupData?.focusScope.nextFocus(
                      intent.direction,
                    );
                  }
                  return;
                },
              ),
              VNLCloseMenuIntent: CallbackAction<VNLCloseMenuIntent>(
                onInvoke: (intent) {
                  closeAll();
                  return;
                },
              ),
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (intent) {
                  scope.invokeActionOnFocused(const ActivateIntent());
                  return;
                },
              ),
              ...widget.actions,
            },
            child: Shortcuts(
              shortcuts: {
                const SingleActivator(LogicalKeyboardKey.arrowUp):
                    const VNLDirectionalMenuFocusIntent(TraversalDirection.up),
                const SingleActivator(LogicalKeyboardKey.arrowDown):
                    const VNLDirectionalMenuFocusIntent(TraversalDirection.down),
                const SingleActivator(LogicalKeyboardKey.arrowLeft):
                    const VNLDirectionalMenuFocusIntent(TraversalDirection.left),
                const SingleActivator(LogicalKeyboardKey.arrowRight):
                    const VNLDirectionalMenuFocusIntent(TraversalDirection.right),
                const SingleActivator(LogicalKeyboardKey.tab):
                    VNLDirectionalMenuFocusIntent(widget.direction == Axis.vertical
                        ? TraversalDirection.down
                        : TraversalDirection.right),
                const SingleActivator(LogicalKeyboardKey.tab, shift: true):
                    VNLDirectionalMenuFocusIntent(widget.direction == Axis.vertical
                        ? TraversalDirection.up
                        : TraversalDirection.left),
                const SingleActivator(LogicalKeyboardKey.escape):
                    const VNLCloseMenuIntent(),
                const SingleActivator(LogicalKeyboardKey.enter):
                    const ActivateIntent(),
                const SingleActivator(LogicalKeyboardKey.space):
                    const ActivateIntent(),
                const SingleActivator(LogicalKeyboardKey.backspace):
                    const VNLCloseMenuIntent(),
                const SingleActivator(LogicalKeyboardKey.numpadEnter):
                    const ActivateIntent(),
              },
              child: Focus(
                autofocus: menubarData == null,
                focusNode: widget.focusNode,
                child: Data.inherit(
                  data: VNLMenuGroupData(
                    widget.parent,
                    _data,
                    hasLeading,
                    subMenuOffset,
                    widget.onDismissed,
                    widget.regionGroupId,
                    widget.direction,
                    itemPadding,
                    scope,
                  ),
                  child: Builder(builder: (context) {
                    return widget.builder(context, children);
                  }),
                ),
              ),
            ),
          );
        });
  }
}

/// Intent for closing the current menu via keyboard action.
///
/// Used with keyboard shortcuts to dismiss open menus.
class VNLCloseMenuIntent extends Intent {
  /// Creates a close menu intent.
  const VNLCloseMenuIntent();
}

/// Intent for opening a submenu via keyboard action.
///
/// Triggers submenu expansion when navigating with keyboard.
class VNLOpenSubMenuIntent extends Intent {
  /// Creates an open submenu intent.
  const VNLOpenSubMenuIntent();
}

/// Intent for moving focus to next/previous menu item.
///
/// Used for keyboard navigation within menus (Tab/Shift+Tab).
class VNLNextMenuFocusIntent extends Intent {
  /// Whether to move focus forward (true) or backward (false).
  final bool forward;

  /// Creates a next menu focus intent.
  ///
  /// Parameters:
  /// - [forward] (bool, required): Direction of focus movement
  const VNLNextMenuFocusIntent(this.forward);
}

/// Overlay handler specialized for menu popover display.
///
/// Delegates to an [VNLOverlayManager] to show menu popovers with
/// appropriate positioning, transitions, and dismissal behavior.
class VNLMenuOverlayHandler extends VNLOverlayHandler {
  /// The overlay manager handling menu display.
  final VNLOverlayManager manager;

  /// Creates a menu overlay handler.
  ///
  /// Parameters:
  /// - [manager] (VNLOverlayManager, required): Overlay manager for menu display
  const VNLMenuOverlayHandler(this.manager);

  @override
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    VNLPopoverConstraint widthConstraint = VNLPopoverConstraint.flexible,
    VNLPopoverConstraint heightConstraint = VNLPopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<VNLPopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    VNLOverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
  }) {
    return manager.showMenu(
      context: context,
      alignment: alignment,
      builder: builder,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      barrierDismissable: barrierDismissable,
      clipBehavior: clipBehavior,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
      layerLink: layerLink,
    );
  }
}

/// Intent for directional focus traversal within menus.
///
/// Used for arrow key navigation (up, down, left, right) within menu structures.
class VNLDirectionalMenuFocusIntent extends Intent {
  /// Direction of focus traversal.
  final TraversalDirection direction;

  /// Creates a directional menu focus intent.
  ///
  /// Parameters:
  /// - [direction] (TraversalDirection, required): Traversal direction
  const VNLDirectionalMenuFocusIntent(this.direction);
}
