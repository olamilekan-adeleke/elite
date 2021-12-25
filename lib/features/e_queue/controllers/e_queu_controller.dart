import 'dart:developer';

import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/cores/utils/snack_bar_service.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:elite/features/e_queue/model/queue_model.dart';
import 'package:elite/features/e_queue/model/terminal_model.dart';
import 'package:elite/features/e_queue/service/e_queue_service.dart';
import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EQueueController extends GetxController {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  static final ProfileController profileController =
      Get.find<ProfileController>();
  final TextEditingController seatController = TextEditingController();
  final TextEditingController walletPinController = TextEditingController();
  final Rx<ControllerState> joiningQueueState = ControllerState.init.obs;
  static final EQueueService eQueueService = EQueueService();
  final RxList<TerminalModel> terminals = <TerminalModel>[].obs;
  final RxString selectedTerminalText = ''.obs;
  Rx<TerminalModel>? selectedTerminalModel;

  void updateSelectedTerminal(String text) {
    final TerminalModel _selectedTerminalModel =
        terminals.firstWhere((TerminalModel terminal) => terminal.name == text);

    selectedTerminalText.value = _selectedTerminalModel.name;
    selectedTerminalModel = Rx<TerminalModel>(_selectedTerminalModel);

    log('Selected Terminal: $_selectedTerminalModel');

    // update list
  }

  Future<void> joinQueue() async {
    if (joiningQueueState.value == ControllerState.busy) return;

    try {
      joiningQueueState.value = ControllerState.busy;
      final bool checkPin = await authenticationRepo
          .validateUserPin(walletPinController.text.trim());

      if (checkPin) {
        if (profileController.userDetailsModel?.value == null) {
          throw 'Opps, Something went wrong. Could not add user to the queue!';
        }

        final QueueModel queueModel = QueueModel(
          user: profileController.userDetailsModel!.value,
          numberOfSeats: int.parse(seatController.text.trim()),
          isSentNotification: false,
        );

        await eQueueService.addToEQueue(
          selectedTerminalModel!.value.id,
          queueModel,
        );

        joiningQueueState.value = ControllerState.success;
        showPopUp();
      }
    } catch (e, s) {
      log('Error: $e', error: e, stackTrace: s);
      showErrorSnackBar(e.toString());
      joiningQueueState.value = ControllerState.error;
    }
  }

  Future<void> getTerminals() async {
    try {
      terminals.value = await eQueueService.getTerminals();
      // log('terminals: ${terminals.value}');
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      showErrorSnackBar(e.toString());
    }
  }

  void showPopUp() {
    Get.defaultDialog(
      title: 'Success',
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            CustomTextWidget(
              'You have been successfully added to the e-queue.',
              fontSize: sizerSp(15),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: sizerSp(10)),
            CustomTextWidget(
              'Your notification shall arrive in not more than 45 minutes. '
              'Once you get your notification, please proceed to your '
              'terminal(Pepsi village) to get your ride  ',
              fontSize: sizerSp(14),
              fontWeight: FontWeight.w300,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CustomButton(
          text: 'OK',
          onTap: () {
            Get.back();
            Get.back();
            Get.back();
            clearData();
          },
        ),
      ],
    );
  }

  void clearData() {
    seatController.clear();
    walletPinController.clear();
  }


  void leaveQueue() {
    
  }

  @override
  void onReady() {
    getTerminals();
    super.onReady();
  }

}
