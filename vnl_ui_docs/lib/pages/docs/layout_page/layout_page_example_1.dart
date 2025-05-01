import 'package:vnl_common_ui/vnl_ui.dart';

class LayoutPageExample1 extends StatelessWidget {
  const LayoutPageExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VNLColors.red,
      child: Container(
        color: VNLColors.green,
        child: Container(
          color: VNLColors.blue,
          height: 20,
        ).withPadding(all: 16),
      ).withPadding(top: 24, bottom: 12, horizontal: 16),
    );
  }
}
