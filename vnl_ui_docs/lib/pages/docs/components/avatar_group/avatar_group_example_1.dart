import 'package:vnl_common_ui/vnl_ui.dart';

class AvatarGroupExample1 extends StatefulWidget {
  const AvatarGroupExample1({super.key});

  @override
  State<AvatarGroupExample1> createState() => _AvatarGroupExample1State();
}

class _AvatarGroupExample1State extends State<AvatarGroupExample1> {
  List<AvatarWidget> getAvatars() {
    return [
      Avatar(
        initials: Avatar.getInitials('sunarya-thito'),
        backgroundColor: VNLColors.red,
      ),
      Avatar(
        initials: Avatar.getInitials('sunarya-thito'),
        backgroundColor: VNLColors.green,
      ),
      Avatar(
        initials: Avatar.getInitials('sunarya-thito'),
        backgroundColor: VNLColors.blue,
      ),
      Avatar(
        initials: Avatar.getInitials('sunarya-thito'),
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
        AvatarGroup.toLeft(children: getAvatars()),
        AvatarGroup.toRight(children: getAvatars()),
        AvatarGroup.toTop(children: getAvatars()),
        AvatarGroup.toBottom(children: getAvatars()),
      ],
    );
  }
}
