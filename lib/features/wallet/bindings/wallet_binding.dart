import '../controller/transfer_controller.dart';
import '../controller/wallet_controller.dart';
import 'package:get/get.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WalletController>(WalletController());
    Get.put<TransferController>(TransferController());
  }
}
