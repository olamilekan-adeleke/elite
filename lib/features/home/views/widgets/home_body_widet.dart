import 'package:elite/cores/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../cores/components/custom_button.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/utils/emums.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../profile/controllers/profile_controller.dart';
import '../screens/select_ride_screen.dart';
import 'home_header_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizerHeight(96.5),
      child: Column(
        children: <Widget>[
          SizedBox(height: sizerSp(15.0)),
          const HomeHeaderWidget(),
          SizedBox(height: sizerSp(20.0)),
          const Divider(),
          WalletListView(),
          const Divider(),
          // SizedBox(
          //   height: sizerHeight(45),
          //   child: const TerminalsListScreen(),
          // ),
          const HomeProfileWidget(),
        ],
      ),
    );
  }
}

class WalletListView extends StatelessWidget {
  const WalletListView();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.sp,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        scrollDirection: Axis.horizontal,
        children: [
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CustomTextWidget(
                        'NGN  1,000',
                        fontSize: 16.sp,
                      ),
                      SizedBox(width: 70),
                      Icon(Icons.remove_red_eye, size: 20.sp, color: kcGrey300),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomTextWidget(
                    'Naira balance',
                    fontSize: 14.sp,
                    textColor: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CustomTextWidget(
                        'NGN  ****',
                        fontSize: 16.sp,
                      ),
                      SizedBox(width: 70),
                      Icon(Icons.remove_red_eye, size: 20.sp, color: kcGrey300),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomTextWidget(
                    'Coin balance',
                    fontSize: 14.sp,
                    textColor: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeProfileWidget extends StatelessWidget {
  const HomeProfileWidget({Key? key}) : super(key: key);

  static final ProfileController profileController =
      Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(sizerSp(10)),
        child: Obx(
          () {
            if (profileController.controllerState.value ==
                ControllerState.busy) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(width: double.infinity),
                  // if ((profileController
                  //             .userDetailsModel?.value.profilePicUrl ??
                  //         '')
                  //     .isNotEmpty)
                  //   SizedBox(
                  //     height: sizerSp(60),
                  //     width: sizerSp(60),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(sizerSp(100)),
                  //       child: CustomImageWidget(
                  //         imageUrl: profileController
                  //                 .userDetailsModel?.value.profilePicUrl ??
                  //             '',
                  //         imageTypes: ImageTypes.network,
                  //       ),
                  //     ),
                  //   )
                  // else
                  //   CircleAvatar(
                  //     radius: sizerSp(30),
                  //     child: const Icon(Icons.person),
                  //   ),
                  SizedBox(height: sizerSp(15)),
                  CustomTextWidget(
                    'Good afternoon, '
                    '${profileController.userDetailsModel?.value.fullName}',
                    fontSize: sizerSp(14),
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(height: sizerSp(10)),
                  CustomTextWidget(
                    'Going Off-campus?',
                    fontSize: sizerSp(20),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: sizerSp(20)),
                  CustomTextWidget(
                    'Select a category of ride',
                    fontSize: sizerSp(14),
                    fontWeight: FontWeight.w300,
                  ),
                  // CustomButton(
                  //   text: 'Get a ride',
                  //   onTap: () {
                  //     Get.to(() => const SelectRideScreen());
                  //   },
                  // ),
                  SizedBox(height: sizerSp(15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130.sp,
                        height: 160.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Color(0xffECE8E8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.view_list,
                              size: 40.sp,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 20.sp),
                            CustomTextWidget('Go-terminal', fontSize: 15.sp),
                          ],
                        ),
                      ),

                      ///
                      Container(
                        width: 130.sp,
                        height: 160.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Color(0xffECE8E8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.bolt,
                              size: 40.sp,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 20.sp),
                            CustomTextWidget(
                              'Instant Ride',
                              fontSize: 15.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
