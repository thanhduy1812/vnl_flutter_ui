import 'package:vnl_common_ui/vnl_ui.dart';

/// Simple VNLAvatar with initials only.
///
/// Demonstrates customizing the avatar [size] while displaying
/// just the text initials (no image provider).
class AvatarExample2 extends StatelessWidget {
  const AvatarExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLAvatar(
      // Use initials when you don't have an image.
      initials: VNLAvatar.getInitials('thanhduy1812'),
      size: 64,
    );
  }
}
