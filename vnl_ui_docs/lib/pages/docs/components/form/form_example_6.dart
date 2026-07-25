import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Demonstrates the difference between showErrors and ValidationMode.
///
/// - ValidationMode controls WHEN a validator RUNS.
/// - showErrors controls WHEN error messages are VISIBLE in the UI.
///
/// In this example the email field uses ValidationMode to only run the
/// async "already taken" check on submit, while showErrors hides all
/// error messages until the user interacts or submits.
class FormExample6 extends StatelessWidget {
  const FormExample6({super.key});

  static const _emailKey = TextFieldKey('email');
  static const _takenEmails = ['admin@example.com', 'user@example.com'];

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
                title: const Text('Submitted'),
                content: Text('Email: ${_emailKey[values]}'),
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
                  key: _emailKey,
                  label: const Text('Email'),
                  hint: const Text('Try admin@example.com to see async error'),
                  // Validator composition:
                  //  1. VNLEmailValidator always runs (on initial, change, submit)
                  //  2. "Already taken" check only runs on submit
                  validator: const VNLEmailValidator() &
                      ValidationMode(
                        VNLConditionalValidator((value) async {
                          await Future.delayed(const Duration(seconds: 1));
                          return !_takenEmails.contains(value);
                        }, message: 'Email already taken'),
                        // This validator only RUNS on submit
                        mode: {VNLFormValidationMode.submitted},
                      ),
                  // Error messages only VISIBLE after change or submit
                  // (not on initial load, so the form starts clean)
                  showErrors: const {
                    VNLFormValidationMode.changed,
                    VNLFormValidationMode.submitted,
                  },
                  child: const VNLTextField(),
                ),
              ],
            ),
            const Gap(24),
            const VNLSubmitButton(
              loadingTrailing: AspectRatio(
                aspectRatio: 1,
                child: VNLCircularProgressIndicator(onSurface: true),
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
