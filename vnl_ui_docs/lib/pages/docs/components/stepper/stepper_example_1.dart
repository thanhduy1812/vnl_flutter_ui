import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class StepperExample1 extends StatefulWidget {
  const StepperExample1({super.key});

  @override
  State<StepperExample1> createState() => _StepperExample1State();
}

class _StepperExample1State extends State<StepperExample1> {
  final VNLStepperController controller = VNLStepperController();

  @override
  Widget build(BuildContext context) {
    return VNLStepper(
      controller: controller,
      // Vertical layout with 3 steps and Next/Prev actions.
      direction: Axis.vertical,
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
                      // Advance to the next step.
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
          contentBuilder: (context) {
            return VNLStepContainer(
              actions: [
                VNLSecondaryButton(
                  child: const Text('Prev'),
                  onPressed: () {
                    // Move back one step.
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
    );
  }
}
