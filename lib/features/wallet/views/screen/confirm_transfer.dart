import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/image_widget.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/wallet/controller/transfer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmTransferScreen extends StatelessWidget {
  const ConfirmTransferScreen({Key? key}) : super(key: key);

  static TransferController transferController = Get.find<TransferController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(sizerSp(10)),
        child: Column(
          children: <Widget>[
            CustomTextWidget(
              'Confirm',
              fontSize: sizerSp(22),
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: sizerSp(30)),
            Align(
              child: SizedBox(
                height: sizerSp(60),
                width: sizerSp(60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(sizerSp(100)),
                  child: CustomImageWidget(
                    imageUrl: transferController
                            .receiverDetails?.value.profilePicUrl ??
                        '',
                    imageTypes: ImageTypes.network,
                  ),
                ),
              ),
            ),
            SizedBox(height: sizerSp(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomTextWidget(
                  'Name: ',
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w300,
                ),
                CustomTextWidget(
                  '${transferController.receiverDetails?.value.fullName}',
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: sizerSp(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomTextWidget(
                  'Username: ',
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w300,
                ),
                CustomTextWidget(
                  '${transferController.receiverDetails?.value.username}',
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: sizerSp(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomTextWidget(
                  'Sent as: ',
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w300,
                ),
                CustomTextWidget(
                  transferController.type.value,
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: sizerSp(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomTextWidget(
                  'Received As: ',
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w300,
                ),
                CustomTextWidget(
                  transferController.receivedAs.value,
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: sizerSp(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomTextWidget(
                  'Amount: ',
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w300,
                ),
                CustomTextWidget(
                  'NGN ${transferController.amountController.text}',
                  fontSize: sizerSp(15),
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const Spacer(),
            Obx(() {
              if (transferController.state.value == ControllerState.busy) {
                return const CustomButton.loading();
              }
              return CustomButton(
                text: 'Send',
                onTap: () => transferController.send(),
              );
            }),
            SizedBox(height: sizerSp(20)),
          ],
        ),
      ),
    );
  }
}
