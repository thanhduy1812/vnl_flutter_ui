import 'package:vnl_common_ui/vnl_ui.dart';

class PopoverExample1 extends StatelessWidget {
  const PopoverExample1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = VNLTheme.of(context);
    return VNLPrimaryButton(
      onPressed: () {
        showPopover(
          context: context,
          alignment: Alignment.topCenter,
          offset: const Offset(0, 8),
          // Unless you have full opacity surface,
          // you should explicitly set the overlay barrier.
          overlayBarrier: OverlayBarrier(
            borderRadius: theme.borderRadiusLg,
          ),
          builder: (context) {
            return ModalContainer(
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Dimensions').large().medium(),
                    const Text('Set the dimensions for the layer.').muted(),
                    VNLForm(
                      controller: FormController(),
                      child: const FormTableLayout(
                        rows: [
                          FormField<double>(
                            key: FormKey(#width),
                            label: Text('Width'),
                            child: VNLTextField(
                              initialValue: '100%',
                            ),
                          ),
                          FormField<double>(
                            key: FormKey(#maxWidth),
                            label: Text('Max. Width'),
                            child: VNLTextField(
                              initialValue: '300px',
                            ),
                          ),
                          FormField<double>(
                            key: FormKey(#height),
                            label: Text('Height'),
                            child: VNLTextField(
                              initialValue: '25px',
                            ),
                          ),
                          FormField<double>(
                            key: FormKey(#maxHeight),
                            label: Text('Max. Height'),
                            child: VNLTextField(
                              initialValue: 'none',
                            ),
                          ),
                        ],
                        spacing: 8,
                      ),
                    ).withPadding(vertical: 16),
                    VNLPrimaryButton(
                      onPressed: () {
                        closeOverlay(context);
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            );
          },
        ).future.then((_) {
          print('Popover closed');
        });
      },
      child: const Text('Open popover'),
    );
  }
}
