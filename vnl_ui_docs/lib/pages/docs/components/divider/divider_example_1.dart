import 'package:vnl_common_ui/vnl_ui.dart';

class DividerExample1 extends StatelessWidget {
  const DividerExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          VNLDivider(),
          Text('Item 2'),
          VNLDivider(),
          Text('Item 3'),
        ],
      ),
    );
  }
}
