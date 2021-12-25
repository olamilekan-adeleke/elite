import 'dart:developer';

import 'package:elite/cores/utils/snack_bar_service.dart';
import 'package:elite/features/e_queue/model/terminal_model.dart';
import 'package:elite/features/e_queue/service/e_queue_service.dart';
import 'package:get/get.dart';

class EQueueController extends GetxController {
  static final EQueueService eQueueService = EQueueService();
  final RxList<TerminalModel> terminals = <TerminalModel>[].obs;
  final RxString selectedTerminal = ''.obs;

  Future<void> getTerminals() async {
    try {
      terminals.value = await eQueueService.getTerminals();
      log('terminals: ${terminals.value}');
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      showErrorSnackBar(e.toString());
    }
  }

  @override
  void onReady() {
    getTerminals();
    super.onReady();
  }
}
