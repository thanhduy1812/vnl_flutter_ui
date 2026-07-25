import 'dart:ui';

import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Horizontally scrollable list of VNLCardImage items.
///
/// Demonstrates enabling both touch and mouse drag for horizontal scroll,
/// and using [VNLCardImage] to show an image with title/subtitle. Tapping a
/// card opens a simple dialog.
class CardImageExample1 extends StatelessWidget {
  const CardImageExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 10; i++)
                VNLCardImage(
                  // Simple interaction: open a dialog on tap.
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return VNLAlertDialog(
                          title: const Text('VNLCard Image'),
                          content: const Text('You clicked on a card image.'),
                          actions: [
                            VNLPrimaryButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  // Network image; replace with your own provider as needed.
                  image: Image.network(
                    'https://picsum.photos/200/300',
                  ),
                  // Title and subtitle appear over the image.
                  title: Text('VNLCard Number ${i + 1}'),
                  subtitle: const Text('Lorem ipsum dolor sit amet'),
                ),
            ],
          ).gap(8),
        ),
      ),
    );
  }
}
