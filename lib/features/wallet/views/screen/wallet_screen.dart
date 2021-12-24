import 'package:elite/cores/components/custom_button.dart';
import 'package:elite/cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/image_widget.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  static final ProfileController profileController =
      Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: SizedBox(
        height: sizerHeight(100),
        child: Column(
          children: <Widget>[
            SizedBox(height: sizerSp(20)),
            Row(
              children: <Widget>[
                CustomTextWidget(
                  'Wallet',
                  fontSize: sizerSp(20),
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                SizedBox(
                  height: sizerSp(40),
                  width: sizerSp(40),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(sizerSp(100)),
                    child: CustomImageWidget(
                      imageUrl: profileController
                              .userDetailsModel?.value.profilePicUrl ??
                          '',
                      imageTypes: ImageTypes.profile,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: sizerSp(140),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (_, __) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: sizerSp(10)),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(sizerSp(10)),
                    ),
                    width: sizerWidth(70),
                    height: sizerSp(130),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomTextWidget(
                          'Naira balance',
                          fontSize: sizerSp(20),
                          fontWeight: FontWeight.w300,
                          textColor: Colors.white,
                        ),
                        CustomTextWidget(
                          '# 500',
                          fontSize: sizerSp(35),
                          fontWeight: FontWeight.w300,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: sizerSp(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                  text: 'Fund Wallet',
                  onTap: () {},
                  width: sizerWidth(25),
                ),
                CustomButton(
                  text: 'Get Coins',
                  onTap: () {},
                  width: sizerWidth(25),
                ),
                CustomButton(
                  text: 'Transfer',
                  onTap: () => Get.toNamed('/transfer'),
                  width: sizerWidth(25),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                
                itemBuilder: (_, __) {
                  return const ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Operation fund wallet'),
                    subtitle: Text('Dec 12  6:45 pm'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
