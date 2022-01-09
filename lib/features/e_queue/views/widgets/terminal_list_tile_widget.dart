import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/features/e_queue/controllers/e_queu_controller.dart';
import 'package:elite/features/e_queue/model/terminal_model.dart';
import 'package:elite/features/e_queue/views/screens/e_queue_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../cores/utils/sizer_utils.dart';

class TerminalListTileWidget extends StatelessWidget {
  const TerminalListTileWidget(
    this.terminalModel, {
    Key? key,
  }) : super(key: key);

  final TerminalModel terminalModel;
  static EQueueController eQueueController = Get.find<EQueueController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizerSp(10.0)),
      height: sizerSp(80),
      child: GestureDetector(
        onTap: () {
          eQueueController.updateSelectedTerminal(terminalModel.name);
          Get.to(() => SelectRiderScreen());
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sizerSp(10.0),
              vertical: sizerSp(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextWidget(
                      terminalModel.name,
                      fontWeight: FontWeight.w600,
                      fontSize: sizerSp(14),
                    ),
                    CustomTextWidget(
                      'View Location',
                      fontWeight: FontWeight.w200,
                      fontSize: sizerSp(14),
                      textColor: const Color(0xff1F66D0),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: sizerSp(60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextWidget(
                        '${terminalModel.todayCount}',
                        fontWeight: FontWeight.bold,
                        fontSize: sizerSp(12),
                        textColor: Colors.green,
                      ),
                      CustomTextWidget(
                        'Successful rides today',
                        fontSize: sizerSp(13),
                        textColor: Colors.green,
                        fontWeight: FontWeight.w200,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: sizerSp(5)),
                SizedBox(
                  width: sizerSp(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextWidget(
                        '${terminalModel.queueNumber}',
                        fontWeight: FontWeight.bold,
                        fontSize: sizerSp(12),
                      ),
                      CustomTextWidget(
                        'Uses on queue',
                        fontSize: sizerSp(13),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w200,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
