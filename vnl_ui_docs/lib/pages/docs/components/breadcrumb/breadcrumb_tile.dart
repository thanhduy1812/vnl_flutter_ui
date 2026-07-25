import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/breadcrumb/breadcrumb_example_1.dart';
import 'package:flutter/material.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class BreadcrumbTile extends StatelessWidget implements IComponentPage {
  const BreadcrumbTile({super.key});

  @override
  String get title => 'VNLBreadcrumb';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      title: 'VNLBreadcrumb',
      name: 'breadcrumb',
      example: BreadcrumbExample1(),
    );
  }
}
