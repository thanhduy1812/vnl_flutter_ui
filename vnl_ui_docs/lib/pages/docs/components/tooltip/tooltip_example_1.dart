import 'package:vnl_common_ui/shadcn_flutter.dart';

// Demonstrates a VNLTooltip wrapping a button; shows tooltip content on
// hover/focus.

class TooltipExample1 extends StatelessWidget {
  const TooltipExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLTooltip(
      // VNLTooltip wraps a target widget and shows VNLTooltipContainer on hover/focus.
      tooltip: const VNLTooltipContainer(
        child: Text('This is a tooltip.'),
      ),
      child: VNLPrimaryButton(
        onPressed: () {},
        child: const Text('VNLHover over me'),
      ),
    );
  }
}
