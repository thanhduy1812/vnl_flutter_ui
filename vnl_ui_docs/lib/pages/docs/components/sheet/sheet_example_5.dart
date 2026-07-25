import 'package:vnl_common_ui/vnl_ui.dart';

/// Demonstrates `VNLDrawerContainer(expands: true)`: the sheet content is sized to
/// the visible extent (0 when closed → the backdrop size when fully open)
/// instead of sliding. With `intrinsic: true` (the default) the content stops
/// shrinking at its intrinsic size, so it never overflows. The "90%" stage
/// (`VNLSheetStage.expanded() * 0.9`) stops 10% short of fully covering.
class PinnedSheetExample5 extends StatefulWidget {
  const PinnedSheetExample5({super.key});

  @override
  State<PinnedSheetExample5> createState() => _PinnedSheetExample5State();
}

class _PinnedSheetExample5State extends State<PinnedSheetExample5> {
  final VNLSheetController controller = VNLSheetController();

  static final VNLSheetStage sixty = const VNLSheetStage.expanded() * 0.6;

  late final List<VNLSheetStage> stages = [
    const VNLSheetStage.closed(),
    sixty,
    const VNLSheetStage.expanded(),
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
      height: 460,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Full-height sheet').large().medium(),
                const Gap(16),
                VNLPrimaryButton(
                  onPressed: () =>
                      controller.stage = const VNLSheetStage.expanded(),
                  child: const Text('Cover backdrop'),
                ),
                const Gap(8),
                VNLPrimaryButton(
                  onPressed: () => controller.stage = sixty,
                  child: const Text('60% (stops short)'),
                ),
              ],
            ),
          ),
          // expands: true sizes the content to the visible extent; intrinsic
          // (default true) floors it at the content's natural size.
          child: VNLDrawerContainer(
            expands: true,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sized to the visible extent').large().medium(),
                  const Gap(8),
                  const Text(
                    'With expands:true the sheet grows and shrinks with its '
                    'value instead of sliding. Drag it down to close.',
                  ).muted(),
                  // const Gap(16),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: VNLOutlineButton(
                      onPressed: () =>
                          controller.stage = const VNLSheetStage.closed(),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
