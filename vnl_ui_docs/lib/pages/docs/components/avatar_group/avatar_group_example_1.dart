import 'package:vnl_common_ui/vnl_ui.dart';

class AvatarGroupExample1 extends StatefulWidget {
  const AvatarGroupExample1({super.key});

  @override
  State<AvatarGroupExample1> createState() => _AvatarGroupExample1State();
}

class _AvatarGroupExample1State extends State<AvatarGroupExample1> {
  List<AvatarWidget> getAvatars() {
    return [
      VNLAvatar(
        initials: VNLAvatar.getInitials('sunarya-thito'),
        backgroundColor: VNLColors.red,
      ),
      VNLAvatar(
        initials: VNLAvatar.getInitials('sunarya-thito'),
        backgroundColor: VNLColors.green,
      ),
      VNLAvatar(
        initials: VNLAvatar.getInitials('sunarya-thito'),
        backgroundColor: VNLColors.blue,
      ),
      VNLAvatar(
        initials: VNLAvatar.getInitials('sunarya-thito'),
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
        VNLAvatarGroup.toLeft(children: getAvatars()),
        VNLAvatarGroup.toRight(children: getAvatars()),
        VNLAvatarGroup.toTop(children: getAvatars()),
        VNLAvatarGroup.toBottom(children: getAvatars()),
      ],
    );
  }
}
