import 'package:vnl_common_ui/vnl_ui.dart';

class RepeatedAnimationBuilderExample1 extends StatelessWidget {
  const RepeatedAnimationBuilderExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return RepeatedAnimationBuilder(
      start: const Offset(-100, 0),
      end: const Offset(100, 0),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
