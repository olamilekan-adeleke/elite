import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/auth/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SetWalletPinScreen extends StatelessWidget {
  const SetWalletPinScreen({Key? key}) : super(key: key);

  static final RegisterController registerController =
      Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: ListView(
        children: [
          SizedBox(height: sizerSp(30)),
          Center(
            child: SvgPicture.asset(
              'assets/images/wallet.svg',
              height: sizerSp(100),
              width: sizerSp(150),
            ),
          ),
          SizedBox(height: sizerSp(40)),
          CustomTextWidget(
            'Wallet Setup',
            fontWeight: FontWeight.w600,
            fontSize: sizerSp(18),
          ),
          CustomTextWidget(
            'All transactions shall be made via your wallet',
            fontWeight: FontWeight.w300,
            fontSize: sizerSp(13),
          ),
          SizedBox(height: sizerSp(30)),
          CustomTextWidget(
            'Create your wallet PIN',
            fontWeight: FontWeight.w600,
            fontSize: sizerSp(18),
          ),
          PinFieldAutoFill(
            codeLength: 4,
            decoration: UnderlineDecoration(
              textStyle: const TextStyle(fontSize: 20, color: Colors.black),
              colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
            ),
            onCodeChanged: (String? code) {
              if (code!.length == 6) {
                FocusScope.of(context).requestFocus(FocusNode());
              }

              registerController.smsCodeController.text = code;
            },
          ),
        ],
      ),
    );
  }
}
