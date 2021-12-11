import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
  }
}
