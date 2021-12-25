// ignore_for_file: lines_longer_than_80_chars

import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/constants/color.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/e_queue/controllers/e_queu_controller.dart';
import 'package:elite/features/e_queue/model/terminal_model.dart';
import 'package:elite/features/e_queue/views/screens/e_queue_home.dart';
import 'package:elite/features/e_queue/views/screens/join_queu_screen.dart';
import 'package:elite/features/e_queue/views/screens/queue_list_widget.dart';
import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SelectRiderScreen extends StatelessWidget {
  const SelectRiderScreen({Key? key}) : super(key: key);

  static EQueueController eQueueController = Get.find<EQueueController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      usePadding: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: sizerSp(10)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizerSp(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextWidget(
                  'E-queue [${eQueueController.selectedTerminalModel?.value.queueNumber} users]',
                  fontSize: sizerSp(16),
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: sizerSp(10)),
                DropdownButtonFormField<String>(
                  hint: Obx(() {
                    return CustomTextWidget(
                      '${eQueueController.selectedTerminalText.value.isEmpty ? 'Select your terminal' : eQueueController.selectedTerminalText.value}',
                      fontSize: sizerSp(16),
                      textColor: Colors.black,
                      fontWeight: FontWeight.w300,
                    );
                  }),
                  items: eQueueController.terminals.map((TerminalModel value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    if (val != null) {
                      eQueueController.updateSelectedTerminal(val);
                    }
                  },
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                ),
                SizedBox(height: sizerSp(10)),
              ],
            ),
          ),
          Expanded(
            child: QueueListWidget(
              eQueueController.selectedTerminalModel?.value.id ?? '',
            ),
          ),
          const JoinAndLeaveQueueButton(),
        ],
      ),
    );
  }
}

class JoinAndLeaveQueueButton extends StatelessWidget {
  const JoinAndLeaveQueueButton({Key? key}) : super(key: key);

  static EQueueController eQueueController = Get.find<EQueueController>();

  static final ProfileController profileController =
      Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(sizerSp(10)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(sizerSp(25)),
            topRight: Radius.circular(sizerSp(25)),
          ),
          color: Colors.white,
        ),
        child: Obx(
          () {
            if (profileController.controllerState.value ==
                ControllerState.busy) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: double.infinity),
                SizedBox(height: sizerSp(10)),
                CustomButton(
                  text: 'Join e-queue',
                  onTap: () {
                    Get.to(() => const JoinQueueWidget());
                  },
                ),
                SizedBox(height: sizerSp(15)),
                CustomTextWidget(
                  '${eQueueController.selectedTerminalModel?.value.todayCount}  Successful rides today',
                  fontSize: sizerSp(16),
                  fontWeight: FontWeight.w600,
                  textColor: Colors.green,
                ),
                SizedBox(height: sizerSp(10)),
              ],
            );
          },
        ),
      ),
    );
  }
}
