import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:docs/pages/docs/components_page.dart';

class AccordionTile extends StatelessWidget implements IComponentPage {
  const AccordionTile({super.key});

  @override
  String get title => 'VNLAccordion';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'accordion',
      title: 'VNLAccordion',
      example: SizedBox(
        width: 280,
        child: VNLCard(
          child: VNLAccordion(
            items: [
              VNLAccordionItem(
                trigger: VNLAccordionTrigger(child: Text('VNLAccordion 1')),
                content: Text('Content 1'),
              ),
              VNLAccordionItem(
                trigger: VNLAccordionTrigger(child: Text('VNLAccordion 2')),
                content: Text('Content 2'),
              ),
              VNLAccordionItem(
                trigger: VNLAccordionTrigger(child: Text('VNLAccordion 3')),
                content: Text('Content 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
