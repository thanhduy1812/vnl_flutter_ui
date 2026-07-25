import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLAvatar with a status badge.
///
/// Shows how to attach an [VNLAvatarBadge] to indicate presence/status
/// (e.g., online/offline) or any small highlight.
class AvatarExample3 extends StatelessWidget {
  const AvatarExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLAvatar(
      initials: VNLAvatar.getInitials('thanhduy1812'),
      size: 64,
      badge: const VNLAvatarBadge(
        size: 20,
        color: VNLColors.green,
      ),
    );
  }
}
