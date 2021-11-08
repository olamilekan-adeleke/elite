import 'package:elite/features/auth/views/pages/set_wallet_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../controllers/auth_state_controller.dart';
import 'login_screen.dart';

class WrapperScreen extends StatelessWidget {
  const WrapperScreen();

  static final AuthStateController authStateController =
      Get.find<AuthStateController>();

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    //   if (authStateController.authStateEnum.value == AuthStateEnum.loggedIn) {
    //     return const HomeScreen();
    //   } else {
    //     return const LoginScreen();
    //   }
    // });

    return const SetWalletPinScreen();
  }
}
