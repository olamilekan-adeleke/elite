import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/shimmer_widget.dart';
import '../../../../cores/utils/emums.dart';
import 'package:elite/cores/utils/navigator_service.dart';
import 'package:elite/cores/utils/route_name.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  static final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizerSp(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Obx(() {
                if (homeController.state == ControllerStateEnum.busy) {
                  return CustomShimmerWidget(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.grey.shade200,
                    ),
                  );
                }
                return CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, color: Colors.grey.shade400),
                );
              }),
              SizedBox(height: sizerSp(10.0)),
              Obx(() {
                if (homeController.state == ControllerStateEnum.busy) {
                  return CustomShimmerWidget(
                    child: Container(
                      height: sizerSp(10),
                      width: sizerSp(80),
                      color: Colors.grey,
                    ),
                  );
                }
                return CustomTextWidget(
                  'Welcome, ${homeController.fullname}',
                  textColor: Colors.white,
                  fontSize: sizerSp(15),
                );
              }),
            ],
          ),
          IconButton(
            onPressed: () =>
                NavigationService.navigateTo(RouteName.notificationScreen),
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
              size: sizerSp(25.0),
            ),
          )
        ],
      ),
    );
  }
}
