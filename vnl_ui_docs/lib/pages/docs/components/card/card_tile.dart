import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../card/card_example_1.dart';

class CardTile extends StatelessWidget implements IComponentPage {
  const CardTile({super.key});

  @override
  String get title => 'VNLCard';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'card',
      title: 'VNLCard',
      example: CardExample1(),
    );
  }
}
