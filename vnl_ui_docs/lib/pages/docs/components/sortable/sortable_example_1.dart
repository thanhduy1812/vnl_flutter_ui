import 'package:vnl_common_ui/vnl_ui.dart';

class SortableExample1 extends StatefulWidget {
  const SortableExample1({super.key});

  @override
  State<SortableExample1> createState() => _SortableExample1State();
}

class _SortableExample1State extends State<SortableExample1> {
  // Two separate lists for demonstrating cross-list drag-and-drop.
  List<VNLSortableData<String>> invited = [
    const VNLSortableData('James'),
    const VNLSortableData('John'),
    const VNLSortableData('Robert'),
    const VNLSortableData('Michael'),
    const VNLSortableData('William'),
  ];
  List<VNLSortableData<String>> reserved = [
    const VNLSortableData('David'),
    const VNLSortableData('Richard'),
    const VNLSortableData('Joseph'),
    const VNLSortableData('Thomas'),
    const VNLSortableData('Charles'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: VNLSortableLayer(
        // The VNLSortableLayer coordinates drag-over/accept behavior for nested Sortable zones.
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: VNLCard(
                child: VNLSortableDropFallback<String>(
                  // If dropped into empty space in this list, append to the end.
                  onAccept: (value) {
                    setState(() {
                      swapItemInLists([invited, reserved], value, invited, invited.length);
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < invited.length; i++)
                        Sortable<String>(
                          data: invited[i],
                          // Insert above the current index when dropped at the top edge.
                          onAcceptTop: (value) {
                            setState(() {
                              swapItemInLists([invited, reserved], value, invited, i);
                            });
                          },
                          // Insert below the current index when dropped at the bottom edge.
                          onAcceptBottom: (value) {
                            setState(() {
                              swapItemInLists([invited, reserved], value, invited, i + 1);
                            });
                          },
                          child: VNLOutlinedContainer(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(invited[i].data)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            gap(12),
            Expanded(
              child: VNLCard(
                child: VNLSortableDropFallback<String>(
                  // Same behavior for the second list.
                  onAccept: (value) {
                    setState(() {
                      swapItemInLists([invited, reserved], value, reserved, reserved.length);
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < reserved.length; i++)
                        Sortable<String>(
                          data: reserved[i],
                          onAcceptTop: (value) {
                            setState(() {
                              swapItemInLists([invited, reserved], value, reserved, i);
                            });
                          },
                          onAcceptBottom: (value) {
                            setState(() {
                              swapItemInLists([invited, reserved], value, reserved, i + 1);
                            });
                          },
                          child: VNLOutlinedContainer(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(reserved[i].data)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
