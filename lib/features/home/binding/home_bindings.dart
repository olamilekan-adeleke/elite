import 'package:get/instance_manager.dart';

import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
