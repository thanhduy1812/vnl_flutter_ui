import 'package:vnl_common_ui/vnl_ui.dart';

class PaintOrderExample1 extends StatelessWidget {
  const PaintOrderExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLOutlinedContainer(
      width: 300,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First child (painted first, appears below)
          Transform.translate(
            offset: const Offset(20, 0),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: VNLColors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Below',
                  style: TextStyle(color: VNLColors.white),
                ),
              ),
            ),
          ),
          // Second child with higher paintOrder (painted last, appears on top)
          PaintOrder(
            paintOrder: 1,
            child: Transform.translate(
              offset: const Offset(-20, 0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: VNLColors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'On Top',
                    style: TextStyle(color: VNLColors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
