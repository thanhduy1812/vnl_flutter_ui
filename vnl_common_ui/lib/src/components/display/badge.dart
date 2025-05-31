import 'package:vnl_common_ui/vnl_ui.dart';

class VNLPrimaryBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const VNLPrimaryBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: VNLButton(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style:
            style ??
            const ButtonStyle.primary(
              size: ButtonSize.small,
              density: ButtonDensity.dense,
              shape: ButtonShape.rectangle,
            ).copyWith(
              textStyle: (context, states, value) {
                return value.copyWith(fontWeight: FontWeight.w500);
              },
            ),
        child: child,
      ),
    );
  }
}

class VNLSecondaryBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const VNLSecondaryBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: VNLButton(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style:
            style ??
            const ButtonStyle.secondary(
              size: ButtonSize.small,
              density: ButtonDensity.dense,
              shape: ButtonShape.rectangle,
            ).copyWith(
              textStyle: (context, states, value) {
                return value.copyWith(fontWeight: FontWeight.w500);
              },
            ),
        child: child,
      ),
    );
  }
}

class VNLOutlineBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const VNLOutlineBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: VNLButton(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style:
            style ??
            const ButtonStyle.outline(
              size: ButtonSize.small,
              density: ButtonDensity.dense,
              shape: ButtonShape.rectangle,
            ).copyWith(
              textStyle: (context, states, value) {
                return value.copyWith(fontWeight: FontWeight.w500);
              },
            ),
        child: child,
      ),
    );
  }
}

class DestructiveBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const DestructiveBadge({super.key, required this.child, this.onPressed, this.leading, this.trailing, this.style});

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: VNLButton(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style:
            style ??
            const ButtonStyle.destructive(
              size: ButtonSize.small,
              density: ButtonDensity.dense,
              shape: ButtonShape.rectangle,
            ).copyWith(
              textStyle: (context, states, value) {
                return value.copyWith(fontWeight: FontWeight.w500);
              },
            ),
        child: child,
      ),
    );
  }
}
