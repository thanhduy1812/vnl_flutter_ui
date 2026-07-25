import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLAvatarGroup directions demo.
///
/// Displays the same set of avatars grouped in four different stacking
/// directions: left, right, top, and bottom. Useful for dense displays
/// where overlapping avatars save space.
class AvatarGroupExample1 extends StatefulWidget {
  const AvatarGroupExample1({super.key});

  @override
  State<AvatarGroupExample1> createState() => _AvatarGroupExample1State();
}

class _AvatarGroupExample1State extends State<AvatarGroupExample1> {
  /// Helper that returns a few colored avatars to visualize overlap.
  List<VNLAvatarWidget> getAvatars() {
    return [
      VNLAvatar(
        initials: VNLAvatar.getInitials('thanhduy1812'),
        backgroundColor: VNLColors.red,
      ),
      VNLAvatar(
        initials: VNLAvatar.getInitials('thanhduy1812'),
        backgroundColor: VNLColors.green,
      ),
      VNLAvatar(
        initials: VNLAvatar.getInitials('thanhduy1812'),
        backgroundColor: VNLColors.blue,
      ),
      VNLAvatar(
        initials: VNLAvatar.getInitials('thanhduy1812'),
        backgroundColor: VNLColors.yellow,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Overlap avatars towards the left.
        VNLAvatarGroup.toLeft(children: getAvatars()),
        // Overlap avatars towards the right.
        VNLAvatarGroup.toRight(children: getAvatars()),
        // Stack vertically upwards.
        VNLAvatarGroup.toTop(children: getAvatars()),
        // Stack vertically downwards.
        VNLAvatarGroup.toBottom(children: getAvatars()),
      ],
    );
  }
}
