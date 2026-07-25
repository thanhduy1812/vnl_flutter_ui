import 'package:vnl_common_ui/vnl_ui.dart';

class PaintOrderExample3 extends StatefulWidget {
  const PaintOrderExample3({super.key});

  @override
  State<PaintOrderExample3> createState() => _PaintOrderExample3State();
}

class _PaintOrderExample3State extends State<PaintOrderExample3> {
  final List<int> _paintOrders = [0, 0, 0];
  int _topIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = [VNLColors.red, VNLColors.green, VNLColors.blue];
    return VNLOutlinedContainer(
      width: 350,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 120,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (int i = 0; i < 3; i++)
                  Positioned(
                    left: i * 50.0,
                    top: i * 20.0,
                    paintOrder: _paintOrders[i],
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _paintOrders[i] = ++_topIndex),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: colors[i],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: VNLColors.black.withAlpha(64),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'VNLCard ${i + 1}',
                            style: const TextStyle(color: VNLColors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Tap a card to bring it to front'),
        ],
      ),
    );
  }
}
