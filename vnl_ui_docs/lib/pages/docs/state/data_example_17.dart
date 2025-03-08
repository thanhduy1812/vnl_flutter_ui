import 'package:vnl_common_ui/vnl_ui.dart';

class MyComplexData with DistinctData {
  final int myInt;
  final bool myBool;

  const MyComplexData({
    required this.myInt,
    required this.myBool,
  });

  @override
  bool shouldNotify(covariant MyComplexData oldData) {
    // only rebuild if myInt changes
    return oldData.myInt != myInt;
  }
}
