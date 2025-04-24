import 'package:vnl_common_ui/vnl_ui.dart';

class PaginationExample1 extends StatefulWidget {
  const PaginationExample1({super.key});

  @override
  State<PaginationExample1> createState() => _PaginationExample1State();
}

class _PaginationExample1State extends State<PaginationExample1> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return VNLPagination(
      page: page,
      totalPages: 20,
      onPageChanged: (value) {
        setState(() {
          page = value;
        });
      },
      maxPages: 3,
    );
  }
}
