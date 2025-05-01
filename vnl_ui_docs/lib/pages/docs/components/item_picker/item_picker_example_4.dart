import 'package:vnl_common_ui/vnl_ui.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class ItemPickerExample4 extends StatefulWidget {
  const ItemPickerExample4({super.key});

  @override
  State<ItemPickerExample4> createState() => _ItemPickerExample4State();
}

class _ItemPickerExample4State extends State<ItemPickerExample4> {
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
          layout: ItemPickerLayout.list,
          title: const Text('Pick a color'),
          builder: (context, item) {
            return ItemPickerOption(
                value: item,
                label: Text(item.name),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                  ),
                ));
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
