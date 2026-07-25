import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class ResizableExample4 extends StatefulWidget {
  const ResizableExample4({super.key});

  @override
  State<ResizableExample4> createState() => _ResizableExample4State();
}

class _ResizableExample4State extends State<ResizableExample4> {
  // Controlled panes: each pane has its own controller so we can read/write size
  // and call helper methods (tryExpandSize, tryCollapse, etc.).
  final VNLAbsoluteResizablePaneController controller1 =
      VNLAbsoluteResizablePaneController(80);
  final VNLAbsoluteResizablePaneController controller2 =
      VNLAbsoluteResizablePaneController(80);
  final VNLAbsoluteResizablePaneController controller3 =
      VNLAbsoluteResizablePaneController(120);
  final VNLAbsoluteResizablePaneController controller4 =
      VNLAbsoluteResizablePaneController(80);
  final VNLAbsoluteResizablePaneController controller5 =
      VNLAbsoluteResizablePaneController(80);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VNLOutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: VNLResizablePanel.horizontal(
            children: [
              VNLResizablePane.controlled(
                // Bind pane size to controller1 (initial 80px).
                controller: controller1,
                child: const NumberedContainer(
                  index: 0,
                  height: 200,
                  fill: false,
                ),
              ),
              VNLResizablePane.controlled(
                controller: controller2,
                child: const NumberedContainer(
                  index: 1,
                  height: 200,
                  fill: false,
                ),
              ),
              VNLResizablePane.controlled(
                controller: controller3,
                // Optional constraint: this pane cannot grow beyond 200px.
                maxSize: 200,
                child: const NumberedContainer(
                  index: 2,
                  height: 200,
                  fill: false,
                ),
              ),
              VNLResizablePane.controlled(
                controller: controller4,
                child: const NumberedContainer(
                  index: 3,
                  height: 200,
                  fill: false,
                ),
              ),
              VNLResizablePane.controlled(
                controller: controller5,
                // Min size prevents the pane from being dragged smaller than 80px.
                minSize: 80,
                // When collapsed, this pane will reduce to 20px instead of disappearing.
                collapsedSize: 20,
                child: const NumberedContainer(
                  index: 4,
                  height: 200,
                  fill: false,
                ),
              ),
            ],
          ),
        ),
        const Gap(48),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            VNLPrimaryButton(
              onPressed: () {
                // Restore all panes to their initial sizes.
                controller1.size = 80;
                controller2.size = 80;
                controller3.size = 120;
                controller4.size = 80;
                controller5.size = 80;
              },
              child: const Text('Reset'),
            ),
            VNLPrimaryButton(
              onPressed: () {
                // Attempt to grow pane 2 (controller3) by +20px.
                controller3.tryExpandSize(20);
              },
              child: const Text('Expand Panel 2'),
            ),
            VNLPrimaryButton(
              onPressed: () {
                // Attempt to shrink pane 2 (controller3) by -20px.
                controller3.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 2'),
            ),
            VNLPrimaryButton(
              onPressed: () {
                // Modify another pane's size incrementally.
                controller2.tryExpandSize(20);
              },
              child: const Text('Expand Panel 1'),
            ),
            VNLPrimaryButton(
              onPressed: () {
                controller2.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 1'),
            ),
            VNLPrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(20);
              },
              child: const Text('Expand Panel 4'),
            ),
            VNLPrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 4'),
            ),
            VNLPrimaryButton(
              onPressed: () {
                // Collapse reduces the pane to its 'collapsedSize'.
                controller5.tryCollapse();
              },
              child: const Text('Collapse Panel 4'),
            ),
            VNLPrimaryButton(
              onPressed: () {
                // Expand restores from the collapsed state.
                controller5.tryExpand();
              },
              child: const Text('Expand Panel 4'),
            ),
          ],
        )
      ],
    );
  }
}
