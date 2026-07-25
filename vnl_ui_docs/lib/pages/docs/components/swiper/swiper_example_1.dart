import 'package:vnl_common_ui/shadcn_flutter.dart';

class SwiperExample1 extends StatefulWidget {
  const SwiperExample1({super.key});

  @override
  State<SwiperExample1> createState() => _SwiperExample1State();
}

class _SwiperExample1State extends State<SwiperExample1> {
  VNLOverlayPosition _position = VNLOverlayPosition.end;
  bool _typeDrawer = true;

  Widget _buildSelectPosition(VNLOverlayPosition position, String label) {
    return VNLSelectedButton(
      value: _position == position,
      onChanged: (value) {
        if (value) {
          setState(() {
            _position = position;
          });
        }
      },
      style: const VNLButtonStyle.outline(),
      selectedStyle: const VNLButtonStyle.primary(),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return VNLSwiper(
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(
            minWidth: 320,
            minHeight: 320,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hello!'),
              const Gap(24),
              VNLPrimaryButton(
                onPressed: () {
                  openDrawer(
                      context: context,
                      builder: (context) {
                        return ListView.separated(
                          itemCount: 1000,
                          itemBuilder: (context, index) {
                            return VNLCard(
                              child: Text('Item $index'),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(8);
                          },
                        );
                      },
                      position: VNLOverlayPosition.bottom);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      // VNLSwiper displays an overlay (drawer/sheet) that can be swiped in from a chosen edge.
      position: _position,
      // Choose the overlay type: Drawer slides over content; Sheet peeks up from an edge.
      handler: _typeDrawer ? VNLSwiperHandler.drawer : VNLSwiperHandler.sheet,
      child: SizedBox(
        height: 500,
        child: VNLCard(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Swipe me!'),
                const Gap(24),
                VNLButtonGroup(children: [
                  _buildSelectPosition(VNLOverlayPosition.left, 'Left'),
                  _buildSelectPosition(VNLOverlayPosition.right, 'Right'),
                  _buildSelectPosition(VNLOverlayPosition.top, 'Top'),
                  _buildSelectPosition(VNLOverlayPosition.bottom, 'Bottom'),
                ]),
                const Gap(24),
                VNLButtonGroup(children: [
                  VNLToggle(
                    value: _typeDrawer,
                    onChanged: (value) {
                      setState(() {
                        _typeDrawer = value;
                      });
                    },
                    child: const Text('Drawer'),
                  ),
                  VNLToggle(
                    value: !_typeDrawer,
                    onChanged: (value) {
                      setState(() {
                        _typeDrawer = !value;
                      });
                    },
                    child: const Text('Sheet'),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
