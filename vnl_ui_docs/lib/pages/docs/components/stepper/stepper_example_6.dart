import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class StepperExample6 extends StatefulWidget {
  const StepperExample6({super.key});

  @override
  State<StepperExample6> createState() => _StepperExample6State();
}

class _StepperExample6State extends State<StepperExample6> {
  static const List<VNLStepVariant> _variants = [
    VNLStepVariant.circle,
    VNLStepVariant.circleAlt,
    VNLStepVariant.line,
  ];
  static const List<String> _variantNames = [
    'Circle',
    'Circle Alt',
    'Line',
  ];
  static const List<VNLStepSize> _stepSize = VNLStepSize.values;
  static const List<String> _stepSizeNames = [
    'Small',
    'Medium',
    'Large',
  ];
  final VNLStepperController controller = VNLStepperController();
  int _currentVariant = 0;
  int _currentStepSize = 0;
  Axis direction = Axis.horizontal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            VNLToggle(
              value: direction == Axis.horizontal,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    direction = Axis.horizontal;
                  });
                } else {
                  setState(() {
                    direction = Axis.vertical;
                  });
                }
              },
              child: const Text('Horizontal'),
            ),
            VNLToggle(
              value: direction == Axis.vertical,
              onChanged: (value) {
                if (value) {
                  setState(() {
                    direction = Axis.vertical;
                  });
                } else {
                  setState(() {
                    direction = Axis.horizontal;
                  });
                }
              },
              child: const Text('Vertical'),
            ),
            const VNLVerticalDivider().sized(height: 16),
            for (var i = 0; i < _variants.length; i++)
              VNLToggle(
                value: _currentVariant == i,
                onChanged: (value) {
                  setState(() {
                    // Choose among visual variants (circle, alt circle, line).
                    _currentVariant = i;
                  });
                },
                child: Text(_variantNames[i]),
              ),
            const VNLVerticalDivider().sized(height: 16),
            for (var i = 0; i < _stepSize.length; i++)
              VNLToggle(
                value: _currentStepSize == i,
                onChanged: (value) {
                  setState(() {
                    // Pick the step size used by the VNLStepper.
                    _currentStepSize = i;
                  });
                },
                child: Text(_stepSizeNames[i]),
              ),
            const VNLVerticalDivider().sized(height: 16),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return VNLToggle(
                  value: controller.value.stepStates[1] == VNLStepState.failed,
                  onChanged: (value) {
                    if (value) {
                      // Mark step 2 as failed to demo error state.
                      controller.setStatus(1, VNLStepState.failed);
                    } else {
                      controller.setStatus(1, null);
                    }
                  },
                  child: const Text('VNLToggle Error'),
                );
              },
            ),
          ],
        ),
        const Gap(16),
        VNLStepper(
          controller: controller,
          direction: direction,
          // Apply the chosen size and visual variant.
          size: _stepSize[_currentStepSize],
          variant: _variants[_currentVariant],
          steps: [
            VNLStep(
              title: const Text('VNLStep 1'),
              contentBuilder: (context) {
                return VNLStepContainer(
                  actions: [
                    const VNLSecondaryButton(
                      child: Text('Prev'),
                    ),
                    VNLPrimaryButton(
                        child: const Text('Next'),
                        onPressed: () {
                          controller.nextStep();
                        }),
                  ],
                  child: const NumberedContainer(
                    index: 1,
                    height: 200,
                  ),
                );
              },
            ),
            VNLStep(
              title: const VNLStepTitle(
                title: Text('VNLStep 2'),
                subtitle: Text('Optional VNLStep'),
              ),
              contentBuilder: (context) {
                return VNLStepContainer(
                  actions: [
                    VNLSecondaryButton(
                      child: const Text('Prev'),
                      onPressed: () {
                        controller.previousStep();
                      },
                    ),
                    VNLPrimaryButton(
                        child: const Text('Next'),
                        onPressed: () {
                          controller.nextStep();
                        }),
                  ],
                  child: const NumberedContainer(
                    index: 2,
                    height: 200,
                  ),
                );
              },
            ),
            VNLStep(
              title: const Text('VNLStep 3'),
              contentBuilder: (context) {
                return VNLStepContainer(
                  actions: [
                    VNLSecondaryButton(
                      child: const Text('Prev'),
                      onPressed: () {
                        controller.previousStep();
                      },
                    ),
                    VNLPrimaryButton(
                        child: const Text('Finish'),
                        onPressed: () {
                          controller.nextStep();
                        }),
                  ],
                  child: const NumberedContainer(
                    index: 3,
                    height: 200,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
