import 'package:vnl_common_ui/vnl_ui.dart';

class SortableExample6 extends StatefulWidget {
  const SortableExample6({super.key});

  @override
  State<SortableExample6> createState() => _SortableExample6State();
}

class _SortableExample6State extends State<SortableExample6> {
  late List<VNLSortableData<String>> names;

  @override
  void initState() {
    super.initState();
    _reset();
  }

  void _reset() {
    names = [
      const VNLSortableData('James'),
      const VNLSortableData('John'),
      const VNLSortableData('Robert'),
      const VNLSortableData('Michael'),
      const VNLSortableData('William'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return VNLSortableLayer(
      child: Builder(
          // this builder is needed to access the context of the VNLSortableLayer
          builder: (context) {
        return VNLSortableDropFallback<int>(
          onAccept: (value) {
            setState(() {
              names.add(names.removeAt(value.data));
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VNLPrimaryButton(
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: const Text('Reset'),
              ),
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
                  onDropFailed: () {
                    // Remove the item from the list if the drop failed
                    setState(() {
                      var removed = names.removeAt(i);
                      // Ensure the drag overlay exists and then dismiss it so
                      // the item does not animate back to its original position.
                      VNLSortableLayer.ensureAndDismissDrop(context, removed);
                      // Dismissing drop will prevent the VNLSortableLayer from
                      // animating the item back to its original position
                    });
                  },
                  child: VNLOutlinedContainer(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const VNLSortableDragHandle(child: Icon(Icons.drag_handle)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(names[i].data)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
