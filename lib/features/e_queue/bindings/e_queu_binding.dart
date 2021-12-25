import 'package:elite/features/e_queue/controllers/e_queu_controller.dart';
import 'package:get/get.dart';

class EQueueBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EQueueController>(EQueueController());
  }
}
