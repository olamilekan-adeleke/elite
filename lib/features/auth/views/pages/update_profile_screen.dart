import 'dart:io';

import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/auth/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfilePicScreen extends StatelessWidget {
  const UpdateProfilePicScreen({Key? key}) : super(key: key);

  static final RegisterController registerController =
      Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.grey.shade900,
          size: sizerSp(20),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: sizerSp(60)),
          Align(
            child: CustomTextWidget(
              'Add Profile Picture',
              fontWeight: FontWeight.w300,
              fontSize: sizerSp(18),
            ),
          ),
          SizedBox(height: sizerSp(20)),
          Obx(() {
            return GestureDetector(
              onTap: () => registerController.pickImage(),
              child: Align(
                child: SizedBox(
                  width: sizerSp(100),
                  height: sizerSp(100),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          height: sizerSp(100),
                          width: sizerSp(100),
                          child: registerController.filePath.isEmpty
                              ? Icon(Icons.person, color: Colors.grey.shade400)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    File(registerController.filePath.value),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: sizerSp(5),
                          bottom: sizerSp(5),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          Obx(() {
            if (registerController.imageState.value == ControllerState.busy) {
              return const CustomButton.loading();
            }
            return Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Skip',
                    onTap: () => Get.offNamed('create-wallet-pin'),
                    color: Colors.grey.shade400,
                  ),
                ),
                SizedBox(width: sizerSp(20)),
                Expanded(
                  child: CustomButton(
                    text: 'Upload',
                    onTap: () => registerController.uploadImage(),
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: sizerSp(20)),
        ],
      ),
    );
  }
}
