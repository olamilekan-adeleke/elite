import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/utils/emums.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../controller/transfer_controller.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  static TransferController transferController = Get.find<TransferController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        transferController.clearData();
        return true;
      },
      child: CustomScaffoldWidget(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: sizerSp(20)),
            Center(
              child: SvgPicture.asset(
                'assets/images/transfer.svg',
                height: sizerSp(120),
                width: sizerSp(180),
              ),
            ),
            SizedBox(height: sizerSp(40)),
            CustomTextWidget(
              'Transfer',
              fontSize: sizerSp(22),
              fontWeight: FontWeight.bold,
            ),
            CustomTextWidget(
              'Send Naira or Coin to friends',
              fontSize: sizerSp(20),
              fontWeight: FontWeight.w300,
            ),
            SizedBox(height: sizerSp(20)),
            CustomTextWidget(
              'Select',
              fontSize: sizerSp(18),
              fontWeight: FontWeight.w500,
            ),
            Obx(
              () {
                return DropdownButton<String>(
                  value: transferController.type.value,
                  items: transferController.typeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? val) =>
                      transferController.updateType(val),
                  isExpanded: true,
                );
              },
            ),
            SizedBox(height: sizerSp(10)),
            CustomTextWidget(
              'Amount',
              fontSize: sizerSp(18),
              fontWeight: FontWeight.w500,
            ),
            CustomTextField(
              hintText: '100',
              textEditingController: transferController.amountController,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: sizerSp(10)),
            CustomTextWidget(
              'Receiver Username',
              fontSize: sizerSp(18),
              fontWeight: FontWeight.w500,
            ),
            CustomTextField(
              hintText: '@kod-x',
              textEditingController: transferController.usernameController,
              textInputType: TextInputType.name,
            ),
            SizedBox(height: sizerSp(10)),
            CustomTextWidget(
              'Wallet Pin',
              fontSize: sizerSp(18),
              fontWeight: FontWeight.w500,
            ),
            CustomTextField(
              hintText: 'xxxx',
              textEditingController: transferController.pinController,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: sizerSp(10)),
            CustomTextWidget(
              'Received as',
              fontSize: sizerSp(18),
              fontWeight: FontWeight.w500,
            ),
            Obx(
              () {
                return DropdownButton<String>(
                  value: transferController.type.value,
                  items: transferController.typeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? val) =>
                      transferController.updateReceivedAs(val),
                  isExpanded: true,
                );
              },
            ),
            SizedBox(height: sizerSp(30)),
            Obx(() {
              if (transferController.state.value == ControllerState.busy) {
                return const CustomButton.loading();
              }
              return CustomButton(
                text: 'Proceed',
                onTap: () => transferController.proceed(),
              );
            }),
            SizedBox(height: sizerSp(20)),
          ],
        ),
      ),
    );
  }
}
