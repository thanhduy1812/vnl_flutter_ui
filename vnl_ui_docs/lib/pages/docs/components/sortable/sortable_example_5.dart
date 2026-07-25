import 'package:vnl_common_ui/vnl_ui.dart';

class SortableExample5 extends StatefulWidget {
  const SortableExample5({super.key});

  @override
  State<SortableExample5> createState() => _SortableExample5State();
}

class _SortableExample5State extends State<SortableExample5> {
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
      lock: true,
      child: VNLSortableDropFallback<int>(
        // Dropping outside edge targets appends the item to the end.
        onAccept: (value) {
          setState(() {
            names.add(names.removeAt(value.data));
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < names.length; i++)
              Sortable<String>(
                key: ValueKey(i),
                data: names[i],
                // we only want user to drag the item from the handle,
                // so we disable the drag on the item itself
                enabled: false,
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
                  child: Row(
                    children: [
                      // Only this handle starts the drag; the rest of the row is inert.
                      const VNLSortableDragHandle(child: Icon(Icons.drag_handle)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(names[i].data)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
