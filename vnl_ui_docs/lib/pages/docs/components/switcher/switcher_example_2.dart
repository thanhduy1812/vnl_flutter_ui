import 'package:vnl_common_ui/shadcn_flutter.dart';

class SwitcherExample2 extends StatefulWidget {
  const SwitcherExample2({super.key});

  @override
  State<SwitcherExample2> createState() => _SwitcherExample2State();
}

class _SwitcherExample2State extends State<SwitcherExample2> {
  bool _isRegister = false;
  final _registerController = VNLFormController();
  final _loginController = VNLFormController();
  @override
  Widget build(BuildContext context) {
    return VNLSwitcher(
      // VNLToggle between login (index 0) and register (index 1) forms.
      index: _isRegister ? 1 : 0,
      onIndexChanged: (index) {
        setState(() {
          _isRegister = index == 1;
        });
      },
      direction: AxisDirection.left,
      children: [
        Container(
          key: const Key('login'),
          width: 350,
          padding: const EdgeInsets.all(16),
          child: VNLForm(
            controller: _loginController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                FormField(
                  key: const TextFieldKey(#email),
                  label: const Text('Email'),
                  validator: const VNLEmailValidator() & const VNLNotEmptyValidator(),
                  showErrors: const {
                    VNLFormValidationMode.changed,
                    VNLFormValidationMode.submitted,
                  },
                  child: VNLTextField(
                    initialValue:
                        _loginController.getValue(const TextFieldKey(#email)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                ),
                const FormField(
                  key: TextFieldKey(#password),
                  label: Text('Password'),
                  validator: VNLNotEmptyValidator(),
                  showErrors: {
                    VNLFormValidationMode.changed,
                    VNLFormValidationMode.submitted,
                  },
                  child: VNLTextField(obscureText: true),
                ),
                const VNLSubmitButton(
                  child: Text('Login'),
                ),
                const Text('Don\'t have an account? ').thenButton(
                    onPressed: () {
                      setState(() {
                        // VNLSwitch to the register form.
                        _isRegister = true;
                      });
                    },
                    child: const Text('Sign Up!')),
              ],
            ),
          ),
        ),
        Container(
          key: const Key('register-form'),
          width: 350,
          padding: const EdgeInsets.all(16),
          child: VNLForm(
            controller: _registerController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                FormField(
                  key: const TextFieldKey(#email),
                  label: const Text('Email'),
                  validator: const VNLEmailValidator() & const VNLNotEmptyValidator(),
                  showErrors: const {
                    VNLFormValidationMode.changed,
                    VNLFormValidationMode.submitted,
                  },
                  child: VNLTextField(
                    initialValue: _registerController
                        .getValue(const TextFieldKey(#email)),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    enableSuggestions: false,
                  ),
                ),
                const FormField(
                  key: TextFieldKey(#password),
                  label: Text('Password'),
                  validator: VNLLengthValidator(
                      min: 6,
                      message: 'Password must be at least 6 characters'),
                  showErrors: {
                    VNLFormValidationMode.changed,
                    VNLFormValidationMode.submitted,
                  },
                  child: VNLTextField(obscureText: true),
                ),
                const FormField(
                  key: TextFieldKey(#confirmPassword),
                  label: Text('Confirm Password'),
                  validator: CompareWith.equal(TextFieldKey(#password),
                      message: 'Passwords do not match'),
                  showErrors: {
                    VNLFormValidationMode.changed,
                    VNLFormValidationMode.submitted,
                  },
                  child: VNLTextField(obscureText: true),
                ),
                const VNLSubmitButton(
                  child: Text('Register'),
                ),
                const Text('Already have an account? ').thenButton(
                    onPressed: () {
                      setState(() {
                        // VNLSwitch back to the login form.
                        _isRegister = false;
                      });
                    },
                    child: const Text('Login!')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
