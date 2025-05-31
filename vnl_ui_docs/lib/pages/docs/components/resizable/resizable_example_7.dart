import 'dart:math';

import 'package:vnl_common_ui/vnl_ui.dart';

class ResizableExample7 extends StatefulWidget {
  const ResizableExample7({super.key});

  @override
  State<ResizableExample7> createState() => _ResizableExample7State();
}

class _ResizableExample7State extends State<ResizableExample7> {
  final List<Color> _items = List.generate(2, (index) => _generateColor());

  static Color _generateColor() {
    Random random = Random();
    return HSVColor.fromAHSV(
      1.0,
      random.nextInt(360).toDouble(),
      0.8,
      0.8,
    ).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          ResizablePanel.vertical(
            children: [
              for (int i = 0; i < _items.length; i++)
                ResizablePane(
                  key: ValueKey(_items[i].toARGB32()),
                  initialSize: 200,
                  minSize: 100,
                  child: Container(
                    color: _items[i],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: const Text('Insert Before'),
                            onPressed: () {
                              setState(() {
                                _items.insert(i, _generateColor());
                              });
                            },
                          ),
                          TextButton(
                            child: const Text('Remove'),
                            onPressed: () {
                              setState(() {
                                _items.removeAt(i);
                              });
                            },
                          ),
                          TextButton(
                            child: const Text('Insert After'),
                            onPressed: () {
                              setState(() {
                                _items.insert(i + 1, _generateColor());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          PrimaryButton(
            child: const Text('Add'),
            onPressed: () {
              setState(() {
                _items.add(_generateColor());
              });
            },
          ),
        ],
      ),
    );
  }
}
