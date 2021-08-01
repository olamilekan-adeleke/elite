import 'package:elite/cores/utils/local_database_repo.dart';
import 'package:elite/features/auth/controllers/auth_state_controller.dart';
import 'package:elite/features/auth/controllers/forgot_password_controller.dart';
import 'package:elite/features/auth/controllers/login_controller.dart';
import 'package:elite/features/auth/controllers/register_controller.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:get/instance_manager.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LocaldatabaseRepo>(LocaldatabaseRepo());
    Get.put<AuthenticationRepo>(AuthenticationRepo());
    Get.put<AuthStateController>(AuthStateController());
    Get.put<RegisterController>(RegisterController());
    Get.put<LoginControllers>(LoginControllers());
    Get.put<ForgotPasswordController>(ForgotPasswordController());
  }
}
