import '../../../vnl_ui.dart';

abstract class SpinnerTransform {}

abstract class SpinnerElement {
  void paint(Canvas canvas, Size size, Matrix4 transform);
}

abstract class VNLSpinner extends StatelessWidget {
  const VNLSpinner({super.key});
}
