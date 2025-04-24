import 'package:vnl_common_ui/vnl_ui.dart';

class MoreDots extends StatelessWidget {
  final Axis direction;
  final int count;
  final double? size;
  final Color? color;
  final double spacing;
  final EdgeInsetsGeometry? padding;

  const MoreDots({
    super.key,
    this.direction = Axis.horizontal,
    this.count = 3,
    this.size,
    this.color,
    this.spacing = 2,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = DefaultTextStyle.of(context).style;
    Color color = this.color ?? style.color!;
    double size = this.size ?? (style.fontSize ?? 12) * 0.2;
    List<Widget> children = [];
    for (int i = 0; i < count; i++) {
      children.add(Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 2),
        ),
      ));
      if (i < count - 1) {
        children.add(SizedBox(
          width: direction == Axis.horizontal ? spacing : null,
          height: direction == Axis.vertical ? spacing : null,
        ));
      }
    }
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: children,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
    );
  }
}
