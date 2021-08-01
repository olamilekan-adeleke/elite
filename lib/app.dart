import 'package:elite/cores/constants/color.dart';
import 'package:elite/features/auth/views/pages/forgot_password_screen.dart';
import 'package:elite/features/auth/views/pages/login_screen.dart';
import 'package:elite/features/auth/views/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'cores/utils/route_name.dart';
import 'features/auth/views/pages/signup_screen.dart';

class EliteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, __, ___) {
      return GetMaterialApp(
        enableLog: true,
        defaultTransition: Transition.cupertino,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        title: 'Elite',
        theme: ThemeData(
          primaryColor: kcPrimaryColor,
          backgroundColor: const Color(0xffE8E7E5),
        ),
        home: const WrapperScreen(),
        getPages: pages(),
      );
    });
  }
}

List<GetPage<dynamic>>? pages() {
  return <GetPage<dynamic>>[
    GetPage<Widget>(
      page: () => const LoginScreen(),
      name: RouteName.login,
    ),
    GetPage<Widget>(
      page: () => const SignupScreen(),
      name: RouteName.signup,
    ),
    GetPage<Widget>(
      page: () => const ForgotPasswordScreen(),
      name: RouteName.forgotPassword,
    ),
  ];
}
