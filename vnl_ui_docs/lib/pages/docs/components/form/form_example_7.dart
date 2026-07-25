import 'dart:convert';

import 'package:vnl_common_ui/vnl_ui.dart';

/// Demonstrates IgnoreForm to exclude widgets from form participation.
///
/// Any form-capable widget (VNLTextField, VNLCheckbox, etc.) placed inside a VNLForm
/// will automatically register with the VNLFormController. Wrap non-form inputs
/// in IgnoreForm to prevent them from participating in validation or submission.
///
/// In this example the search field at the top is excluded from the form,
/// while the name and email fields participate normally.
class FormExample7 extends StatelessWidget {
  const FormExample7({super.key});

  static const _nameKey = TextFieldKey('name');
  static const _emailKey = TextFieldKey('email');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: VNLForm(
        onSubmit: (context, values) {
          String json = jsonEncode(values.map((key, value) {
            return MapEntry(key.key, value);
          }));
          showDialog(
            context: context,
            builder: (context) {
              return VNLAlertDialog(
                title: const Text('Submitted Values'),
                content: Text(json),
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
            const Gap(16),
            VNLFormTableLayout(
              rows: [
                const FormField<String>(
                  key: TextFieldKey('search'),
                  label: Text('Search (ignored)'),
                  // This VNLTextField is wrapped in IgnoreForm, so it does NOT
                  // participate in form validation or submission.
                  child: IgnoreForm(
                    child: VNLTextField(
                      placeholder: Text('Type to search...'),
                    ),
                  ),
                ),
                // These fields participate in the form normally.
                const FormField<String>(
                  key: _nameKey,
                  label: Text('Name'),
                  validator: VNLLengthValidator(min: 2),
                  child: VNLTextField(),
                ),
                FormField<String>(
                  key: _emailKey,
                  label: const Text('Email'),
                  validator: const VNLEmailValidator() & const VNLNotEmptyValidator(),
                  child: const VNLTextField(),
                ),
              ],
            ),
            const Gap(24),
            const VNLSubmitButton(child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
