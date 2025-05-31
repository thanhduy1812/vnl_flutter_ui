import 'package:vnl_common_ui/vnl_ui.dart';

class ToastExample1 extends StatefulWidget {
  const ToastExample1({super.key});

  @override
  State<ToastExample1> createState() => _ToastExample1State();
}

class _ToastExample1State extends State<ToastExample1> {
  Widget buildToast(BuildContext context, ToastOverlay overlay) {
    return SurfaceCard(
      child: Basic(
        title: const Text('Event has been created'),
        subtitle: const Text('Sunday, July 07, 2024 at 12:00 PM'),
        trailing: VNLPrimaryButton(
            size: ButtonSize.small,
            onPressed: () {
              overlay.close();
            },
            child: const Text('Undo')),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.bottomLeft,
            );
          },
          child: const Text('Show Bottom Left Toast'),
        ),
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.bottomRight,
            );
          },
          child: const Text('Show Bottom Right Toast'),
        ),
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.topLeft,
            );
          },
          child: const Text('Show Top Left Toast'),
        ),
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.topRight,
            );
          },
          child: const Text('Show Top Right Toast'),
        ),
        // bottom center
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.bottomCenter,
            );
          },
          child: const Text('Show Bottom Center Toast'),
        ),
        // top center
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.topCenter,
            );
          },
          child: const Text('Show Top Center Toast'),
        ),
      ],
    );
  }
}
