import 'package:vnl_common_ui/vnl_ui.dart';

class SortableExample3 extends StatefulWidget {
  const SortableExample3({super.key});

  @override
  State<SortableExample3> createState() => _SortableExample3State();
}

class _SortableExample3State extends State<SortableExample3> {
  List<VNLSortableData<String>> names = [
    const VNLSortableData('James'),
    const VNLSortableData('John'),
    const VNLSortableData('Robert'),
    const VNLSortableData('Michael'),
    const VNLSortableData('William'),
  ];

  @override
  Widget build(BuildContext context) {
    return VNLSortableLayer(
      // Constrain the drag overlay within the horizontal strip.
      lock: true,
      child: VNLSortableDropFallback<int>(
        onAccept: (value) {
          setState(() {
            names.add(names.removeAt(value.data));
          });
        },
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < names.length; i++)
                Sortable<String>(
                  key: ValueKey(i),
                  data: names[i],
                  // For horizontal sorting, drop on the left/right edges to reorder.
                  onAcceptLeft: (value) {
                    setState(() {
                      names.swapItem(value, i);
                    });
                  },
                  onAcceptRight: (value) {
                    setState(() {
                      names.swapItem(value, i + 1);
                    });
                  },
                  child: VNLOutlinedContainer(
                    width: 100,
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(names[i].data)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
