import 'package:flutter/cupertino.dart';
import 'package:vnl_common_ui/vnl_ui.dart' as vnl;

class CupertinoExample1 extends StatefulWidget {
  const CupertinoExample1({super.key});

  @override
  State<CupertinoExample1> createState() => _CupertinoExample1State();
}

class _CupertinoExample1State extends State<CupertinoExample1> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('My Cupertino App'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Text(
              '$_counter',
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
            const vnl.Gap(16),
            CupertinoButton.filled(
              onPressed: () => setState(() => _counter++),
              child: const Icon(CupertinoIcons.add),
            ),
            const vnl.Gap(64),
            // shadcn_flutter widgets can also be used in a Cupertino app.
            // This card mirrors the Material example but uses Cupertino dialogs.
            vnl.VNLookUI(
                child: vnl.VNLCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'You can also use shadcn_flutter widgets inside Material widgets'),
                  const vnl.Gap(16),
                  vnl.VNLPrimaryButton(
                    onPressed: () {
                      // Show a native Cupertino dialog
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: const Text('Hello'),
                            content: const Text('This is Cupertino dialog'),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Open Cupertino Dialog'),
                  ),
                  const vnl.Gap(8),
                  vnl.VNLSecondaryButton(
                    onPressed: () {
                      // Show a shadcn_flutter dialog as a comparison
                      vnl.showDialog(
                        context: context,
                        builder: (context) {
                          return vnl.VNLAlertDialog(
                            title: const Text('Hello'),
                            content:
                                const Text('This is shadcn_flutter dialog'),
                            actions: [
                              vnl.VNLPrimaryButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Open shadcn_flutter Dialog'),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
