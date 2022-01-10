import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/utils/emums.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../auth/services/auth_services.dart';
import '../../controller/home_controller.dart';
import '../../../profile/controllers/profile_controller.dart';
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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed('/profile');
                      },
                      child: CustomTextWidget(
                        'View profile',
                        fontSize: sizerSp(15),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: sizerSp(20.0)),
            DrawerItemWidget(
              icon: Icons.history,
              title: 'Trip',
              callback: () {},
            ),
            SizedBox(height: sizerSp(20.0)),
            DrawerItemWidget(
              icon: Icons.person,
              title: 'Your Drivers',
              callback: () {},
            ),
            SizedBox(height: sizerSp(20.0)),
            DrawerItemWidget(
              icon: Icons.message_outlined,
              title: 'Support',
              callback: () {},
            ),
            SizedBox(height: sizerSp(20.0)),
            DrawerItemWidget(
              icon: Icons.info,
              title: 'About',
              callback: () {},
            ),
            const Spacer(),
            DrawerItemWidget(
              icon: Icons.phone_android,
              title: 'Log Out',
              callback: () => AuthenticationRepo().signOut(),
            ),
            SizedBox(height: sizerSp(20.0)),
          ],
        ),
      ),
    );
  }
}

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.callback,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function()? callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: sizerSp(15), color: Colors.grey.shade700),
      title: CustomTextWidget(
        title,
        fontSize: sizerSp(15),
        fontWeight: FontWeight.bold,
      ),
      onTap: () => callback!(),
    );
  }
}
