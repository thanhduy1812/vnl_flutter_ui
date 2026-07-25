import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Demonstrates the two ways to build a submit button.
///
/// Option 1: VNLFormErrorBuilder — full manual control over button state.
///   Rebuilds whenever validation errors change. Lets you customize
///   the button appearance for error, loading, and valid states.
///
/// Option 2: VNLSubmitButton — automatic handling of loading and error states.
///   Disables while async validators are pending, shows a loading indicator,
///   and disables while validation errors exist.
class FormExample8 extends StatelessWidget {
  const FormExample8({super.key});

  static const _nameKey = TextFieldKey('name');
  static const _emailKey = TextFieldKey('email');

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
                content: Text('Name: ${_nameKey[values]}\n'
                    'Email: ${_emailKey[values]}'),
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
                const FormField<String>(
                  key: _nameKey,
                  label: Text('Name'),
                  validator: VNLLengthValidator(min: 2),
                  child: VNLTextField(),
                ),
                FormField<String>(
                  key: _emailKey,
                  label: const Text('Email'),
                  // Async validator only runs on submit
                  validator: const VNLEmailValidator() &
                      ValidationMode(
                        VNLConditionalValidator((value) async {
                          await Future.delayed(const Duration(seconds: 1));
                          return true; // always passes (demo)
                        }, message: 'Checking email...'),
                        mode: {VNLFormValidationMode.submitted},
                      ),
                  child: const VNLTextField(),
                ),
              ],
            ),
            const Gap(24),
            // Option 1: Manual submit with VNLFormErrorBuilder
            VNLFormErrorBuilder(
              builder: (context, errors, child) {
                return VNLPrimaryButton(
                  onPressed: errors.isEmpty ? () => context.submitForm() : null,
                  child: const Text('Manual Submit'),
                );
              },
            ),
            const Gap(8),
            // Option 2: Automatic submit with VNLSubmitButton
            const VNLSubmitButton(
              loadingTrailing: AspectRatio(
                aspectRatio: 1,
                child: VNLCircularProgressIndicator(onSurface: true),
              ),
              child: Text('Auto Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
