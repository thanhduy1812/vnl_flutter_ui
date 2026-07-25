import 'package:docs/pages/docs/components_page.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

class CardImageTile extends StatelessWidget implements IComponentPage {
  const CardImageTile({super.key});

  @override
  String get title => 'VNLCard Image';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'card_image',
      title: 'VNLCard Image',
      scale: 1.2,
      example: VNLCard(
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.colorScheme.border),
          ),
          child: Column(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 48,
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('VNLCard Title').bold().large(),
                    const Gap(8),
                    const Text(
                            'This is a description of the card content. It provides additional information about the image above.')
                        .muted(),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(
                          child: VNLOutlineButton(
                            onPressed: () {},
                            child: const Text('Cancel'),
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: VNLPrimaryButton(
                            onPressed: () {},
                            child: const Text('Action'),
                          ),
                        ),
                      ],
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
