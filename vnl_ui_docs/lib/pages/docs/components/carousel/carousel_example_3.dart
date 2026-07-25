import 'package:vnl_common_ui/vnl_ui.dart';

import '../carousel_example.dart';

/// VNLCarousel with fading transition and dot indicators.
///
/// Items fade in/out instead of sliding. Draggable is disabled and the
/// [VNLCarouselDotIndicator] syncs with the same [VNLCarouselController].
class CarouselExample3 extends StatefulWidget {
  const CarouselExample3({super.key});

  @override
  State<CarouselExample3> createState() => _CarouselExample3State();
}

class _CarouselExample3State extends State<CarouselExample3> {
  final VNLCarouselController controller = VNLCarouselController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 800,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: VNLCarousel(
              // Use a fading transition instead of sliding.
              transition: const VNLCarouselTransition.fading(),
              controller: controller,
              // Disable gesture dragging; navigation is via controls below.
              draggable: false,
              // Automatically switch items.
              autoplaySpeed: const Duration(seconds: 1),
              itemCount: 5,
              itemBuilder: (context, index) {
                return NumberedContainer(index: index);
              },
              // Fade duration.
              duration: const Duration(seconds: 1),
            ),
          ),
          const Gap(8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dots reflect and control the current index via controller.
              VNLCarouselDotIndicator(itemCount: 5, controller: controller),
              const Spacer(),
              VNLOutlineButton(
                  shape: VNLButtonShape.circle,
                  onPressed: () {
                    controller
                        .animatePrevious(const Duration(milliseconds: 500));
                  },
                  child: const Icon(Icons.arrow_back)),
              const Gap(8),
              VNLOutlineButton(
                  shape: VNLButtonShape.circle,
                  onPressed: () {
                    controller.animateNext(const Duration(milliseconds: 500));
                  },
                  child: const Icon(Icons.arrow_forward)),
            ],
          ),
        ],
      ),
    );
  }
}
