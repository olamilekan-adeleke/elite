import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/image_widget.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/home/controller/home_controller.dart';
import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({Key? key}) : super(key: key);

  static final HomeController homeController = Get.find<HomeController>();
  static final ProfileController profileController =
      Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.all(sizerSp(10)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                if ((profileController.userDetailsModel?.value.profilePicUrl ??
                        '')
                    .isNotEmpty)
                  SizedBox(
                    height: sizerSp(50),
                    width: sizerSp(50),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(sizerSp(100)),
                      child: CustomImageWidget(
                        imageUrl: profileController
                                .userDetailsModel?.value.profilePicUrl ??
                            '',
                        imageTypes: ImageTypes.network,
                      ),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: sizerSp(20),
                    child: const Icon(Icons.person),
                  ),
                SizedBox(width: sizerSp(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextWidget(
                      '${profileController.userDetailsModel?.value.fullName}',
                      fontSize: sizerSp(18),
                      fontWeight: FontWeight.bold,
                    ),
                    CustomTextWidget(
                      'View profile',
                      fontSize: sizerSp(15),
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
