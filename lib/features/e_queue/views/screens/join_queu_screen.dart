import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/custom_textfiled.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/cores/utils/validator.dart';
import 'package:elite/features/e_queue/controllers/e_queu_controller.dart';
import 'package:elite/features/e_queue/views/screens/e_queue_payment_screen.dart';
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: sizerHeight(90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizerSp(20)),
              CustomTextField(
                hintText: 'Number of Seat(s)',
                textEditingController: eQueueController.phoneController,
                textInputType: TextInputType.number,
                validator: (String? value) => seatNumberValidator(value),
              ),
              // CustomTextWidget(
              //   'You can queue with up to 5 seats',
              //   fontSize: sizerSp(13),
              //   textColor: Colors.black,
              //   fontWeight: FontWeight.w200,
              // ),
              const Spacer(),
              CustomButton(
                text: 'Continue',
                onTap: () {
                  final String seatNo = eQueueController.phoneController.text;
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
      ),
    );
  }
}
