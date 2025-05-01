import 'package:vnl_common_ui/vnl_ui.dart';

class AvatarExample3 extends StatelessWidget {
  const AvatarExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      initials: Avatar.getInitials('sunarya-thito'),
      size: 64,
      badge: const AvatarBadge(
        size: 20,
        color: VNLColors.green,
      ),
    );
  }
}
