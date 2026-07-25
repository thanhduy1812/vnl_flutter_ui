import 'package:vnl_common_ui/vnl_ui.dart';

/// VNLAlertDialog demo with a trigger button.
///
/// Tapping the [VNLPrimaryButton] opens a Material [showDialog] that
/// contains an [VNLAlertDialog] with a title, content, and action buttons.
/// The actions simply dismiss the dialog using [Navigator.pop].
class AlertDialogExample1 extends StatelessWidget {
  const AlertDialogExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLPrimaryButton(
      child: const Text('Click Here'),
      onPressed: () {
        // Standard Flutter API to present a dialog above the current route.
        showDialog(
          context: context,
          builder: (context) {
            return VNLAlertDialog(
              title: const Text('VNLAlert title'),
              content: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              actions: [
                // Secondary action to cancel/dismiss.
                VNLOutlineButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    // Close the dialog.
                    Navigator.pop(context);
                  },
                ),
                // Primary action to accept/confirm.
                VNLPrimaryButton(
                  child: const Text('OK'),
                  onPressed: () {
                    // Close the dialog. In real apps, perform work before closing.
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
