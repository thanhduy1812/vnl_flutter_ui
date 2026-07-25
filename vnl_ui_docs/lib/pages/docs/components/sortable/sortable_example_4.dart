import 'package:vnl_common_ui/vnl_ui.dart';

class SortableExample4 extends StatefulWidget {
  const SortableExample4({super.key});

  @override
  State<SortableExample4> createState() => _SortableExample4State();
}

class _SortableExample4State extends State<SortableExample4> {
  List<VNLSortableData<String>> names = [
    const VNLSortableData('James'),
    const VNLSortableData('John'),
    const VNLSortableData('Robert'),
    const VNLSortableData('Michael'),
    const VNLSortableData('William'),
    const VNLSortableData('David'),
    const VNLSortableData('Richard'),
    const VNLSortableData('Joseph'),
    const VNLSortableData('Thomas'),
    const VNLSortableData('Charles'),
    const VNLSortableData('Daniel'),
    const VNLSortableData('Matthew'),
    const VNLSortableData('Anthony'),
    const VNLSortableData('Donald'),
    const VNLSortableData('Mark'),
    const VNLSortableData('Paul'),
    const VNLSortableData('Steven'),
    const VNLSortableData('Andrew'),
    const VNLSortableData('Kenneth'),
  ];

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: VNLSortableLayer(
        // Constrain drag overlays to the layer bounds so they scroll within the list.
        lock: true,
        child: VNLSortableDropFallback<int>(
          // If dropped outside a specific edge target, append to the end.
          onAccept: (value) {
            setState(() {
              names.add(names.removeAt(value.data));
            });
          },
          // Wrap the scrollable so auto-scrolling can occur while dragging near edges.
          child: VNLScrollableSortableLayer(
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, i) {
                return Sortable<String>(
                  // Stable key helps maintain drag state with virtualization.
                  key: ValueKey(i),
                  data: names[i],
                  onAcceptTop: (value) {
                    setState(() {
                      names.swapItem(value, i);
                    });
                  },
                  onAcceptBottom: (value) {
                    setState(() {
                      names.swapItem(value, i + 1);
                    });
                  },
                  child: VNLOutlinedContainer(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(names[i].data)),
                  ),
                );
              },
              itemCount: names.length,
            ),
          ),
        ),
      ),
    );
  }
}
