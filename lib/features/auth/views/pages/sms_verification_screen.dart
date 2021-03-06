import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/custom_textfiled.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/auth/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  static final RegisterController registerController =
      Get.find<RegisterController>();

  @override
  void initState() {
    registerController.sendSms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: sizerSp(60)),
          CustomTextWidget(
            'Enter Your code',
            fontWeight: FontWeight.w700,
            fontSize: sizerSp(30),
          ),
          CustomTextWidget(
            // ignore: lines_longer_than_80_chars
            'An SMS code was sent to ${registerController.getFormattedPhoneNumber()}',
            fontWeight: FontWeight.w200,
            fontSize: sizerSp(14),
          ),
          SizedBox(height: sizerSp(50)),
          // PinFieldAutoFill(
          //   controller: registerController.smsCodeController,
          //   decoration: UnderlineDecoration(
          //     textStyle: const TextStyle(fontSize: 20, color: Colors.black),
          //     colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
          //   ),
          //   onCodeChanged: (String? code) {
          //     if (code!.length == 6) {
          //       FocusScope.of(context).requestFocus(FocusNode());
          //     }

          //     registerController.smsCodeController.text = code;
          //   },
          // ),
          CustomTextField(
            hintText: 'Sms OTP',
            textEditingController: registerController.smsCodeController,
            textInputType: TextInputType.number,
            // onChanged: (String? code) {
            // if (code!.length == 6) {
            //   FocusScope.of(context).requestFocus(FocusNode());
            // }

            // registerController.smsCodeController.text = code;
            // },
          ),
          SizedBox(height: sizerSp(20)),
          GestureDetector(
            onTap: () => registerController.sendSms(),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    'Resend Code',
                    fontWeight: FontWeight.w200,
                    fontSize: sizerSp(14),
                    textColor: Colors.blue,
                  ),
                  registerController.resendOtpState.value ==
                          ControllerState.busy
                      ? SizedBox(
                          height: sizerSp(10),
                          width: sizerSp(10),
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        )
                      : Container(),
                ],
              );
            }),
          ),
          SizedBox(height: sizerSp(60)),
          Obx(() {
            if (registerController.smsState.value == ControllerState.busy) {
              return const CustomButton.loading();
            }
            return CustomButton(
              text: 'Confirm',
              onTap: () => registerController.signInWithPhoneNumber(),
            );
          }),
        ],
      ),
    );
  }
}
