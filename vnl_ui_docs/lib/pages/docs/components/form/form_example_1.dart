import 'dart:convert';

import 'package:vnl_common_ui/vnl_ui.dart';

class FormExample1 extends StatefulWidget {
  const FormExample1({super.key});

  @override
  State<FormExample1> createState() => _FormExample1State();
}

class _FormExample1State extends State<FormExample1> {
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
                title: const Text('Form Values'),
                content: Text(jsonEncode(values.map(
                  (key, value) {
                    return MapEntry(key.key, value);
                  },
                ))),
                actions: [
                  PrimaryButton(
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
            FormTableLayout(
              rows: [
                FormField(
                  key: _usernameKey,
                  label: const Text('Username'),
                  hint: const Text('This is your public display name'),
                  validator: const LengthValidator(min: 4),
                  child: const VNLTextField(
                    initialValue: 'sunarya-thito',
                  ),
                ),
                FormField(
                  key: _passwordKey,
                  label: const Text('Password'),
                  validator: const LengthValidator(min: 8),
                  child: const VNLTextField(
                    obscureText: true,
                  ),
                ),
                FormField(
                  key: _confirmPasswordKey,
                  label: const Text('Confirm Password'),
                  validator: CompareWith.equal(_passwordKey, message: 'Passwords do not match'),
                  child: const VNLTextField(
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const Gap(24),
            FormErrorBuilder(
              builder: (context, errors, child) {
                return PrimaryButton(
                  onPressed: errors.isEmpty ? () => context.submitForm() : null,
                  child: const Text('Submit'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
