import 'package:vnl_common_ui/vnl_ui.dart';

// Demonstrates toast overlays in different screen locations with a custom
// content builder and programmatic close via the overlay handle.

class ToastExample1 extends StatefulWidget {
  const ToastExample1({super.key});

  @override
  State<ToastExample1> createState() => _ToastExample1State();
}

class _ToastExample1State extends State<ToastExample1> {
  // Builder for the toast content; receives an overlay handle so we can close it.
  Widget buildToast(BuildContext context, VNLToastOverlay overlay) {
    return VNLSurfaceCard(
      child: VNLBasic(
        title: const Text('Event has been created'),
        subtitle: const Text('Sunday, July 07, 2024 at 12:00 PM'),
        trailing: VNLPrimaryButton(
            size: VNLButtonSize.small,
            onPressed: () {
              // Close the toast programmatically when clicking Undo.
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
              // Position bottom-left.
              location: VNLToastLocation.bottomLeft,
            );
          },
          child: const Text('Show Bottom Left Toast'),
        ),
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position bottom-right.
              location: VNLToastLocation.bottomRight,
            );
          },
          child: const Text('Show Bottom Right Toast'),
        ),
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position top-left.
              location: VNLToastLocation.topLeft,
            );
          },
          child: const Text('Show Top Left Toast'),
        ),
        VNLPrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position top-right.
              location: VNLToastLocation.topRight,
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
              location: VNLToastLocation.bottomCenter,
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
              location: VNLToastLocation.topCenter,
            );
          },
          child: const Text('Show Top Center Toast'),
        ),
      ],
    );
  }
}
