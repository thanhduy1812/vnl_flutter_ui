import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class SwiperTile extends StatelessWidget implements IComponentPage {
  const SwiperTile({super.key});

  @override
  String get title => 'VNLSwiper';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'swiper',
      title: 'VNLSwiper',
      scale: 1.2,
      example: VNLCard(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // VNLSwiper content
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Slide 1',
                    style: TextStyle(
                      color: theme.colorScheme.primaryForeground,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Navigation arrows
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          theme.colorScheme.background.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_left, size: 20),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          theme.colorScheme.background.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_right, size: 20),
                  ),
                ),
              ),
              // Dots indicator
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryForeground,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryForeground
                            .withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryForeground
                            .withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
