import 'package:vnl_common_ui/vnl_ui.dart';

class InputExample4 extends StatelessWidget {
  const InputExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLForm(
      child: FormField(
        key: const InputKey(#test),
        label: const Text('Username'),
        validator: ConditionalValidator((value) async {
          // simulate a network delay for example purpose
          await Future.delayed(const Duration(seconds: 1));
          return !['sunarya-thito', 'septogeddon', 'admin'].contains(value);
        }, message: 'Username already taken'),
        child: const VNLTextField(
          placeholder: Text('Enter your username'),
          initialValue: 'sunarya-thito',
          features: [
            InputFeature.revalidate(),
          ],
        ),
      ),
    );
  }
}
