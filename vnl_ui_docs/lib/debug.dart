import 'package:vnl_common_ui/vnl_ui.dart';

class RebuildCounter extends StatefulWidget {
  const RebuildCounter({Key? key}) : super(key: key);

  @override
  State<RebuildCounter> createState() => _RebuildCounterState();
}

class _RebuildCounterState extends State<RebuildCounter> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: VNLColors.primaries[hashCode % VNLColors.primaries.length],
      child: Center(
        child: Text('Rebuild count: ${counter++}'),
      ),
    );
  }
}
