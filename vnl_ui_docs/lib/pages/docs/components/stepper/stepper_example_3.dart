import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class StepperExample3 extends StatefulWidget {
  const StepperExample3({super.key});

  @override
  State<StepperExample3> createState() => _StepperExample3State();
}

class _StepperExample3State extends State<StepperExample3> {
  final VNLStepperController controller = VNLStepperController(
    stepStates: {
      1: VNLStepState.failed,
    },
    currentStep: 1,
  );

  @override
  Widget build(BuildContext context) {
    return VNLStepper(
      controller: controller,
      direction: Axis.horizontal,
      steps: [
        VNLStep(
          title: const Text('VNLStep 1'),
          contentBuilder: (context) {
            return const VNLStepContainer(
              actions: [
                VNLSecondaryButton(
                  child: Text('Prev'),
                ),
                VNLPrimaryButton(
                  child: Text('Next'),
                ),
              ],
              child: NumberedContainer(
                index: 1,
                height: 200,
              ),
            );
          },
        ),
        VNLStep(
          title: const Text('VNLStep 2'),
          contentBuilder: (context) {
            return const VNLStepContainer(
              actions: [
                VNLSecondaryButton(
                  child: Text('Prev'),
                ),
                VNLPrimaryButton(
                  child: Text('Next'),
                ),
              ],
              child: NumberedContainer(
                index: 2,
                height: 200,
              ),
            );
          },
        ),
        VNLStep(
          title: const Text('VNLStep 3'),
          contentBuilder: (context) {
            return const VNLStepContainer(
              actions: [
                VNLSecondaryButton(
                  child: Text('Prev'),
                ),
                VNLPrimaryButton(
                  child: Text('Finish'),
                ),
              ],
              child: NumberedContainer(
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
