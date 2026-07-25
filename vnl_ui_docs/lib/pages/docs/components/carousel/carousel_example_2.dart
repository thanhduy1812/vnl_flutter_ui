import 'package:vnl_common_ui/vnl_ui.dart';

import '../carousel_example.dart';

/// Vertical carousel centered in a column with manual controls.
///
/// Demonstrates changing [direction] to [Axis.vertical] and centering items
/// using [VNLCarouselAlignment.center].
class CarouselExample2 extends StatefulWidget {
  const CarouselExample2({super.key});

  @override
  State<CarouselExample2> createState() => _CarouselExample2State();
}

class _CarouselExample2State extends State<CarouselExample2> {
  final VNLCarouselController controller = VNLCarouselController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VNLOutlineButton(
              shape: VNLButtonShape.circle,
              onPressed: () {
                // Move to previous item (upwards).
                controller.animatePrevious(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_upward)),
          const Gap(24),
          Expanded(
            child: SizedBox(
              width: 200,
              child: VNLCarousel(
                transition: const VNLCarouselTransition.sliding(gap: 24),
                // Center the visible item.
                alignment: VNLCarouselAlignment.center,
                controller: controller,
                // Rotate layout to vertical flow.
                direction: Axis.vertical,
                // Fix item extent to 200.
                sizeConstraint: const VNLCarouselFixedConstraint(200),
                itemBuilder: (context, index) {
                  return NumberedContainer(index: index);
                },
              ),
            ),
          ),
          const Gap(24),
          VNLOutlineButton(
              shape: VNLButtonShape.circle,
              onPressed: () {
                // Move to next item (downwards).
                controller.animateNext(const Duration(milliseconds: 500));
              },
              child: const Icon(Icons.arrow_downward)),
        ],
      ),
    );
  }
}
