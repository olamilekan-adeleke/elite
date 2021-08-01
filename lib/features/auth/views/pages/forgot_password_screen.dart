import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/custom_textfiled.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/auth/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen();

  static final ForgotPasswordController forgotPasswordController =
      Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomTextWidget('', fontWeight: FontWeight.w700),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextWidget(
              'Reset Password',
              fontWeight: FontWeight.w700,
              fontSize: sizerSp(30),
            ),
            CustomTextWidget(
              'Did You Forgot Your Password?\nEnter Your Email Below,'
              ' A Link Will Be Sent To That Email',
              fontWeight: FontWeight.w200,
              fontSize: sizerSp(12),
            ),
            SizedBox(height: sizerSp(20)),
            Center(
              child: SvgPicture.asset(
                'assets/images/forgot_password.svg',
                height: sizerSp(100),
                width: sizerSp(150),
              ),
            ),
            SizedBox(height: sizerSp(20)),
            CustomTextField(
              hintText: 'Email',
              textEditingController: forgotPasswordController.emailController,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: sizerSp(80)),
            Obx(() {
              if (forgotPasswordController.controllerStateEnum ==
                  ControllerStateEnum.busy) {
                return const CustomButton.loading();
              }

              return CustomButton(
                text: 'Send',
                onTap: () => forgotPasswordController.sendEmail(),
              );
            }),
            SizedBox(height: sizerSp(20)),
          ],
        ),
      ),
    );
  }
}
