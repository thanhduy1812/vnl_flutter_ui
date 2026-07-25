import 'package:vnl_common_ui/vnl_ui.dart' as vnl;
import 'package:flutter/material.dart';

/// Wrap an existing Material/Cupertino app with [vnl.VNLookLayer] and [vnl.ThemeData].
/// Useful when you want to adopt VNL components and theming without
/// replacing your root MaterialApp/CupertinoApp structure.

class WrapperExample1 extends StatelessWidget {
  const WrapperExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const vnl.VNLookLayer(
      theme: vnl.ThemeData(),
      darkTheme: vnl.ThemeData.dark(),
      child: vnl.VNLScaffold(
        headers: [
          vnl.VNLAppBar(
            title: Text('VNL UI Wrapper Example'),
          ),
          vnl.VNLDivider(),
        ],
        child: Center(
          child: Text('Hello, VNL Flutter!'),
        ),
      ),
    );
  }
}
