import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
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
      body: ListView(
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
          CircleAvatar(
            radius: sizerSp(50),
            
          ),
        ],
      ),
    );
  }
}
