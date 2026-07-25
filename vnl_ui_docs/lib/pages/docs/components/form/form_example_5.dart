import 'package:vnl_common_ui/vnl_ui.dart';

/// Demonstrates composing validators with operators.
///
/// Validators can be combined using:
///   & (AND) — all must pass
///   | (OR)  — any one passing is enough
///   ~ (NOT) — negates a validator
///
/// This example shows a password field that requires both minimum length
/// AND password complexity, combined with & operator.
class FormExample5 extends StatelessWidget {
  const FormExample5({super.key});

  static const _passwordKey = TextFieldKey('password');
  static const _confirmKey = TextFieldKey('confirm');

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
                title: const Text('Success'),
                content: const Text('Password is valid!'),
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
                FormField<String>(
                  key: _passwordKey,
                  label: const Text('Password'),
                  // Compose validators with & (AND): both must pass.
                  validator: const VNLLengthValidator(min: 8) &
                      const VNLSafePasswordValidator(
                        requireSpecialChar: false,
                        requireUppercase: false,
                        requireLowercase: false,
                      ),
                  showErrors: const {
                    VNLFormValidationMode.changed,
                    VNLFormValidationMode.submitted,
                  },
                  child: const VNLTextField(obscureText: true),
                ),
                const FormField<String>(
                  key: _confirmKey,
                  label: Text('Confirm'),
                  // Cross-field validation: must equal the password field.
                  // CompareWith automatically re-validates when the
                  // referenced field (_passwordKey) changes.
                  validator: CompareWith.equal(
                    _passwordKey,
                    message: 'Passwords do not match',
                  ),
                  showErrors: {
                    VNLFormValidationMode.changed,
                    VNLFormValidationMode.submitted,
                  },
                  child: VNLTextField(obscureText: true),
                ),
              ],
            ),
            const Gap(24),
            const VNLSubmitButton(child: Text('Validate')),
          ],
        ),
      ),
    );
  }
}
