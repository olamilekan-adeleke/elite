import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/navigator_service.dart';
import 'package:elite/cores/utils/route_name.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/cores/utils/validator.dart';
import 'package:elite/features/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/custom_textfiled.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  static final LoginControllers loginControllers = Get.find<LoginControllers>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: sizerSp(60)),
            SizedBox(height: sizerSp(20)),
            CustomTextWidget(
              'Login',
              fontWeight: FontWeight.w700,
              fontSize: sizerSp(30),
            ),
            CustomTextWidget(
              'Welcome Back!\nLogin to your account',
              fontWeight: FontWeight.w200,
              fontSize: sizerSp(14),
            ),
            SizedBox(height: sizerSp(20)),
            // Center(
            //   child: SvgPicture.asset(
            //     'assets/images/login.svg',
            //     height: sizerSp(100),
            //     width: sizerSp(150),
            //   ),
            // ),
            // SizedBox(height: sizerSp(40)),
            CustomTextField(
              hintText: 'Email',
              textEditingController: loginControllers.emailController,
              textInputType: TextInputType.emailAddress,
              validator: (String? value) =>
                  formFieldValidator(value, 'email', 3),
            ),
            SizedBox(height: sizerSp(10)),
            CustomTextField(
              hintText: 'Password',
              isPassword: true,
              textEditingController: loginControllers.passwordController,
              validator: (String? value) =>
                  formFieldValidator(value, 'password', 5),
            ),
            SizedBox(height: sizerSp(10)),
            GestureDetector(
              onTap: () => NavigationService.navigateTo(RouteName.signup),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextWidget(
                    // ignore: avoid_escaping_inner_quotes
                    'Don\'t have an account? ',
                    fontWeight: FontWeight.w200,
                    fontSize: sizerSp(13),
                  ),
                  CustomTextWidget(
                    'Sign Up Here',
                    fontWeight: FontWeight.w200,
                    fontSize: sizerSp(13),
                    textColor: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(height: sizerSp(40)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () =>
                      NavigationService.navigateTo(RouteName.forgotPassword),
                  child: CustomTextWidget(
                    'Forgot Password?',
                    fontWeight: FontWeight.w200,
                    fontSize: sizerSp(12),
                    textColor: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: sizerSp(40)),
            Obx(() {
              if (loginControllers.controllerStateEnum ==
                  ControllerStateEnum.busy) {
                return const CustomButton.loading();
              }
              return CustomButton(
                text: 'Login',
                onTap: () => loginControllers.loginUser(),
              );
            }),
            SizedBox(height: sizerSp(20)),
          ],
        ),
      ),
    );
  }
}
