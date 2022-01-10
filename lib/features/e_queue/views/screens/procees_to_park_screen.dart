import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../controllers/e_queu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProceedToPartScreen extends StatelessWidget {
  const ProceedToPartScreen({Key? key}) : super(key: key);

  static EQueueController eQueueController = Get.find<EQueueController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: sizerHeight(90),
        child: Column(
          children: <Widget>[
            SizedBox(height: sizerSp(50)),
            Padding(
              padding: EdgeInsets.all(sizerSp(10)),
              child: CustomTextWidget(
                'Please proceed to your terminal (${eQueueController.selectedTerminalText}) to get your ride',
                fontSize: sizerSp(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(sizerSp(10)),
              color: Colors.yellow.shade400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    'Please do this within the next 0 to 30mins to avoid withdrawal of your order',
                    fontSize: sizerSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10),
                  CustomTextWidget(
                    'Keep device location on. Always',
                    fontSize: sizerSp(15),
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(sizerSp(10)),
              child: CustomTextWidget(
                'When you are at the terminal, connect to the WIFI there to aid us connect you to your driver',
                fontSize: sizerSp(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(sizerSp(10)),
              child: CustomTextWidget(
                'To continue tap the `Next` button',
                fontSize: sizerSp(12),
                fontWeight: FontWeight.w300,
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Next',
              onTap: () => Get.to(() => ProceedToPartScreenTwo()),
            ),
          ],
        ),
      ),
    );
  }
}

class ProceedToPartScreenTwo extends StatelessWidget {
  const ProceedToPartScreenTwo({Key? key}) : super(key: key);

  static EQueueController eQueueController = Get.find<EQueueController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: sizerHeight(90),
        child: Column(
          children: <Widget>[
            SizedBox(height: sizerSp(50)),
            Padding(
              padding: EdgeInsets.all(sizerSp(10)),
              child: CustomTextWidget(
                'Terminal (${eQueueController.selectedTerminalText})',
                fontSize: sizerSp(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SvgPicture.asset(
                'assets/images/bus_stop.svg',
                height: sizerSp(100),
                width: sizerSp(150),
              ),
            ),
            SizedBox(height: sizerSp(40)),
            Padding(
              padding: EdgeInsets.all(sizerSp(10)),
              child: CustomTextWidget(
                'At the terminal and ready to go?',
                fontSize: sizerSp(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(sizerSp(10)),
              child: CustomTextWidget(
                'By tapping the “go” button, photo of your driver and description of the vehicle shall be sent to you for easy identification ',
                fontSize: sizerSp(12),
                fontWeight: FontWeight.w300,
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Go',
              onTap: () => showPopUp(),
            ),
          ],
        ),
      ),
    );
  }

  void showPopUp() {
    Get.defaultDialog(
      title: 'Please make sure you are at the terminal',
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomTextWidget(
          'By tapping the “go” button, photo of your driver and description of the vehicle shall be sent to you for easy identification ',
          fontSize: sizerSp(16),
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.center,
        ),
      ),
      actions: <Widget>[
        CustomButton(
          text: 'OK',
          onTap: () {},
        ),
      ],
    );
  }
}
