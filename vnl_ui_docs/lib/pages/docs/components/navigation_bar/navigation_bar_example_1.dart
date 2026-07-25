import 'package:vnl_common_ui/vnl_ui.dart';

class NavigationBarExample1 extends StatefulWidget {
  const NavigationBarExample1({super.key});

  @override
  State<NavigationBarExample1> createState() => _NavigationBarExample1State();
}

class _NavigationBarExample1State extends State<NavigationBarExample1> {
  Key? selected = const ValueKey(0);

  VNLNavigationBarAlignment alignment = VNLNavigationBarAlignment.spaceAround;
  VNLNavigationLabelType labelType = VNLNavigationLabelType.none;
  bool customButtonStyle = true;
  bool expanded = true;

  VNLNavigationItem buildButton(String label, IconData icon, Key key) {
    return VNLNavigationItem(
      key: key,
      style: customButtonStyle
          ? const VNLButtonStyle.muted(density: VNLButtonDensity.icon)
          : null,
      selectedStyle: customButtonStyle
          ? const VNLButtonStyle.fixed(density: VNLButtonDensity.icon)
          : null,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VNLOutlinedContainer(
      width: 500,
      height: 400,
      child: VNLScaffold(
        footers: [
          const VNLDivider(),
          VNLNavigationBar(
            alignment: alignment,
            labelType: labelType,
            expanded: expanded,
            onSelected: (key) {
              setState(() {
                selected = key;
              });
            },
            selectedKey: selected,
            children: [
              buildButton('Home', BootstrapIcons.house, const ValueKey(0)),
              buildButton('Explore', BootstrapIcons.compass, const ValueKey(1)),
              buildButton(
                  'Library', BootstrapIcons.musicNoteList, const ValueKey(2)),
              buildButton('Profile', BootstrapIcons.person, const ValueKey(3)),
              buildButton(
                  'App', BootstrapIcons.appIndicator, const ValueKey(4)),
            ],
          ),
        ],
        child: Container(
          color: VNLColors.primaries[
              VNLColors.primaries.length - (selected as ValueKey<int>).value - 1],
          padding: const EdgeInsets.all(24),
          child: VNLCard(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 8,
              spacing: 8,
              children: [
                // Configure how the items are distributed across the bar.
                Select<VNLNavigationBarAlignment>(
                  value: alignment,
                  itemBuilder:
                      (BuildContext context, VNLNavigationBarAlignment item) {
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
                    for (var value in VNLNavigationBarAlignment.values)
                      SelectItemButton(
                        value: value,
                        child: Text(value.name),
                      ),
                  ])),
                ),
                // Control how labels are shown for each navigation item.
                Select<VNLNavigationLabelType>(
                  value: labelType,
                  itemBuilder:
                      (BuildContext context, VNLNavigationLabelType item) {
                    return Text(item.name);
                  },
                  popupWidthConstraint: VNLPopoverConstraint.anchorFixedSize,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        labelType = value;
                      });
                    }
                  },
                  popup: SelectPopup(
                      items: VNLSelectItemList(children: [
                    for (var value in VNLNavigationLabelType.values)
                      SelectItemButton(
                        value: value,
                        child: Text(value.name),
                      ),
                  ])),
                ),
                // Use custom button styles for normal vs selected states.
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
                // VNLToggle the expanded label behavior.
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
    );
  }
}
