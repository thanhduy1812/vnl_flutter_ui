import 'package:vnl_common_ui/vnl_ui.dart';

class BreadcrumbExample1 extends StatelessWidget {
  const BreadcrumbExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLBreadcrumb(
      separator: VNLBreadcrumb.arrowSeparator,
      children: [
        TextButton(
          onPressed: () {},
          density: ButtonDensity.compact,
          child: const Text('Home'),
        ),
        const MoreDots(),
        TextButton(
          onPressed: () {},
          density: ButtonDensity.compact,
          child: const Text('Components'),
        ),
        const Text('Breadcrumb'),
      ],
    );
  }
}
