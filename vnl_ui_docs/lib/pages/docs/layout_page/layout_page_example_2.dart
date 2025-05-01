import 'package:vnl_common_ui/vnl_ui.dart';

class LayoutPageExample2 extends StatelessWidget {
  const LayoutPageExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VNLColors.red,
      child: Container(
        color: VNLColors.green,
        child: Container(
          color: VNLColors.blue,
          height: 20,
        ).withMargin(all: 16),
      ).withMargin(top: 24, bottom: 12, horizontal: 16),
    );
  }
}
