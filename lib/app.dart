import 'package:elite/features/home/binding/home_bindings.dart';
import 'package:elite/features/profile/bindings/profile_binding.dart';
import 'package:elite/features/wallet/bindings/wallet_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'cores/constants/color.dart';
import 'cores/utils/route_name.dart';
import 'features/auth/binding/auth_binding.dart';
import 'features/auth/views/pages/forgot_password_screen.dart';
import 'features/auth/views/pages/login_screen.dart';
import 'features/auth/views/pages/set_wallet_pin_screen.dart';
import 'features/auth/views/pages/signup_screen.dart';
import 'features/auth/views/pages/sms_verification_screen.dart';
import 'features/auth/views/pages/update_profile_screen.dart';
import 'features/auth/views/pages/wrapper.dart';
import 'features/home/views/screens/home_screen.dart';
import 'features/notification/views/screens/notification_screem.dart';
import 'features/profile/views/screens/profile_page.dart';
import 'features/wallet/views/screen/confirm_transfer.dart';
import 'features/wallet/views/screen/transfer_screen.dart';
import 'features/wallet/views/screen/wallet_screen.dart';

class EliteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (_, __, ___) {
      return GetMaterialApp(
        enableLog: true,
        defaultTransition: Transition.cupertino,
        opaqueRoute: Get.isOpaqueRouteDefault,
        popGesture: Get.isPopGestureEnable,
        title: '1go',
        theme: ThemeData(
          primaryColor: kcPrimaryColor,
          backgroundColor: const Color(0xffECE8E8),
        ),
        initialRoute: RouteName.login,
        getPages: pages(),
        initialBinding: AuthenticationBinding(),
      );
    });
  }
}

List<GetPage<dynamic>>? pages() {
  return <GetPage<dynamic>>[
    GetPage<Widget>(
      page: () => const WrapperScreen(),
      name: '/',
    ),
    GetPage<Widget>(
      page: () => const LoginScreen(),
      name: RouteName.login,
    ),
    GetPage<Widget>(
      page: () => const SignUpScreen(),
      name: RouteName.signUp,
    ),
    GetPage<Widget>(
      page: () => const ForgotPasswordScreen(),
      name: RouteName.forgotPassword,
    ),
    GetPage<Widget>(
      page: () => const NotificationScreen(),
      name: RouteName.notificationScreen,
    ),
    GetPage<Widget>(
      page: () => const SmsVerificationScreen(),
      name: RouteName.smsCode,
    ),
    GetPage<Widget>(
      page: () => const UpdateProfilePicScreen(),
      name: '/update-profile',
    ),
    GetPage<Widget>(
      page: () => const CreateWalletPinScreen(),
      name: '/create-wallet-pin',
    ),
    GetPage<Widget>(
      page: () => const ProfileScreen(),
      name: '/profile',
    ),
    GetPage<Widget>(
      page: () => const WalletScreen(),
      name: '/wallet',
    ),
     GetPage<Widget>(
      page: () => const TransferScreen(),
      name: '/transfer',
    ),
    GetPage<Widget>(
      page: () => const ConfirmTransferScreen(),
      name: '/confirm-transfer',
    ),
    GetPage<Widget>(
      page: () => const HomeScreen(),
      name: '/home',
      bindings: <Bindings>[
        HomeBinding(),
        ProfileBindings(),
        WalletBinding(),
      ],
    ),
  ];
}
