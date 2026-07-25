import 'package:vnl_common_ui/shadcn_flutter.dart';

class NavigationRailExample1 extends StatefulWidget {
  const NavigationRailExample1({super.key});

  @override
  State<NavigationRailExample1> createState() => _NavigationRailExample1State();
}

class _NavigationRailExample1State extends State<NavigationRailExample1> {
  VNLNavigationRailAlignment alignment = VNLNavigationRailAlignment.start;
  VNLNavigationLabelType labelType = VNLNavigationLabelType.none;
  VNLNavigationLabelPosition labelPosition = VNLNavigationLabelPosition.bottom;
  bool customButtonStyle = false;
  bool expanded = true;

  String selected = 'Home';

  VNLNavigationItem buildButton(String label, IconData icon) {
    return VNLNavigationItem(
      selected: selected == label,
      style: customButtonStyle
          ? const VNLButtonStyle.muted(density: VNLButtonDensity.icon)
          : null,
      selectedStyle: customButtonStyle
          ? const VNLButtonStyle.fixed(density: VNLButtonDensity.icon)
          : null,
      onChanged: (selected) {
        if (selected) {
          setState(() {
            this.selected = label;
          });
        }
      },
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VNLScaffold(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VNLNavigationRail(
            alignment: alignment,
            labelType: labelType,
            labelPosition: labelPosition,
            expanded: expanded,
            children: [
              buildButton('Home', BootstrapIcons.house),
              buildButton('Explore', BootstrapIcons.compass),
              buildButton('Library', BootstrapIcons.musicNoteList),
              const VNLNavigationDivider(),
              VNLNavigationGroup(
                label: const Text('Settings'),
                children: [
                  buildButton('Profile', BootstrapIcons.person),
                  buildButton('App', BootstrapIcons.appIndicator),
                ],
              ),
              const VNLNavigationDivider(),
              const VNLNavigationGap(12),
              const FlutterLogo(),
            ],
          ),
          const VNLVerticalDivider(),
          Expanded(
            child: Container(
              color:
                  VNLColors.primaries[selected.hashCode % VNLColors.primaries.length],
              padding: const EdgeInsets.all(24),
              child: VNLCard(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    // Alignment of items within the rail.
                    Select<VNLNavigationRailAlignment>(
                      value: alignment,
                      itemBuilder:
                          (BuildContext context, VNLNavigationRailAlignment item) {
                        return Text(item.name);
                      },
                      popupWidthConstraint: VNLPopoverConstraint.anchorFixedSize,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            alignment = value;
                          });
                        }
                      },
                      popup: SelectPopup(
                          items: VNLSelectItemList(children: [
                        for (var value in VNLNavigationRailAlignment.values)
                          SelectItemButton(
                            value: value,
                            child: Text(value.name),
                          ),
                      ])),
                    ),
                    // VNLLabel visibility behavior for each destination.
                    Select<VNLNavigationLabelType>(
                      value: labelType,
                      itemBuilder:
                          (BuildContext context, VNLNavigationLabelType item) {
                        return Text(item.name);
                      },
                      popupConstraints:
                          BoxConstraints.tight(const Size(200, 200)),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            labelType = value;
                          });
                        }
                      },
                      popup: SelectPopup(
                        items: VNLSelectItemList(
                          children: [
                            for (var value in VNLNavigationLabelType.values)
                              SelectItemButton(
                                value: value,
                                child: Text(value.name),
                              ),
                          ],
                        ),
                      ),
                    ),
                    // Where the label appears relative to the icon.
                    Select<VNLNavigationLabelPosition>(
                      value: labelPosition,
                      itemBuilder:
                          (BuildContext context, VNLNavigationLabelPosition item) {
                        return Text(item.name);
                      },
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            labelPosition = value;
                          });
                        }
                      },
                      popup: SelectPopup(
                        items: VNLSelectItemList(
                          children: [
                            for (var value in VNLNavigationLabelPosition.values)
                              SelectItemButton(
                                value: value,
                                child: Text(value.name),
                              ),
                          ],
                        ),
                      ),
                    ),
                    // VNLToggle custom vs default button styles for normal/selected.
                    VNLCheckbox(
                      state: customButtonStyle
                          ? VNLCheckboxState.checked
                          : VNLCheckboxState.unchecked,
                      onChanged: (value) {
                        setState(() {
                          customButtonStyle = value == VNLCheckboxState.checked;
                        });
                      },
                      trailing: const Text('Custom VNLButton Style'),
                    ),
                    // Whether the rail is in expanded mode (shows labels, etc.).
                    VNLCheckbox(
                      state: expanded
                          ? VNLCheckboxState.checked
                          : VNLCheckboxState.unchecked,
                      onChanged: (value) {
                        setState(() {
                          expanded = value == VNLCheckboxState.checked;
                        });
                      },
                      trailing: const Text('Expanded'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
