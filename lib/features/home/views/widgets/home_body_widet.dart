import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/image_widget.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/e_queue/views/screens/termial_list_screen.dart';
import 'package:elite/features/home/views/screens/select_ride_screen.dart';
import 'package:elite/features/home/views/widgets/home_header_widget.dart';
import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          SizedBox(
            height: sizerHeight(45),
            child: const TerminalsListScreen(),
          ),
          const HomeProfileWidget(),
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
      child: Material(
        elevation: 10.0,
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(sizerSp(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(sizerSp(25)),
              topRight: Radius.circular(sizerSp(25)),
            ),
            color: Colors.white,
          ),
          child: Obx(
            () {
              if (profileController.controllerState.value ==
                  ControllerState.busy) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(width: double.infinity),
                    if ((profileController
                                .userDetailsModel?.value.profilePicUrl ??
                            '')
                        .isNotEmpty)
                      SizedBox(
                        height: sizerSp(60),
                        width: sizerSp(60),
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
                        radius: sizerSp(30),
                        child: const Icon(Icons.person),
                      ),
                    SizedBox(height: sizerSp(15)),
                    CustomTextWidget(
                      'Good afternoon, '
                      '${profileController.userDetailsModel?.value.fullName}',
                      fontSize: sizerSp(17),
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(height: sizerSp(10)),
                    CustomTextWidget(
                      'Going Off-campus?',
                      fontSize: sizerSp(25),
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: sizerSp(20)),
                    CustomButton(
                      text: 'Get a ride',
                      onTap: () {
                        Get.to(() => const SelectRideScreen());
                      },
                    ),
                    SizedBox(height: sizerSp(15)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
