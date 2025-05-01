import 'package:base_app/pages/base/view_controller/page_view_controller.dart';
import 'package:base_app/pages/home/view_model/home_view_model.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class HomeViewController extends PageViewController<HomeViewModel> {
  const HomeViewController({super.key, required super.viewModel});
  @override
  Widget buildBody(BuildContext pageContext) {
    return const Placeholder();
  }

  @override
  HomeViewControllerState createState() {
    return HomeViewControllerState();
  }
}

class HomeViewControllerState extends PageViewControllerState<HomeViewController> {}
