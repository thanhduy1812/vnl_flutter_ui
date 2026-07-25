import 'package:vnl_common_ui/vnl_ui.dart';

/// Nested [PinnedSheet]s. The outer sheet's [PinnedSheet.backdrop] contains a
/// second [PinnedSheet]; when the outer sheet scales its backdrop, the inner
/// sheet adjusts its layout to hug the transformed region.
class PinnedSheetExample4 extends StatefulWidget {
  const PinnedSheetExample4({super.key});

  @override
  State<PinnedSheetExample4> createState() => _PinnedSheetExample4State();
}

class _PinnedSheetExample4State extends State<PinnedSheetExample4> {
  final VNLSheetController outer = VNLSheetController();
  final VNLSheetController inner = VNLSheetController();

  @override
  void dispose() {
    outer.dispose();
    inner.dispose();
    super.dispose();
  }

  Widget _content(String title, VoidCallback onClose) {
    return VNLDrawerContainer(
      child: SizedBox(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title).large().medium(),
              const Gap(8),
              const Text('Drag me, or use the buttons.').muted(),
              const Gap(16),
              VNLSecondaryButton(onPressed: onClose, child: const Text('Close')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 460,
      child: VNLOutlinedContainer(
        clipBehavior: Clip.antiAlias,
        child: VNLPinnedSheet(
          controller: outer,
          position: VNLOverlayPosition.bottom,
          draggableBackdrop: true,
          backdropTransform: const VNLScaleBackdropTransform(),
          backdrop: VNLPinnedSheet(
            controller: inner,
            position: VNLOverlayPosition.bottom,
            draggableBackdrop: true,
            // Multiple stages: drag snaps within the inner sheet, and once the
            // drag runs past the inner sheet's range it hands off to the outer.
            stages: const [
              VNLSheetStage.closed(),
              VNLSheetStage.fraction(0.5),
              VNLSheetStage.expanded(),
            ],
            backdropTransform: const VNLScaleBackdropTransform(),
            backdrop: Container(
              color: theme.colorScheme.muted,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nested pinned sheets. ').large().medium(),
                  const Gap(8),
                  const Text(
                          'You can press the button or drag this container to open it.')
                      .muted(),
                  const Gap(16),
                  VNLPrimaryButton(
                    onPressed: () => inner.stage = const VNLSheetStage.expanded(),
                    child: const Text('Open inner'),
                  ),
                  const Gap(8),
                  VNLPrimaryButton(
                    onPressed: () => outer.stage = const VNLSheetStage.expanded(),
                    child: const Text('Open outer'),
                  ),
                ],
              ),
            ),
            child: _content(
              'Inner sheet',
              () => inner.stage = const VNLSheetStage.closed(),
            ),
          ),
          child: _content(
            'Outer sheet',
            () => outer.stage = const VNLSheetStage.closed(),
          ),
        ),
      ),
    );
  }
}
