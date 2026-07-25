import 'package:vnl_common_ui/vnl_ui.dart';

/// A [PinnedSheet] using a [VNLSheetContainer] that does not stretch edge-to-edge:
/// it is sized to 70% of the width and centered ([VNLSheetContainer.alignCenter]
/// with an [AxisSize]). It also shows stage arithmetic — the expanded stage
/// stops 40px short of fully covering, and a per-stage backdrop transform.
class PinnedSheetExample3 extends StatefulWidget {
  const PinnedSheetExample3({super.key});

  @override
  State<PinnedSheetExample3> createState() => _PinnedSheetExample3State();
}

class _PinnedSheetExample3State extends State<PinnedSheetExample3> {
  final VNLSheetController controller = VNLSheetController();

  // Expanded, but 40px short of fully covering, with a gentler backdrop scale.
  static final VNLSheetStage expanded =
      const VNLSheetStage.expanded(backdropTransform: 0.4) -
          const VNLSheetStage.fixed(40);

  late final List<VNLSheetStage> stages = [
    const VNLSheetStage.closed(),
    expanded,
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 420,
      child: VNLOutlinedContainer(
        clipBehavior: Clip.antiAlias,
        child: VNLPinnedSheet(
          controller: controller,
          position: VNLOverlayPosition.bottom,
          stages: stages,
          initialStage: const VNLSheetStage.closed(),
          backdropTransform: const VNLScaleBackdropTransform(),
          backdrop: Container(
            color: theme.colorScheme.muted,
            alignment: Alignment.center,
            child: VNLPrimaryButton(
              onPressed: () => controller.stage = expanded,
              child: const Text('Open sheet'),
            ),
          ),
          // Sized to 70% width, centered, with a bit of horizontal padding.
          child: VNLSheetContainer(
            child: SizedBox(
              height: 280,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Centered sheet').large().medium(),
                    const Gap(8),
                    const Text(
                      'This sheet is 70% of the width and centered, and its '
                      'expanded stage stops 40px short of full.',
                    ).muted(),
                    const Gap(16),
                    VNLSecondaryButton(
                      onPressed: () =>
                          controller.stage = const VNLSheetStage.closed(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
