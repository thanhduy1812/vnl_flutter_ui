import 'package:vnl_common_ui/vnl_ui.dart';

class DialogExample1 extends StatelessWidget {
  const DialogExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLPrimaryButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final FormController controller = FormController();
            return VNLAlertDialog(
              title: const Text('Edit profile'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Make changes to your profile here. Click save when you\'re done'),
                  const Gap(16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: VNLForm(
                      controller: controller,
                      child: const FormTableLayout(rows: [
                        FormField<String>(
                          key: FormKey(#name),
                          label: Text('Name'),
                          child: VNLTextField(
                            initialValue: 'Thito Yalasatria Sunarya',
                          ),
                        ),
                        FormField<String>(
                          key: FormKey(#username),
                          label: Text('Username'),
                          child: VNLTextField(
                            initialValue: '@sunaryathito',
                          ),
                        ),
                      ]),
                    ).withPadding(vertical: 16),
                  ),
                ],
              ),
              actions: [
                VNLPrimaryButton(
                  child: const Text('Save changes'),
                  onPressed: () {
                    Navigator.of(context).pop(controller.values);
                  },
                ),
              ],
            );
          },
        );
      },
      child: const Text('Edit Profile'),
    );
  }
}
