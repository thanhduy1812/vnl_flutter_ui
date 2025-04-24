import 'package:vnl_common_ui/vnl_ui.dart';

class SliderExample1 extends StatefulWidget {
  const SliderExample1({super.key});

  @override
  State<SliderExample1> createState() => _SliderExample1State();
}

class _SliderExample1State extends State<SliderExample1> {
  SliderValue value = const SliderValue.single(0.5);
  @override
  Widget build(BuildContext context) {
    return VNLSlider(
      value: value,
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
      },
    );
  }
}
