import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/custom_textfiled.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/cores/utils/validator.dart';
import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:elite/features/wallet/controller/wallet_controller.dart';
import 'package:elite/features/wallet/services/fund_wallet_servive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FundWalletScreen extends StatelessWidget {
  const FundWalletScreen({Key? key}) : super(key: key);

  static final WalletController _walletController =
      Get.find<WalletController>();

  static final ProfileController _profileController =
      Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: sizerSp(15.0)),
        color: Colors.white,
        child: SingleChildScrollView(
          child: SizedBox(
            height: sizerHeight(95),
            child: Column(
              children: <Widget>[
                AppBar(
                  iconTheme: const IconThemeData(color: Colors.black),
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: sizerSp(20)),
                CustomTextWidget(
                  'Fund Your Wallet Using Your Debit Card',
                  fontSize: sizerSp(18),
                  textColor: Colors.black,
                ),
                SizedBox(height: sizerSp(40)),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/transfer.svg',
                    height: sizerSp(150),
                    width: sizerSp(200),
                  ),
                ),
                SizedBox(height: sizerSp(60)),
                CustomTextField(
                  hintText: 'Amount',
                  textEditingController: _walletController.amountController,
                  textInputType: TextInputType.number,
                  validator: (String? value) =>
                      formFieldValidator(value, 'amount', 1),
                ),
                SizedBox(height: sizerSp(10)),
                // CustomTextWidget(
                //   'Use our online queuing feature(E-QUEUE) instead ',
                //   fontSize: sizerSp(14),
                //   textColor: Colors.black,
                //   fontWeight: FontWeight.w200,
                //   textAlign: TextAlign.left,
                // ),
                const Spacer(),
                Obx(() {
                  if (_walletController.fundWalletState.value ==
                      ControllerState.busy) {
                    return const CustomButton.loading();
                  }

                  return CustomButton(
                    text: 'Fund Wallet',
                    onTap: () => FundWalletService().chargeCard(
                      context: context,
                      price: int.parse(_walletController.amountController.text),
                      userEmail:
                          _profileController.userDetailsModel?.value.email ??
                              'test email',
                    ),
                  );
                }),
                SizedBox(height: sizerSp(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
