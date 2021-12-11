import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/home/controller/home_controller.dart';
import 'package:elite/features/home/views/widgets/home_body_widet.dart';
import 'package:elite/features/home/views/widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  static final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      scaffoldKey: homeController.scaffoldKey,
      bg: Colors.white.withOpacity(0.97),
      usePadding: false,
      drawer: const HomeDrawerWidget(),
      body: SizedBox(
        height: sizerHeight(100),
        child: ListView(
          children: const <Widget>[
            // HomeBackgroundWidget(),
            HomeBodyWidget(),
          ],
        ),
      
      ),

    );
  }
}
