import 'package:vnl_common_ui/vnl_ui.dart';

/// A controller-driven [PinnedSheet] with three snap stages.
///
/// The sheet is pinned to the bottom of a bounded region. It snaps between a
/// closed state, a half-open "peek" ([VNLSheetStage.fraction]) and a fully
/// expanded state. The backdrop scales down while the sheet opens
/// ([PinnedSheet.backdropTransform]). The buttons drive the [VNLSheetController],
/// and the sheet can also be dragged by its handle.
class PinnedSheetExample1 extends StatefulWidget {
  const PinnedSheetExample1({super.key});

  @override
  State<PinnedSheetExample1> createState() => _PinnedSheetExample1State();
}

class _PinnedSheetExample1State extends State<PinnedSheetExample1> {
  final VNLSheetController controller = VNLSheetController();

  static const List<VNLSheetStage> stages = [
    VNLSheetStage.closed(),
    VNLSheetStage.fraction(0.4),
    VNLSheetStage.expanded(),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: VNLOutlinedContainer(
        clipBehavior: Clip.antiAlias,
        child: VNLPinnedSheet(
          controller: controller,
          position: VNLOverlayPosition.bottom,
          stages: stages,
          initialStage: const VNLSheetStage.fraction(0.4),
          backdropTransform: const VNLScaleBackdropTransform(),
          // The backdrop is scaled down as the sheet opens.
          backdrop: ListenableBuilder(
            listenable: controller,
            builder: (context, child) {
              return Opacity(
                opacity: 1.0 - controller.fraction,
                child: child,
              );
            },
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (controller.stage == const VNLSheetStage.expanded()) {
                  controller.stage = const VNLSheetStage.fraction(0.4);
                }
              },
              child: VNLCard(
                filled: true,
                fillColor: Theme.of(context).colorScheme.muted,
                child: Center(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Backdrop content')
                            .large()
                            .medium()
                            .center(),
                        const Gap(8),
                        ListenableBuilder(
                          listenable: controller,
                          builder: (context, child) {
                            final percent = (controller.fraction * 100).round();
                            return Text('Sheet is $percent% open')
                                .muted()
                                .center();
                          },
                        ),
                        const Gap(24),
                        VNLPrimaryButton(
                          onPressed: () =>
                              controller.stage = const VNLSheetStage.expanded(),
                          alignment: Alignment.center,
                          child: const Text('Expand'),
                        ),
                        const Gap(8),
                        VNLPrimaryButton(
                          onPressed: () =>
                              controller.stage = const VNLSheetStage.fraction(0.4),
                          alignment: Alignment.center,
                          child: const Text('Peek'),
                        ),
                        const Gap(8),
                        VNLPrimaryButton(
                          onPressed: () => controller.animateTo(
                            const VNLSheetStage.closed(),
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          ),
                          alignment: Alignment.center,
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // The caller decides the chrome by wrapping their content in a
          // VNLDrawerContainer (rounded, bordered) or a VNLSheetContainer (edge-to-edge).
          child: VNLDrawerContainer(
            child: Container(
              height: 320,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pinned sheet').large().medium(),
                  const Gap(8),
                  const Text(
                    'Drag the handle to snap between closed, peek and '
                    'expanded, or use the buttons on the backdrop.',
                  ).muted(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
