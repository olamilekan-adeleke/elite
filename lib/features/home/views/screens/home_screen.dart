import 'package:elite/cores/constants/color.dart';
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

  static final List<Widget> pages = <Widget>[
    const HomeBodyWidget(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      scaffoldKey: homeController.scaffoldKey,
      bg: Colors.white.withOpacity(0.97),
      usePadding: false,
      drawer: const HomeDrawerWidget(),
      body: SizedBox(
        height: sizerHeight(100),
        child: Obx(() {
          return IndexedStack(
            index: homeController.currentIndex.value,
            children: pages,
          );
        }),
      ),
      bottomNav: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: kcPrimaryColor,
          unselectedItemColor: kcGrey400,
          currentIndex: homeController.currentIndex.value,
          onTap: (int index) => homeController.updateIndex(index),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard_outlined),
              label: '',
            ),
          ],
        );
      }),
    );
  }
}
