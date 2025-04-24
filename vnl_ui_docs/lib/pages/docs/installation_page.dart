import 'package:vnl_common_ui/vnl_ui.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../docs_page.dart';

class InstallationPage extends StatefulWidget {
  const InstallationPage({super.key});

  @override
  _InstallationPageState createState() => _InstallationPageState();
}

class _InstallationPageState extends State<InstallationPage> {
  final OnThisPage _manualKey = OnThisPage();
  final OnThisPage _experimentalKey = OnThisPage();
  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'installation',
      onThisPage: {
        'Stable Version': _manualKey,
        'Experimental Version': _experimentalKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Installation').h1(),
          const Text('Install and configure vnl_ui in your project.').lead(),
          const Text('Stable Version').h2().anchored(_manualKey),
          const Gap(32),
          VNLSteps(
            children: [
              StepItem(
                title: const Text('Creating a new Flutter project'),
                content: [
                  const Text('Create a new Flutter project using the following command:').p(),
                  const CodeSnippet(
                    code: 'flutter create my_app\ncd my_app',
                    mode: 'shell',
                  ).p(),
                ],
              ),
              StepItem(
                title: const Text('Adding the dependency'),
                content: [
                  const Text('Next, add the vnl_ui dependency to your project.').p(),
                  const CodeSnippet(
                    code: 'flutter pub add vnl_ui',
                    mode: 'shell',
                  ).p(),
                ],
              ),
              StepItem(
                title: const Text('Importing the package'),
                content: [
                  const Text('Now, you can import the package in your Dart code.').p(),
                  const CodeSnippet(
                    code: 'import \'package:vnl_ui/vnl_ui.dart\';',
                    mode: 'dart',
                  ).p(),
                ],
              ),
              StepItem(
                title: const Text('Adding the VNLookApp widget'),
                content: [
                  const Text('Add the VNLookApp widget to your main function.').p(),
                  const CodeSnippet(
                    code: '''
void main() {
  runApp(
    VNLookApp(
      title: 'My App',
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorSchemes.darkZinc(),
        radius: 0.5,
      ),
    ),
  );
}
                    ''',
                    mode: 'dart',
                  ).p(),
                ],
              ),
              StepItem(
                title: const Text('Run the app'),
                content: [
                  const Text('Run the app using the following command:').p(),
                  const CodeSnippet(
                    code: 'flutter run',
                    mode: 'shell',
                  ).p(),
                ],
              ),
            ],
          ),
          const Text('Experimental Version').h2().anchored(_experimentalKey),
          const Text('Experimental versions are available on GitHub.').p(),
          const Text('To use an experimental version, use git instead of version number in your '
                  'pubspec.yaml file:')
              .p(),
          const CodeSnippet(
            // code: 'vnl_ui:\n'
            //     '  git:\n'
            //     '    url: "https://github.com/sunarya-thito/vnl_ui.git"',
            code: 'dependencies:\n'
                '  vnl_ui:\n'
                '    git:\n'
                '      url: "https://github.com/sunarya-thito/vnl_ui.git"',
            mode: 'yaml',
          ).p(),
          const Text('See ')
              .thenButton(
                  onPressed: () {
                    launchUrlString('https://dart.dev/tools/pub/dependencies#git-packages');
                  },
                  child: const Text('this page'))
              .thenText(' for more information.')
              .p(),
          const Gap(16),
          const VNLAlert(
            destructive: true,
            leading: Icon(Icons.warning),
            title: Text('Warning'),
            content: Text(
              'Experimental versions may contain breaking changes and are not recommended for production use. '
              'This version is intended for testing and development purposes only.',
            ),
          ),
        ],
      ),
    );
  }
}
