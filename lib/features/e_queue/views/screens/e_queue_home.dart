import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/constants/color.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:flutter/material.dart';

class EQueueHome extends StatelessWidget {
  const EQueueHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      usePadding: false,
      body: Container(
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
            // Center(
            //   child: SvgPicture.asset(
            //     'assets/images/time.svg',
            //     height: sizerSp(150),
            //     width: sizerSp(200),
            //   ),
            // ),
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
              onTap: () {},
            ),
            SizedBox(height: sizerSp(20)),
          ],
        ),
      ),
    );
  }
}
