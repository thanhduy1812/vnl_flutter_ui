import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class StepperExample4 extends StatefulWidget {
  const StepperExample4({super.key});

  @override
  State<StepperExample4> createState() => _StepperExample4State();
}

class _StepperExample4State extends State<StepperExample4> {
  final VNLStepperController controller = VNLStepperController();

  @override
  Widget build(BuildContext context) {
    return VNLStepper(
      controller: controller,
      direction: Axis.vertical,
      steps: [
        VNLStep(
          title: const Text('VNLStep 1'),
          icon: VNLStepNumber(
            onPressed: () {
              // Tap on the step icon to jump directly to the step.
              controller.jumpToStep(0);
            },
          ),
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
          title: const Text('VNLStep 2'),
          icon: VNLStepNumber(
            onPressed: () {
              controller.jumpToStep(1);
            },
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
          icon: VNLStepNumber(
            onPressed: () {
              controller.jumpToStep(2);
            },
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
    );
  }
}
