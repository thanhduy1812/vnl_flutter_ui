import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material;
import 'package:vnl_common_ui/vnl_ui.dart';

class DialogTile extends StatelessWidget implements IComponentPage {
  const DialogTile({super.key});

  @override
  String get title => 'Dialog';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Dialog',
      name: 'dialog',
      example: VNLAlertDialog(
        barrierColor: material.Colors.transparent,
        title: const Text('Edit profile'),
        content: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                  'Make changes to your profile here. Click save when you\'re done'),
              const Gap(16),
              const VNLForm(
                child: VNLFormTableLayout(rows: [
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
            ],
          ),
        ),
        actions: [
          VNLPrimaryButton(
            child: const Text('Save changes'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
