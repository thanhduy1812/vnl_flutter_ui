import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material;
import 'package:vnl_common_ui/vnl_ui.dart';

class AvatarGroupTile extends StatelessWidget implements IComponentPage {
  const AvatarGroupTile({super.key});

  @override
  String get title => 'VNLAvatar Group';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'avatar_group',
      title: 'VNLAvatar Group',
      scale: 1.5,
      center: true,
      example: VNLAvatarGroup.toLeft(children: [
        VNLAvatar(
          initials: VNLAvatar.getInitials('thanhduy1812'),
          backgroundColor: material.Colors.red,
        ),
        VNLAvatar(
          initials: VNLAvatar.getInitials('thanhduy1812'),
          backgroundColor: material.Colors.green,
        ),
        VNLAvatar(
          initials: VNLAvatar.getInitials('thanhduy1812'),
          backgroundColor: material.Colors.blue,
        ),
        VNLAvatar(
          initials: VNLAvatar.getInitials('thanhduy1812'),
          backgroundColor: material.Colors.yellow,
        ),
      ]),
    );
  }
}
