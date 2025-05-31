import 'package:vnl_common_ui/vnl_ui.dart';

class SkeletonExample1 extends StatelessWidget {
  const SkeletonExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Basic(
          title: Text('Skeleton Example 1'),
          content: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          leading: VNLAvatar(
            initials: '',
          ),
          trailing: Icon(Icons.arrow_forward),
        ),
        const Gap(24),
        Basic(
          title: const Text('Skeleton Example 1'),
          content: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          leading: const VNLAvatar(
            initials: '',
          ).asSkeleton(),
          // Note: VNLAvatar and other Image related widget needs its own skeleton
          trailing: const Icon(Icons.arrow_forward),
        ).asSkeleton(),
      ],
    );
  }
}
