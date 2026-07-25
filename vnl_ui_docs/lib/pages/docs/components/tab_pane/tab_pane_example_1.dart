import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates TabPane with sortable, closable tabs backed by custom data.
// Tracks a focused index and renders a content area for the active tab.

class TabPaneExample1 extends StatefulWidget {
  const TabPaneExample1({super.key});

  @override
  State<TabPaneExample1> createState() => _TabPaneExample1State();
}

class MyTab {
  final String title;
  final int count;
  final String content;
  MyTab(this.title, this.count, this.content);

  @override
  String toString() {
    return 'TabData{title: $title, count: $count, content: $content}';
  }
}

class _TabPaneExample1State extends State<TabPaneExample1> {
  late List<VNLTabPaneData<MyTab>> tabs;
  int focused = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Build the initial set of tabs. VNLTabPaneData wraps your custom data type
    // (here, MyTab) and adds selection/drag metadata.
    tabs = [
      for (int i = 0; i < 3; i++) VNLTabPaneData(MyTab('Tab ${i + 1}', i + 1, 'Content ${i + 1}')),
    ];
  }

  // Render a single tab header item. It shows a badge-like count and a close button.
  VNLTabItem _buildTabItem(MyTab data) {
    return VNLTabItem(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 150),
        child: VNLLabel(
          leading: VNLOutlinedContainer(
            backgroundColor: VNLColors.white,
            width: 18,
            height: 18,
            borderRadius: Theme.of(context).borderRadiusMd,
            child: Center(
              child: Text(
                data.count.toString(),
                style: const TextStyle(color: VNLColors.black),
              ).xSmall().bold(),
            ),
          ),
          trailing: VNLIconButton.ghost(
            shape: VNLButtonShape.circle,
            size: VNLButtonSize.xSmall,
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                tabs.remove(data);
              });
            },
          ),
          child: Text(data.title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabPane<MyTab>(
      // children: tabs.map((e) => _buildTabItem(e)).toList(),
      // Provide the items and how to render each tab header.
      items: tabs,
      itemBuilder: (context, item, index) {
        return _buildTabItem(item.data);
      },
      // The currently focused tab index.
      focused: focused,
      onFocused: (value) {
        setState(() {
          focused = value;
        });
      },
      // Allow reordering via drag-and-drop; update the list with the new order.
      onSort: (value) {
        setState(() {
          tabs = value;
        });
      },
      // Optional leading/trailing actions for the tab strip.
      leading: [
        VNLIconButton.secondary(
          icon: const Icon(Icons.arrow_drop_down),
          size: VNLButtonSize.small,
          density: VNLButtonDensity.iconDense,
          onPressed: () {},
        ),
      ],
      trailing: [
        VNLIconButton.ghost(
          icon: const Icon(Icons.add),
          size: VNLButtonSize.small,
          density: VNLButtonDensity.iconDense,
          onPressed: () {
            setState(() {
              int max = tabs.fold<int>(0, (previousValue, element) {
                return element.data.count > previousValue ? element.data.count : previousValue;
              });
              tabs.add(VNLTabPaneData(MyTab('Tab ${max + 1}', max + 1, 'Content ${max + 1}')));
            });
          },
        )
      ],
      // The content area; you can render based on the focused index.
      child: SizedBox(
        height: 400,
        child: Center(
          child: Text('Tab ${focused + 1}').xLarge().bold(),
        ),
      ),
    );
  }
}
