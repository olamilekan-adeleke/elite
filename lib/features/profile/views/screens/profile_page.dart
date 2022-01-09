import 'dart:io';

import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_textfiled.dart';
import 'package:elite/cores/components/image_widget.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static final ProfileController profileController =
      Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        profileController.clearData();
        return true;
      },
      child: CustomScaffoldWidget(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: sizerHeight(85),
            child: Column(
              children: <Widget>[
                SizedBox(height: sizerSp(20)),
                Obx(() {
                  return GestureDetector(
                    onTap: () => profileController.pickImage(),
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
                                child: profileController.filePath.isEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CustomImageWidget(
                                          imageUrl: profileController
                                                  .userDetailsModel
                                                  ?.value
                                                  .profilePicUrl ??
                                              '',
                                          imageTypes: ImageTypes.profile,
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          File(
                                              profileController.filePath.value),
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

                ///

                SizedBox(height: sizerSp(40)),
                // CustomTextField(
                //   hintText: 'Full name',
                //   textEditingController: profileController.fullNameController
                //   textInputType: TextInputType.name,
                // ),
                // SizedBox(height: sizerSp(20)),
                CustomTextField(
                  hintText: 'Username',
                  textEditingController: profileController.usernameController,
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: sizerSp(20)),
                CustomTextField(
                  hintText: 'Phone number',
                  textEditingController: profileController.phoneController,
                  textInputType: TextInputType.number,
                  // validator: (String? value) =>
                  //     formFieldValidator(value, 'number', 10),
                ),
                const Spacer(),
                Obx(() {
                  if (profileController.state.value == ControllerState.busy) {
                    return const CustomButton.loading();
                  }

                  return CustomButton(
                    text: 'Update',
                    onTap: () => profileController.updateUserData(),
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
