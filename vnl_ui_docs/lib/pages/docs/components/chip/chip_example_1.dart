import 'package:vnl_common_ui/vnl_ui.dart';

class ChipExample1 extends StatelessWidget {
  const ChipExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VNLChip(
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Apple'),
        ),
        VNLChip(
          style: const ButtonStyle.primary(),
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Banana'),
        ),
        VNLChip(
          style: const ButtonStyle.outline(),
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Cherry'),
        ),
        VNLChip(
          style: const ButtonStyle.ghost(),
          trailing: VNLChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Durian'),
        ),
        VNLChip(
          style: const ButtonStyle.destructive(),
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
