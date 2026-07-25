import 'package:vnl_common_ui/shadcn_flutter.dart';

/// Demonstrates using the correct typed FormKey for each widget.
///
/// Every form-capable widget reports a specific value type. The FormKey's
/// generic type must match — use the typed alias (TextFieldKey, CheckboxKey,
/// DatePickerKey, SwitchKey, etc.) instead of the generic FormKey.
class FormExample4 extends StatefulWidget {
  const FormExample4({super.key});

  @override
  State<FormExample4> createState() => _FormExample4State();
}

class _FormExample4State extends State<FormExample4> {
  // ✅ Each key uses the correct typed alias for the widget it pairs with.
  //    Always use const to preserve key identity across rebuilds.
  final _nameKey = const TextFieldKey('name'); // VNLTextField → String
  final _agreeKey = const CheckboxKey('agree'); // VNLCheckbox → VNLCheckboxState
  final _birthdayKey = const DatePickerKey('birthday'); // VNLDatePicker → DateTime
  final _notifyKey = const SwitchKey('notify'); // VNLSwitch → bool

  VNLCheckboxState _agreeState = VNLCheckboxState.unchecked;
  bool _notifyState = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: VNLForm(
        onSubmit: (context, values) {
          // Read values with full type safety — no casting needed.
          String? name = _nameKey[values];
          VNLCheckboxState? agree = _agreeKey[values];
          DateTime? birthday = _birthdayKey[values];
          bool? notify = _notifyKey[values];
          showDialog(
            context: context,
            builder: (context) {
              return VNLAlertDialog(
                title: const Text('VNLForm Values'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: $name'),
                    Text('Agree: $agree'),
                    Text('Birthday: $birthday'),
                    Text('Notify: $notify'),
                  ],
                ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormField<String>(
                  key: _nameKey,
                  label: const Text('Name'),
                  validator: const VNLLengthValidator(min: 2),
                  child: const VNLTextField(
                    initialValue: 'Jane Doe',
                  ),
                ),
                FormInline<VNLCheckboxState>(
                  key: _agreeKey,
                  label: const Text('I agree to the terms'),
                  validator: const CompareTo.equal(VNLCheckboxState.checked,
                      message: 'You must agree'),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: VNLCheckbox(
                      state: _agreeState,
                      onChanged: (value) {
                        setState(() {
                          _agreeState = value;
                        });
                      },
                    ),
                  ),
                ),
                FormField<DateTime>(
                  key: _birthdayKey,
                  label: const Text('Birthday'),
                  validator:
                      const VNLNonNullValidator(message: 'Please select a date'),
                  child: const VNLControlledDatePicker(),
                ),
                FormInline<bool>(
                  key: _notifyKey,
                  label: const Text('Email notifications'),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: VNLSwitch(
                      value: _notifyState,
                      onChanged: (value) {
                        setState(() {
                          _notifyState = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ).gap(24),
            const Gap(24),
            VNLFormErrorBuilder(
              builder: (context, errors, child) {
                return VNLPrimaryButton(
                  onPressed: errors.isEmpty ? () => context.submitForm() : null,
                  child: const Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
