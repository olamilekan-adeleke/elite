import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/cores/utils/validator.dart';
import 'package:elite/features/auth/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/custom_textfiled.dart';
import '../../../../cores/utils/emums.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen();

  static final RegisterController registerController =
      Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: sizerSp(20)),
          CustomTextWidget(
            'Sign Up',
            fontWeight: FontWeight.w700,
            fontSize: sizerSp(30),
          ),
          CustomTextWidget(
            'Welcome To 1go!\nFill the form below to create an account',
            fontWeight: FontWeight.w200,
            fontSize: sizerSp(14),
          ),
          SizedBox(height: sizerSp(20)),
          Center(
            child: SvgPicture.asset(
              'assets/images/signup.svg',
              height: sizerSp(100),
              width: sizerSp(150),
            ),
          ),
          SizedBox(height: sizerSp(40)),
          Row(
            children: <Widget>[
              Expanded(
                child: CustomTextField(
                  hintText: 'Firstname',
                  textEditingController: registerController.firstnameController,
                  validator: (String? value) =>
                      formFieldValidator(value, 'Firstname', 3),
                ),
              ),
              SizedBox(width: sizerSp(3)),
              Expanded(
                child: CustomTextField(
                  hintText: 'Lastname',
                  textEditingController: registerController.lastnameController,
                  validator: (String? value) =>
                      formFieldValidator(value, 'Lastname', 3),
                ),
              ),
            ],
          ),
          SizedBox(height: sizerSp(10)),
          CustomTextField(
            hintText: 'Email',
            textEditingController: registerController.emailController,
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(height: sizerSp(10)),
          CustomTextField(
            hintText: 'Username',
            textEditingController: registerController.usernameController,
            textInputType: TextInputType.name,
          ),
          SizedBox(height: sizerSp(10)),
          CustomTextField(
            hintText: 'Phone number',
            textEditingController: registerController.phoneController,
            textInputType: TextInputType.number,
            validator: (String? value) =>
                formFieldValidator(value, 'number', 10),
          ),
          SizedBox(height: sizerSp(10)),
          CustomTextField(
            hintText: 'Password',
            textEditingController: registerController.passwordController,
            isPassword: true,
            validator: (String? value) =>
                formFieldValidator(value, 'password', 5),
          ),
          SizedBox(height: sizerSp(10)),
          CustomTextField(
            hintText: 'Confirm Password',
            textEditingController: registerController.confirmPasswordController,
            isPassword: true,
            validator: (String? value) =>
                formFieldValidator(value, 'Confirm Password', 5),
          ),
          SizedBox(height: sizerSp(40)),
          Obx(() {
            if (registerController.controllerStateEnum ==
                ControllerState.busy) {
              return const CustomButton.loading();
            }

            return CustomButton(
              text: 'Sign Up',
              onTap: () => registerController.registerUser(),
            );
          }),
          SizedBox(height: sizerSp(20)),
          GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextWidget(
                  'Already have an account? ',
                  fontWeight: FontWeight.w200,
                  fontSize: sizerSp(13),
                ),
                CustomTextWidget(
                  'LogIn',
                  fontWeight: FontWeight.w200,
                  fontSize: sizerSp(13),
                  textColor: Colors.blue,
                ),
              ],
            ),
          ),
          SizedBox(height: sizerSp(30)),
        ],
      ),
    );
  }
}
