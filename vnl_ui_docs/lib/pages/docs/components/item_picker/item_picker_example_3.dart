import 'package:vnl_common_ui/vnl_ui.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class ItemPickerExample3 extends StatefulWidget {
  const ItemPickerExample3({super.key});

  @override
  State<ItemPickerExample3> createState() => _ItemPickerExample3State();
}

class _ItemPickerExample3State extends State<ItemPickerExample3> {
  final List<NamedColor> colors = const [
    NamedColor('Red', VNLColors.red),
    NamedColor('Green', VNLColors.green),
    NamedColor('Blue', VNLColors.blue),
    NamedColor('Yellow', VNLColors.yellow),
    NamedColor('Purple', VNLColors.purple),
    NamedColor('Cyan', VNLColors.cyan),
    NamedColor('Orange', VNLColors.orange),
    NamedColor('Pink', VNLColors.pink),
    NamedColor('Teal', VNLColors.teal),
    NamedColor('Amber', VNLColors.amber),
  ];
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        showItemPickerDialog<NamedColor>(
          context,
          items: ItemList(colors),
          initialValue: colors[selectedColor],
          title: const Text('Pick a color'),
          builder: (context, item) {
            return ItemPickerOption(
              value: item,
              selectedStyle: const ButtonStyle.primary(
                shape: ButtonShape.circle,
              ),
              style: const ButtonStyle.ghost(
                shape: ButtonShape.circle,
              ),
              label: Text(item.name),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
              ),
            );
          },
        ).then(
          (value) {
            if (value != null) {
              selectedColor = colors.indexOf(value);
              showToast(
                context: context,
                builder: (context, overlay) {
                  return SurfaceCard(
                    child: Text('You picked ${value.name}!'),
                  );
                },
              );
            } else {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return const SurfaceCard(
                    child: Text('You picked nothing!'),
                  );
                },
              );
            }
          },
        );
      },
      child: const Text('Show Item Picker'),
    );
  }
}
