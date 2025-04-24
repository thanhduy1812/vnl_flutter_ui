import 'package:flutter/material.dart';
import 'package:vnl_common_ui/vnl_ui.dart' as vnlui;

class MaterialExample1 extends StatefulWidget {
  const MaterialExample1({super.key});

  @override
  State<MaterialExample1> createState() => _MaterialExample1State();
}

class _MaterialExample1State extends State<MaterialExample1> {
  int _counter = 0;

  void _incrementCounter() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have pushed the button $_counter times'),
      ),
    );
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Material App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const vnlui.Gap(64),
            vnlui.VNLookUI(
                child: vnlui.VNLCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('You can also use vnl_ui widgets inside Material widgets'),
                  const vnlui.Gap(16),
                  vnlui.PrimaryButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return vnlui.VNLAlertDialog(
                            title: const Text('Hello'),
                            content: const Text('This is Material dialog'),
                            actions: [
                              TextButton(
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
                    child: const Text('Open Material Dialog'),
                  ),
                  const vnlui.Gap(8),
                  vnlui.SecondaryButton(
                    onPressed: () {
                      vnlui.showDialog(
                        context: context,
                        builder: (context) {
                          return vnlui.VNLAlertDialog(
                            title: const Text('Hello'),
                            content: const Text('This is vnl_ui dialog'),
                            actions: [
                              vnlui.PrimaryButton(
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
                    child: const Text('Open vnl_ui Dialog'),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
