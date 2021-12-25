import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/custom_textfiled.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/cores/utils/validator.dart';
import 'package:elite/features/e_queue/controllers/e_queu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EQueuePaymentPage extends StatelessWidget {
  const EQueuePaymentPage({Key? key}) : super(key: key);

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
              Align(
                child: CustomTextWidget(
                  'Select a payment method',
                  fontSize: sizerSp(18),
                  textColor: Colors.black,
                ),
              ),
              SizedBox(height: sizerSp(40)),
              Center(
                child: SvgPicture.asset(
                  'assets/images/cash.svg',
                  height: sizerSp(150),
                  width: sizerSp(200),
                ),
              ),
              SizedBox(height: sizerSp(60)),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomTextWidget(
                    'Ride Fee:',
                    fontSize: sizerSp(16),
                    textColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  CustomTextWidget(
                    'NGN 80',
                    fontSize: sizerSp(16),
                    textColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomTextWidget(
                    'Service Fee:',
                    fontSize: sizerSp(16),
                    textColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  CustomTextWidget(
                    'NGN 20',
                    fontSize: sizerSp(16),
                    textColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomTextWidget(
                    'Total Fee:',
                    fontSize: sizerSp(16),
                    textColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  CustomTextWidget(
                    'NGN 100',
                    fontSize: sizerSp(16),
                    textColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
              const Divider(),
              SizedBox(height: sizerSp(20)),
              CustomTextWidget(
                'The Ride fee is only deducted from your wallet, after you'
                ' have gotten your ride. The Service fee is charged upfront ',
                fontSize: sizerSp(15),
                textColor: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(height: sizerSp(10)),
              CustomTextField(
                hintText: 'Enter Wallet Pin',
                textEditingController: eQueueController.walletPinController,
                textInputType: TextInputType.number,
                validator: (String? value) => pinValidator(value),
              ),
              const Spacer(),
              Obx(() {
                if (eQueueController.joiningQueueState.value ==
                    ControllerState.busy) {
                  return const CustomButton.loading();
                }

                return CustomButton(
                  text: 'Confirm',
                  onTap: () {
                    final String pin =
                        eQueueController.walletPinController.text;
                    if (pin.trim().length >= 4) {
                      eQueueController.joinQueue();
                    }
                  },
                );
              }),
              SizedBox(height: sizerSp(20)),
            ],
          ),
        ),
      ),
    );
  }
}
