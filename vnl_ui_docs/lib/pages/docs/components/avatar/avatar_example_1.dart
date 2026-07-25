import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLAvatar with image and initials fallback.
///
/// If the image fails to load, the [initials] will be shown over the
/// [backgroundColor]. This example uses a remote GitHub avatar URL.
class AvatarExample1 extends StatelessWidget {
  const AvatarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLAvatar(
      backgroundColor: VNLColors.red,
      // Helper to derive initials from a username or full name.
      initials: VNLAvatar.getInitials('thanhduy1812'),
      provider: const NetworkImage(
          'https://avatars.githubusercontent.com/u/64018564?v=4'),
    );
  }
}
