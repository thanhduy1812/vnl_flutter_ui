import 'package:vnl_common_ui/vnl_ui.dart';

class AppBarExample1 extends StatelessWidget {
  const AppBarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: VNLAppBar(
        header: const Text('This is Header'),
        title: const Text('This is Title'),
        subtitle: const Text('This is Subtitle'),
        leading: [
          VNLOutlineButton(
            density: ButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.arrow_back),
          ),
        ],
        trailing: [
          VNLOutlineButton(
            density: ButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.search),
          ),
          VNLOutlineButton(
            density: ButtonDensity.icon,
            onPressed: () {},
            child: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
