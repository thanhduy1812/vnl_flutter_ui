import 'package:vnl_common_ui/vnl_ui.dart';

class SwiperExample1 extends StatefulWidget {
  const SwiperExample1({super.key});

  @override
  State<SwiperExample1> createState() => _SwiperExample1State();
}

class _SwiperExample1State extends State<SwiperExample1> {
  OverlayPosition _position = OverlayPosition.left;
  bool _typeDrawer = true;

  Widget _buildSelectPosition(OverlayPosition position, String label) {
    return VNLSelectedButton(
      value: _position == position,
      onChanged: (value) {
        if (value) {
          setState(() {
            _position = position;
          });
        }
      },
      style: const ButtonStyle.outline(),
      selectedStyle: const ButtonStyle.primary(),
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
                      position: OverlayPosition.bottom);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      position: _position,
      handler: _typeDrawer ? SwiperHandler.drawer : SwiperHandler.sheet,
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
                  _buildSelectPosition(OverlayPosition.left, 'Left'),
                  _buildSelectPosition(OverlayPosition.right, 'Right'),
                  _buildSelectPosition(OverlayPosition.top, 'Top'),
                  _buildSelectPosition(OverlayPosition.bottom, 'Bottom'),
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
