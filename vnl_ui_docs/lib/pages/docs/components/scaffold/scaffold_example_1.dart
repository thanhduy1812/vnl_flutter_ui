import 'package:vnl_common_ui/vnl_ui.dart';

class ScaffoldExample1 extends StatefulWidget {
  const ScaffoldExample1({super.key});

  @override
  State<ScaffoldExample1> createState() => _ScaffoldExample1State();
}

class _ScaffoldExample1State extends State<ScaffoldExample1> {
  // Simple counter to demonstrate updating content inside the VNLScaffold body.
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VNLScaffold(
      // Show an indeterminate progress indicator in the header area (for demo purposes).
      loadingProgressIndeterminate: true,
      headers: [
        VNLAppBar(
          title: const Text('Counter App'),
          subtitle: const Text('A simple counter app'),
          leading: [
            VNLOutlineButton(
              onPressed: () {},
              density: VNLButtonDensity.icon,
              child: const Icon(Icons.menu),
            ),
          ],
          trailing: [
            VNLOutlineButton(
              onPressed: () {},
              density: VNLButtonDensity.icon,
              child: const Icon(Icons.search),
            ),
            VNLOutlineButton(
              onPressed: () {},
              density: VNLButtonDensity.icon,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        // VNLDivider between the header and the body.
        const VNLDivider(),
      ],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // The .p() extension adds default padding around the widget.
            const Text('You have pushed the button this many times:').p(),
            Text(
              '$_counter',
            ).h1(),
            VNLPrimaryButton(
              onPressed: _incrementCounter,
              density: VNLButtonDensity.icon,
              child: const Icon(Icons.add),
            ).p(),
          ],
        ),
      ),
    );
  }
}
