import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class PinnedSheetTile extends StatefulWidget implements IComponentPage {
  const PinnedSheetTile({super.key});

  @override
  String get title => 'Pinned Sheet';

  @override
  State<PinnedSheetTile> createState() => _PinnedSheetTileState();
}

class _PinnedSheetTileState extends State<PinnedSheetTile> {
  final VNLSheetController controller = VNLSheetController();

  static const List<VNLSheetStage> stages = [
    VNLSheetStage.peekDragHandle(),
    VNLSheetStage.expanded(),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      title: 'Pinned Sheet',
      name: 'pinned_sheet',
      fit: true,
      example: SizedBox(
        width: 300,
        height: 300,
        child: VNLOutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: VNLPinnedSheet(
            controller: controller,
            position: VNLOverlayPosition.bottom,
            stages: stages,
            initialStage: const VNLSheetStage.peekDragHandle(),
            backdrop: VNLCard(
              fillColor: theme.colorScheme.muted,
              filled: true,
              child: Center(child: const Text('Backdrop content').muted()),
            ),
            child: VNLDrawerContainer(
              child: SizedBox(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pinned Sheet').large().medium(),
                      const Gap(4),
                      const Text('Drag the handle to expand').muted(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
