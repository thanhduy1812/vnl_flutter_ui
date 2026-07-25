import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class StepperExample2 extends StatefulWidget {
  const StepperExample2({super.key});

  @override
  State<StepperExample2> createState() => _StepperExample2State();
}

class _StepperExample2State extends State<StepperExample2> {
  final VNLStepperController controller = VNLStepperController();

  @override
  Widget build(BuildContext context) {
    return VNLStepper(
      controller: controller,
      // Horizontal layout using the same 3-step flow.
      direction: Axis.horizontal,
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
          title: const Text('VNLStep 2'),
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
    );
  }
}
