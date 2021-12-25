import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/cores/utils/emums.dart';
import 'package:elite/cores/utils/snack_bar_service.dart';
import 'package:elite/features/auth/model/user_details_model.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  final Rx<ControllerState> state = ControllerState.init.obs;
  final Rx<ControllerState> controllerState = ControllerState.init.obs;
  Rx<UserDetailsModel>? userDetailsModel;
  final RxString filePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController fullNameController =
      TextEditingController(text: '');
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController phoneController = TextEditingController(text: '');

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      filePath.value = image.path;
    }
  }

  Future<void> uploadImage() async {
    if (filePath.isEmpty) return;

    final String? url =
        await authenticationRepo.uploadImage(File(filePath.value));

    log(url.toString());

    if (url != null) {
      await authenticationRepo.updateProfilePicUrl(url);
    }
  }

  Future<void> updateUserData() async {
    final String? username = usernameController.text.isEmpty
        ? userDetailsModel?.value.username
        : usernameController.text.trim();
    final String? fullName = fullNameController.text.isEmpty
        ? userDetailsModel?.value.fullName
        : fullNameController.text.trim();
    final String? phone = phoneController.text.isEmpty
        ? userDetailsModel?.value.phoneNumber
        : phoneController.text.trim();

    try {
      if (username == null || fullName == null || phone == null) return;

      final Map<String, String> data = <String, String>{
        'username': username,
        'full_name': fullName,
        'phone_number': phone,
      };

      state.value = ControllerState.busy;

      final bool usernameCheck =
          await authenticationRepo.checkUsernameExist(username);

      final bool phoneNumberCheck =
          await authenticationRepo.checkPhoneNumberExist(phone);

      if (usernameCheck) data.remove(username);

      if (phoneNumberCheck) data.remove(phone);

      await uploadImage();

      await authenticationRepo.updateUserDetails(data);

      // await getUserData();

      state.value = ControllerState.success;

      Get.back();

      await Future<dynamic>.delayed(const Duration(milliseconds: 200));

      CustomSnackBarService.showSuccessSnackBar(
        'Success',
        'User Details updated successfully!',
      );

      clearData();
    } catch (e, s) {
      state.value = ControllerState.error;
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
      log(e.toString());
      log(s.toString());
    }
  }

  void clearData() {
    usernameController.clear();
    fullNameController.clear();
    phoneController.clear();
    filePath.value = '';
  }

  Future<void> getUserData() async {
    try {
      controllerState.value = ControllerState.busy;
      // final Map<String, dynamic> userData =
      //     await authenticationRepo.getLoggedInUser();

      authenticationRepo
          .getLoggedInUserStream()
          .listen((DocumentSnapshot event) async {
        log('userData: ${event.data()} ');

        final Map<String, dynamic> userData =
            (event.data() ?? {}) as Map<String, dynamic>;

        if (userDetailsModel?.value != null) {
          userDetailsModel!.value = UserDetailsModel.fromMap(userData);
        } else {
          userDetailsModel =
              Rx<UserDetailsModel>(UserDetailsModel.fromMap(userData));
        }

        updateData();
        controllerState.value = ControllerState.success;
      });
    } catch (e) {
      controllerState.value = ControllerState.error;
      showErrorSnackBar(e.toString());
    }
  }

  Future<void> updateData() async {
    controllerState.value = ControllerState.busy;
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    controllerState.value = ControllerState.success;
  }

  @override
  void onReady() {
    getUserData();
    super.onReady();
  }
}
