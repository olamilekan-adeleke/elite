import 'package:elite/cores/utils/navigator_service.dart';
import 'package:elite/cores/utils/route_name.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/auth/services/auth_services.dart';
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
          IconButton(
            onPressed: () => homeController.openDrawer(),
            icon: Icon(
              Icons.menu_rounded,
              size: sizerSp(25.0),
            ),
          ),
          IconButton(
            onPressed: () =>
                NavigationService.navigateTo(RouteName.notificationScreen),
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
