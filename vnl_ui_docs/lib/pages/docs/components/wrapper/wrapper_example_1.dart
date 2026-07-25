import 'package:vnl_common_ui/shadcn_flutter.dart' as shadcn;
import 'package:flutter/material.dart';

// Wrap an existing Material/Cupertino app with VNLookUI and Theme.
// Useful when you want to adopt Shadcn components and theming without
// replacing your root MaterialApp/CupertinoApp structure.

class WrapperExample1 extends StatelessWidget {
  const WrapperExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // If you are using MaterialApp or CupertinoApp
    // but still want to use Shadcn UI theming and components,
    // you can wrap your app with VNLookUI and Theme.
    return const shadcn.VNLookLayer(
      theme: shadcn.ThemeData(),
      darkTheme: shadcn.ThemeData.dark(),
      child: shadcn.VNLScaffold(
        headers: [
          shadcn.VNLAppBar(
            title: Text('Shadcn UI VNLWrapper Example'),
          ),
          shadcn.VNLDivider(),
        ],
        child: Center(
          child: shadcn.Text('Hello, Shadcn Flutter!'),
        ),
      ),
    );
  }
}
