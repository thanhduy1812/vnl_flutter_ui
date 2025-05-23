import 'package:vnl_common_ui/vnl_ui.dart';

class DotIndicatorExample1 extends StatefulWidget {
  const DotIndicatorExample1({super.key});

  @override
  State<DotIndicatorExample1> createState() => _DotIndicatorExample1State();
}

class _DotIndicatorExample1State extends State<DotIndicatorExample1> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return VNLDotIndicator(
        index: _index,
        length: 5,
        onChanged: (index) {
          setState(() {
            _index = index;
          });
        });
  }
}
