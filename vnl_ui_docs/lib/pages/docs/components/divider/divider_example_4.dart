import 'package:vnl_common_ui/shadcn_flutter.dart';

class DividerExample4 extends StatelessWidget {
  const DividerExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLOutlinedContainer(
      width: 600,
      height: 400,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).colorScheme.border.withAlpha(64),
            width: 100,
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                return VNLButton.ghost(
                  onPressed: () {},
                  child: Text('VNLButton $index'),
                );
              },
            ),
          ),
          PaintOrder(
            paintOrder: 3,
            child: VNLVerticalDivider(
              childAlignment: const AxisAlignment(-0.6),
              padding: EdgeInsets.zero,
              child: VNLIconButton.outline(
                icon: const Icon(Icons.arrow_back_ios_new),
                shape: VNLButtonShape.circle,
                size: VNLButtonSize.small,
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: VNLColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
