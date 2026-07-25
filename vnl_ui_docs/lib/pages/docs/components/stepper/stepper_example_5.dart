import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:vnl_common_ui/vnl_ui.dart';

class StepperExample5 extends StatefulWidget {
  const StepperExample5({super.key});

  @override
  State<StepperExample5> createState() => _StepperExample5State();
}

class _StepperExample5State extends State<StepperExample5> {
  final VNLStepperController controller = VNLStepperController();

  @override
  Widget build(BuildContext context) {
    return VNLStepper(
      controller: controller,
      direction: Axis.horizontal,
      steps: [
        VNLStep(
          title: const Text('VNLStep 1'),
          icon: const VNLStepNumber(
            // You can customize the step icon, e.g., use a person icon.
            icon: Icon(Icons.person),
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
          icon: const VNLStepNumber(
            // Another custom icon for the second step.
            icon: Icon(Icons.house_outlined),
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
          icon: const VNLStepNumber(
            // And a briefcase icon for the third.
            icon: Icon(Icons.work_outline),
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
