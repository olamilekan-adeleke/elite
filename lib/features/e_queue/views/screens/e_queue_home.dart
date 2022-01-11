import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../../cores/utils/snack_bar_service.dart';
import '../../controllers/e_queu_controller.dart';
import '../../model/terminal_model.dart';
import 'package:elite/features/e_queue/views/screens/e_queue_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EQueueHome extends StatelessWidget {
  const EQueueHome({Key? key}) : super(key: key);

  static EQueueController eQueueController = Get.find<EQueueController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      usePadding: false,
      body: SingleChildScrollView(
        child: Container(
          height: sizerHeight(98),
          padding: EdgeInsets.symmetric(horizontal: sizerSp(15.0)),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: sizerSp(20)),
              CustomTextWidget(
                'Where would you like to be picked up?',
                fontSize: sizerSp(18),
                textColor: Colors.black,
              ),
              CustomTextWidget(
                'Select your terminal',
                fontSize: sizerSp(16),
                textColor: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(height: sizerSp(40)),
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
              SizedBox(height: sizerSp(60)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextWidget(
                    'Select your terminal',
                    fontSize: sizerSp(16),
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: sizerSp(10)),
                  CustomTextWidget(
                    'All destinations should be between The university school gate'
                    ' and The university terminus and thus carry same price ',
                    fontSize: sizerSp(16),
                    textColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                text: 'Continue',
                onTap: () {
                  if (eQueueController.selectedTerminalModel?.value != null) {
                    Get.to(() => const SelectRiderScreen());
                  } else {
                    showWarningSnackBar('Select your terminal');
                  }
                },
              ),
              SizedBox(height: sizerSp(20)),
            ],
          ),
        ),
      ),
    );
  }
}
