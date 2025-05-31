import 'package:vnl_common_ui/vnl_ui.dart';

class CardExample1 extends StatelessWidget {
  const CardExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return VNLCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Create project').semiBold(),
          const SizedBox(height: 4),
          const Text('Deploy your new project in one-click').muted().small(),
          const SizedBox(height: 24),
          const Text('Name').semiBold().small(),
          const SizedBox(height: 4),
          const VNLTextField(placeholder: Text('Name of your project')),
          const SizedBox(height: 16),
          const Text('Description').semiBold().small(),
          const SizedBox(height: 4),
          const VNLTextField(placeholder: Text('Description of your project')),
          const SizedBox(height: 24),
          Row(
            children: [
              VNLOutlineButton(
                child: const Text('Cancel'),
                onPressed: () {},
              ),
              const Spacer(),
              VNLPrimaryButton(
                child: const Text('Deploy'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    ).intrinsic();
  }
}
