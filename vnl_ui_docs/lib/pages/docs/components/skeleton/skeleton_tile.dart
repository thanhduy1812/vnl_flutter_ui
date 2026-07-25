import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class SkeletonTile extends StatelessWidget implements IComponentPage {
  const SkeletonTile({super.key});

  @override
  String get title => 'Skeleton';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Skeleton',
      name: 'skeleton',
      scale: 1,
      example: VNLCard(
        child: Column(
          children: [
            VNLBasic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const VNLAvatar(
                initials: '',
              ).asSkeleton(),
              // Note: VNLAvatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
            const Gap(16),
            VNLBasic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const VNLAvatar(
                initials: '',
              ).asSkeleton(),
              // Note: VNLAvatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
            const Gap(16),
            VNLBasic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const VNLAvatar(
                initials: '',
              ).asSkeleton(),
              // Note: VNLAvatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
          ],
        ),
      ).sized(height: 300),
    );
  }
}
