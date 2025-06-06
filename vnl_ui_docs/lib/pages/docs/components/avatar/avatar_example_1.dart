import 'package:vnl_common_ui/vnl_ui.dart';

class AvatarExample1 extends StatelessWidget {
  const AvatarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLAvatar(
      backgroundColor: VNLColors.red,
      initials: VNLAvatar.getInitials('sunarya-thito'),
      provider: const NetworkImage('https://avatars.githubusercontent.com/u/64018564?v=4'),
    );
  }
}
