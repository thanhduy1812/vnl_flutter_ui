import 'package:vnl_common_ui/vnl_ui.dart';

class PhoneInputExample1 extends StatefulWidget {
  const PhoneInputExample1({super.key});

  @override
  State<PhoneInputExample1> createState() => _PhoneInputExample1State();
}

class _PhoneInputExample1State extends State<PhoneInputExample1> {
  VNLPhoneNumber? _phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VNLPhoneInput(
          // Preselect a country; phone parsing/formatting adapt accordingly.
          initialCountry: Country.indonesia,
          onChanged: (value) {
            setState(() {
              _phoneNumber = value;
            });
          },
        ),
        const Gap(24),
        Text(
          _phoneNumber?.value ?? '(No value)',
        ),
      ],
    );
  }
}
