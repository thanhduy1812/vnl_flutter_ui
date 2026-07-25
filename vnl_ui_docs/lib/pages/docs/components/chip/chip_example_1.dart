import 'package:vnl_common_ui/vnl_ui.dart';

/// Chips with trailing remove buttons in different styles.
///
/// Demonstrates how to compose [VNLChip] with a [VNLChipButton] trailing action,
/// and how to apply various [VNLButtonStyle] presets.
class ChipExample1 extends StatelessWidget {
  const ChipExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VNLChip(
          // Trailing action; in real apps you might remove the chip.
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Apple'),
        ),
        VNLChip(
          // Primary-styled chip.
          style: const VNLButtonStyle.primary(),
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Banana'),
        ),
        VNLChip(
          // Outlined chip.
          style: const VNLButtonStyle.outline(),
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Cherry'),
        ),
        VNLChip(
          // Ghost chip (very subtle background).
          style: const VNLButtonStyle.ghost(),
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Durian'),
        ),
        VNLChip(
          // Destructive-styled chip for warning/critical labels.
          style: const VNLButtonStyle.destructive(),
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Elderberry'),
        ),
      ],
    );
  }
}
