import 'dart:convert';

import 'package:vnl_common_ui/vnl_ui.dart';

class FormExample3 extends StatefulWidget {
  const FormExample3({super.key});

  @override
  State<FormExample3> createState() => _FormExample3State();
}

class _FormExample3State extends State<FormExample3> {
  final _dummyData = [
    'thanhduy1812',
    'septogeddon',
    'vnl',
  ];

  final _usernameKey = const TextFieldKey('username');
  final _passwordKey = const TextFieldKey('password');
  final _confirmPasswordKey = const TextFieldKey('confirmPassword');
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: VNLForm(
        onSubmit: (context, values) {
          showDialog(
            context: context,
            builder: (context) {
              return VNLAlertDialog(
                title: const Text('VNLForm Values'),
                content: Text(jsonEncode(values.map(
                  (key, value) {
                    return MapEntry(key.key, value);
                  },
                ))),
                actions: [
                  VNLPrimaryButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VNLFormTableLayout(
              rows: [
                FormField(
                  key: _usernameKey,
                  label: const Text('Username'),
                  hint: const Text('This is your public display name'),
                  // Combine validators: length + async availability check,
                  // but only run the async validator on submit.
                  validator: const VNLLengthValidator(min: 4) &
                      ValidationMode(
                        VNLConditionalValidator((value) async {
                          // simulate a network delay for example purpose
                          await Future.delayed(const Duration(seconds: 1));
                          return !_dummyData.contains(value);
                        }, message: 'Username already taken'),
                        // only validate when the form is submitted
                        mode: {VNLFormValidationMode.submitted},
                      ),
                  child: const VNLTextField(
                    initialValue: 'thanhduy1812',
                  ),
                ),
                FormField(
                  key: _passwordKey,
                  label: const Text('Password'),
                  validator: const VNLLengthValidator(min: 8),
                  showErrors: const {VNLFormValidationMode.submitted, VNLFormValidationMode.changed},
                  child: const VNLTextField(
                    obscureText: true,
                  ),
                ),
                FormField<String>(
                  key: _confirmPasswordKey,
                  label: const Text('Confirm Password'),
                  showErrors: const {VNLFormValidationMode.submitted, VNLFormValidationMode.changed},
                  validator: CompareWith.equal(_passwordKey, message: 'Passwords do not match'),
                  child: const VNLTextField(
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const Gap(24),
            const VNLSubmitButton(
              loadingTrailing: AspectRatio(
                aspectRatio: 1,
                child: VNLCircularProgressIndicator(
                  onSurface: true,
                ),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
