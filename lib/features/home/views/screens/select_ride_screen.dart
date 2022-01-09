import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/constants/color.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/e_queue/views/screens/e_queue_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SelectRideScreen extends StatelessWidget {
  const SelectRideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      usePadding: false,
      body: LiquidSwipe(
        pages: const <Widget>[
          EQueueWidget(),
          InstantRideWidget(),
        ],
        slideIconWidget: const Icon(Icons.arrow_back_ios),
        fullTransitionValue: 880,
        ignoreUserGestureWhileAnimating: true,
      ),
    );
  }
}

class EQueueWidget extends StatelessWidget {
  const EQueueWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Select a category of ride',
            fontSize: sizerSp(18),
            textColor: Colors.black,
          ),
          SizedBox(height: sizerSp(40)),
          Center(
            child: SvgPicture.asset(
              'assets/images/time.svg',
              height: sizerSp(150),
              width: sizerSp(200),
            ),
          ),
          SizedBox(height: sizerSp(60)),
          CustomTextWidget(
            'Tired of this?',
            fontSize: sizerSp(22),
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: sizerSp(10)),
          CustomTextWidget(
            'Use our online queuing feature(E-QUEUE) instead ',
            fontSize: sizerSp(18),
            textColor: Colors.black,
            fontWeight: FontWeight.w300,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CustomButton(
                  text: 'Select',
                  onTap: () => Get.to(() => const EQueueHome()),
                ),
              ),
              SizedBox(width: sizerSp(8)),
              Expanded(
                child: CustomButton(
                  text: 'Learn More',
                  onTap: () {},
                  textColor: kcPrimaryColor,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: sizerSp(20)),
        ],
      ),
    );
  }
}

class InstantRideWidget extends StatelessWidget {
  const InstantRideWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizerSp(15.0)),
      color: kcPrimaryColor,
      child: Column(
        children: <Widget>[
          AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            backgroundColor: kcPrimaryColor,
          ),
          SizedBox(height: sizerSp(20)),
          CustomTextWidget(
            'Select a category of ride',
            fontSize: sizerSp(18),
            textColor: Colors.white,
          ),
          SizedBox(height: sizerSp(40)),
          Center(
            child: SvgPicture.asset(
              'assets/images/runing.svg',
              height: sizerSp(150),
              width: sizerSp(200),
            ),
          ),
          SizedBox(height: sizerSp(60)),
          CustomTextWidget(
            'Don’t want to be delayed?',
            fontSize: sizerSp(22),
            textColor: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: sizerSp(10)),
          CustomTextWidget(
            'Get your ride in 3mins, use our instant ride feature now ',
            fontSize: sizerSp(18),
            textColor: Colors.white,
            fontWeight: FontWeight.w300,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CustomButton(
                  text: 'Select',
                  onTap: () {},
                  color: Colors.white,
                  textColor: kcPrimaryColor,
                ),
              ),
              SizedBox(width: sizerSp(8)),
              Expanded(
                child: CustomButton(
                  text: 'Learn More',
                  onTap: () {},
                  textColor: Colors.white,
                  color: kcPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: sizerSp(20)),
        ],
      ),
    );
  }
}
