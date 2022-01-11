import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/validator.dart';
import '../../controllers/e_queu_controller.dart';
import 'e_queue_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class JoinQueueWidget extends StatelessWidget {
  const JoinQueueWidget({Key? key}) : super(key: key);

  static EQueueController eQueueController = Get.find<EQueueController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: sizerHeight(90),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: sizerSp(20)),
            CustomTextWidget(
              'E-queue',
              fontSize: sizerSp(18),
              textColor: Colors.black,
            ),
            SizedBox(height: sizerSp(40)),
            Center(
              child: SvgPicture.asset(
                'assets/images/read.svg',
                height: sizerSp(150),
                width: sizerSp(200),
              ),
            ),
            SizedBox(height: sizerSp(60)),
            CustomTextWidget(
              'Stay busy with your favorite things while you await your ride',
              fontSize: sizerSp(16),
              textColor: Colors.black,
              fontWeight: FontWeight.w300,
            ),
            SizedBox(height: sizerSp(20)),
            CustomTextWidget(
              'Input your number of seats',
              fontSize: sizerSp(18),
              textColor: Colors.black,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: sizerSp(20)),
            CustomTextField(
              hintText: 'Number of Seat(s)',
              textEditingController: eQueueController.seatController,
              textInputType: TextInputType.number,
              validator: (String? value) => seatNumberValidator(value),
            ),
            SizedBox(height: sizerSp(50)),
            CustomButton(
              text: 'Continue',
              onTap: () {
                final String seatNo = eQueueController.seatController.text;
                if (seatNo.isNotEmpty &&
                    int.parse(seatNo) > 0 &&
                    int.parse(seatNo) <= 5) {
                  Get.to(() => const EQueuePaymentPage());
                }
              },
            ),
            SizedBox(height: sizerSp(20)),
          ],
        ),
      ),
    );
  }
}
