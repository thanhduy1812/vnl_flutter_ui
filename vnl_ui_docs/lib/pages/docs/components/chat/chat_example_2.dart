import 'package:vnl_common_ui/shadcn_flutter.dart';

class ChatExample2 extends StatefulWidget {
  const ChatExample2({super.key});

  @override
  State<ChatExample2> createState() => _ChatExample2State();
}

class _ChatExample2State extends State<ChatExample2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        // VNLChatGroup example
        VNLChatGroup(
          color: VNLColors.blue,
          type:
              VNLChatBubbleType.tail.copyWith(position: () => AxisDirectional.end),
          alignment: AxisAlignmentDirectional.end,
          children: const [
            VNLChatBubble(
                child: Text(
                    'John, did you remember what time you took the call with Mrs. Smith?')),
            VNLChatBubble(child: Text('Reply ASAP')),
          ],
        ),
        VNLChatGroup(
          color: VNLColors.gray,
          avatarPrefix: const VNLAvatar(initials: 'JO'),
          alignment: AxisAlignmentDirectional.start,
          type: VNLChatBubbleType.tail.copyWith(
              position: () => AxisDirectional.start,
              tailAlignment: () => AxisAlignmentDirectional.end),
          children: const [
            VNLChatBubble(child: Text('Around 6 or 7?')),
            VNLChatBubble(child: Text('New phone who dis?')),
          ],
        ),
        VNLChatBubble(
          color: VNLColors.blue,
          alignment: AxisAlignmentDirectional.end,
          type:
              VNLChatBubbleType.tail.copyWith(position: () => AxisDirectional.end),
          child: const Text('SIX SEVENNN 🤤🤪'),
        ),
        VNLChatGroup(
          color: VNLColors.gray,
          avatarPrefix: const VNLAvatar(initials: 'JO'),
          alignment: AxisAlignmentDirectional.start,
          type: VNLChatBubbleType.tail.copyWith(
              position: () => AxisDirectional.start,
              tailAlignment: () => AxisAlignmentDirectional.end),
          children: const [
            VNLChatBubble(child: Text('?')),
            VNLChatBubble(child: Text('Seriously who is this')),
            VNLChatBubble(child: Text('gonna have to block you')),
          ],
        ),
      ],
    );
  }
}

enum ChatType {
  plain,
  tail,
  sharpCorner,
}
