import 'package:vnl_common_ui/vnl_ui.dart';

class AnimatedValueBuilderExample2 extends StatefulWidget {
  const AnimatedValueBuilderExample2({super.key});

  @override
  State<AnimatedValueBuilderExample2> createState() => _AnimatedValueBuilderExample2State();
}

class _AnimatedValueBuilderExample2State extends State<AnimatedValueBuilderExample2> {
  List<Color> colors = [
    VNLColors.red,
    VNLColors.green,
    VNLColors.blue,
  ];
  int index = 0;
  int rebuildCount = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedValueBuilder(
          key: ValueKey(rebuildCount),
          value: colors[index],
          initialValue: colors[index].withValues(alpha: 0),
          duration: const Duration(seconds: 1),
          lerp: Color.lerp,
          builder: (context, value, child) {
            return Container(
              width: 100,
              height: 100,
              color: value,
            );
          },
        ),
        const Gap(32),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(
              onPressed: () {
                setState(() {
                  index = (index + 1) % colors.length;
                });
              },
              child: const Text('Change Color'),
            ),
            const Gap(24),
            PrimaryButton(
              onPressed: () {
                setState(() {
                  rebuildCount++;
                });
              },
              child: const Text('Rebuild'),
            ),
          ],
        ),
      ],
    );
  }
}
