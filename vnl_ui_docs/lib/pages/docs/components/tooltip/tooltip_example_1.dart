import 'package:vnl_common_ui/vnl_ui.dart';

class TooltipExample1 extends StatelessWidget {
  const TooltipExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLTooltip(
      tooltip: const TooltipContainer(
        child: Text('This is a tooltip.'),
      ),
      child: VNLPrimaryButton(
        onPressed: () {},
        child: const Text('Hover over me'),
      ),
    );
  }
}
