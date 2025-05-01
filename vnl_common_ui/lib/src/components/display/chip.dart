import 'package:vnl_common_ui/vnl_ui.dart';

class ChipButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const ChipButton({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = VNLTheme.of(context);
    return VNLButton(
      style: ButtonVariance(
        decoration: (context, states) {
          return const BoxDecoration();
        },
        mouseCursor: (context, states) {
          if (states.contains(WidgetState.disabled)) {
            return SystemMouseCursors.basic;
          }
          return SystemMouseCursors.click;
        },
        padding: (context, states) {
          return EdgeInsets.zero;
        },
        textStyle: (context, states) {
          return const TextStyle();
        },
        iconTheme: (context, states) {
          return theme.iconTheme.xSmall;
        },
        margin: (context, states) {
          return EdgeInsets.zero;
        },
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class VNLChip extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final AbstractButtonStyle? style;

  const VNLChip({super.key, required this.child, this.leading, this.trailing, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    final theme = VNLTheme.of(context);
    return VNLButton(
      style: (style ?? ButtonVariance.secondary).copyWith(
        mouseCursor: (context, states, value) {
          return onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.basic;
        },
        padding: (context, states, value) {
          return EdgeInsets.symmetric(horizontal: theme.scaling * 8, vertical: theme.scaling * 4);
        },
      ),
      onPressed: onPressed ?? () {},
      leading: leading,
      trailing: trailing,
      child: child,
    );
  }
}
