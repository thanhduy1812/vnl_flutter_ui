import 'package:meta/meta.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

import '../view_model/page_view_model.dart';

class PageViewController<T extends PageViewModel> extends StatefulWidget {
  static String get route => "pageRoute";
  String getRoute() => route;
  final T viewModel;
  const PageViewController({super.key, required this.viewModel});

  @protected
  List<Widget> buildHeaders(BuildContext pageContext) {
    return [];
  }

  @protected
  List<Widget> buildFooters(BuildContext pageContext) {
    return [];
  }

  @mustBeOverridden
  Widget buildBody(BuildContext pageContext) {
    throw UnimplementedError();
  }

  @override
  State<PageViewController> createState() => _PageViewControllerState();
}

class _PageViewControllerState extends State<PageViewController> {
  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: widget.viewModel,
      child: VNLScaffold(
        key: widget.viewModel.scaffoldKey,
        headers: widget.buildHeaders(context),
        footers: widget.buildFooters(context),
        loadingProgressIndeterminate: widget.viewModel.loadingProgressIndeterminate ?? false,
        loadingProgress: widget.viewModel.loadingProgress,
        floatingHeader: widget.viewModel.floatingHeader ?? false,
        floatingFooter: widget.viewModel.floatingFooter ?? false,
        backgroundColor: widget.viewModel.backgroundColor,
        headerBackgroundColor: widget.viewModel.headerBackgroundColor,
        footerBackgroundColor: widget.viewModel.footerBackgroundColor,
        showLoadingSparks: widget.viewModel.showLoadingSparks ?? false,
        resizeToAvoidBottomInset: widget.viewModel.resizeToAvoidBottomInset ?? true,
        child: widget.buildBody(context),
      ),
    );
  }
}
