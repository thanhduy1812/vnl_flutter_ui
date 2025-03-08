import 'package:vnl_common_ui/vnl_ui.dart';

class DividerExample3 extends StatelessWidget {
  const DividerExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          Divider(
            child: Text('Divider'),
          ),
          Text('Item 2'),
          Divider(
            child: Text('Divider'),
          ),
          Text('Item 3'),
        ],
      ),
    );
  }
}
