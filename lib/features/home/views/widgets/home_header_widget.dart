import '../../../../cores/utils/sizer_utils.dart';
import '../../controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

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
          IconButton(
            onPressed: () => homeController.openDrawer(),
            icon: Icon(
              Icons.menu_rounded,
              size: sizerSp(25.0),
            ),
          ),
          IconButton(
            onPressed: () {
              // Get.toNamed(RouteName.notificationScreen);
            },
            icon: Icon(
              Icons.notifications,
              size: sizerSp(20.0),
            ),
          )
        ],
      ),
    );
  }
}
