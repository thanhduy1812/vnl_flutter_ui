import 'package:flutter/foundation.dart';
import 'package:vnl_common_ui/shadcn_flutter.dart';

// Shows how to open a contextual popover anchored to a button, with a custom
// overlay barrier and a simple form inside. The popover closes via
// closeOverlay(context) or when the user taps outside the barrier.

class PopoverExample1 extends StatelessWidget {
  const PopoverExample1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return VNLPrimaryButton(
      onPressed: () {
        showPopover(
          context: context,
          // Position the popover above the button, shifted by 8px.
          alignment: Alignment.topCenter,
          offset: const Offset(0, 8),
          // Unless you have full opacity surface,
          // you should explicitly set the overlay barrier.
          overlayBarrier: VNLOverlayBarrier(
            borderRadius: theme.borderRadiusLg,
          ),
          builder: (context) {
            return VNLModalContainer(
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Dimensions').large().medium(),
                    const Text('Set the dimensions for the layer.').muted(),
                    VNLForm(
                      controller: VNLFormController(),
                      // Compact grid layout for label/field rows.
                      child: const VNLFormTableLayout(
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
                        // Close the popover and resolve the returned future.
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
          // Optional completion hook after the popover is dismissed.
          if (kDebugMode) {
            print('VNLPopover closed');
          }
        });
      },
      child: const Text('Open popover'),
    );
  }
}
