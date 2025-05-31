import 'package:vnl_common_ui/vnl_ui.dart';

class AvatarExample2 extends StatelessWidget {
  const AvatarExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLAvatar(
      initials: VNLAvatar.getInitials('sunarya-thito'),
      size: 64,
    );
  }
}
