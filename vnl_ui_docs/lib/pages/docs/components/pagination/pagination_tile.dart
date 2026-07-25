import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class PaginationTile extends StatelessWidget implements IComponentPage {
  const PaginationTile({super.key});

  @override
  String get title => 'VNLPagination';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'VNLPagination',
      name: 'pagination',
      reverse: true,
      example: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VNLCard(child: PaginationExample1()),
          Transform.translate(
              offset: const Offset(250, 0),
              child: const VNLCard(child: PaginationExample1())),
        ],
      ).gap(16),
    );
  }
}
