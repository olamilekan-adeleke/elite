// ignore_for_file: always_specify_types

// import 'dart:developer';
import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/image_widget.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:elite/features/wallet/views/screen/fund_wallet%20screen.dart';
import 'package:elite/features/wallet/views/widgets/balance_widget.dart';
import 'package:elite/features/wallet/views/widgets/transaction_history_widegt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  static final ProfileController profileController =
      Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: SizedBox(
        height: sizerHeight(100),
        child: Column(
          children: <Widget>[
            SizedBox(height: sizerSp(20)),
            Row(
              children: <Widget>[
                CustomTextWidget(
                  'Wallet',
                  fontSize: sizerSp(20),
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                SizedBox(
                  height: sizerSp(40),
                  width: sizerSp(40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(sizerSp(100)),
                    child: CustomImageWidget(
                      imageUrl: profileController
                              .userDetailsModel?.value.profilePicUrl ??
                          '',
                      imageTypes: ImageTypes.profile,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            const CashWalletWidget(),
            SizedBox(height: sizerSp(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                  text: 'Fund Wallet',
                  onTap: () => Get.to(() => FundWalletScreen()),
                  width: sizerWidth(25),
                ),
                CustomButton(
                  text: 'Get Coins',
                  onTap: () {},
                  width: sizerWidth(25),
                ),
                CustomButton(
                  text: 'Transfer',
                  onTap: () => Get.toNamed('/transfer'),
                  width: sizerWidth(25),
                ),
              ],
            ),
            const Divider(),
            Expanded(child: TransactionHistoryWidget()),
          ],
        ),
      ),
    );
  }
}
