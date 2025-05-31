import 'package:vnl_common_ui/vnl_ui.dart';

class AlertDialogExample1 extends StatelessWidget {
  const AlertDialogExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLPrimaryButton(
      child: const Text('Click Here'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return VNLAlertDialog(
              title: const Text('Alert title'),
              content: const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              actions: [
                VNLOutlineButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                VNLPrimaryButton(
                  child: const Text('OK'),
                  onPressed: () {
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
