import 'package:vnl_common_ui/vnl_ui.dart';

/// Compares standard vs Controlled component boilerplate.
///
/// The left column uses standard widgets that require manual state
/// management (StatefulWidget, setState, value/onChanged wiring).
/// The right column uses Controlled variants that handle state
/// internally — no StatefulWidget or setState needed.
class FormExample9 extends StatefulWidget {
  const FormExample9({super.key});

  @override
  State<FormExample9> createState() => _FormExample9State();
}

class _FormExample9State extends State<FormExample9> {
  // ── Standard widgets need manual state ──
  VNLCheckboxState _checkboxState = VNLCheckboxState.unchecked;
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Standard: you manage the state ──
          const Text('Standard (manual state)').semiBold,
          const Gap(24),
          VNLCheckbox(
            state: _checkboxState,
            onChanged: (value) {
              setState(() {
                _checkboxState = value;
              });
            },
            trailing: const Text('Accept terms'),
          ),
          const Gap(8),
          VNLSwitch(
            value: _switchValue,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
              });
            },
            trailing: const Text('Dark mode'),
          ),
          const Gap(32),
          const VNLDivider(),
          const Gap(32),
          // ── Controlled: zero boilerplate ──
          const Text('Controlled (no manual state)').semiBold,
          const Gap(24),
          const VNLControlledCheckbox(
            trailing: Text('Accept terms'),
          ),
          const Gap(8),
          const VNLControlledSwitch(
            trailing: Text('Dark mode'),
          ),
        ],
      ),
    );
  }
}
