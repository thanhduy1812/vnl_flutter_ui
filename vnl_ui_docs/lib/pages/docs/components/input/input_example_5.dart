import 'package:vnl_common_ui/vnl_ui.dart';

/// This example demonstrates grouping multiple input fields together
/// using the `VNLButtonGroup` component.

class InputExample5 extends StatelessWidget {
  const InputExample5({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        VNLButtonGroup(children: [
          // Its important to set width constraints on the TextFields
          SizedBox(
            width: 75,
            child: VNLTextField(placeholder: Text('Red')),
          ),
          SizedBox(
            width: 75,
            child: VNLTextField(placeholder: Text('Green')),
          ),
          SizedBox(
            width: 75,
            child: VNLTextField(placeholder: Text('Blue')),
          ),
          SizedBox(
            width: 75,
            child: VNLTextField(placeholder: Text('Alpha')),
          ),
        ]),
        VNLButtonGroup.vertical(
          children: [
            // Its important to set width constraints on the TextFields
            SizedBox(
              width: 200,
              child: VNLTextField(placeholder: Text('First Name')),
            ),
            VNLButtonGroup.horizontal(
              children: [
                SizedBox(
                  width: 100,
                  child: VNLTextField(placeholder: Text('Middle Name')),
                ),
                SizedBox(
                  width: 100,
                  child: VNLTextField(placeholder: Text('Last Name')),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
