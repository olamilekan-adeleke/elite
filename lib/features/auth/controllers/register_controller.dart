import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cores/constants/error_text.dart';
import '../../../cores/utils/emums.dart';
import '../../../cores/utils/logger.dart';
import '../../../cores/utils/snack_bar_service.dart';
import '../services/auth_services.dart';

class RegisterController extends GetxController {
  final Rx<ControllerState> _controllerStateEnum = ControllerState.init.obs;
  final Rx<ControllerState> smsState = ControllerState.init.obs;
  final Rx<ControllerState> createWalletPinState = ControllerState.init.obs;
  final Rx<ControllerState> imageState = ControllerState.init.obs;
  static final AuthenticationRepo _authenticationRepo =
      Get.find<AuthenticationRepo>();
  final TextEditingController firstnameController =
      TextEditingController(text: '');
  final TextEditingController lastnameController =
      TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController smsCodeController =
      TextEditingController(text: '');
  final TextEditingController walletPinController =
      TextEditingController(text: '');
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController phoneController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  final RxString filePath = ''.obs;
  final ImagePicker _picker = ImagePicker();
  // ignore: use_late_for_private_fields_and_variables
  String? _verificationId;
  int? _resendToken;

  ControllerState get controllerStateEnum => _controllerStateEnum.value;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      filePath.value = image.path;
    }
  }

  Future<void> uploadImage() async {
    if (filePath.isEmpty) return;

    try {
      imageState.value = ControllerState.busy;
      final String? url =
          await _authenticationRepo.uploadImage(File(filePath.value));

      log(url.toString());

      if (url != null) {
        await _authenticationRepo.updateProfilePicUrl(url);
      }

      CustomSnackBarService.showSuccessSnackBar(
        'Success',
        'Image Updated Successfully!',
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      Get.offNamed('create-wallet-pin');

      imageState.value = ControllerState.success;
    } catch (e, s) {
      imageState.value = ControllerState.error;
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
      log(e.toString());
      log(s.toString());
    }
  }

  Future<void> registerUser() async {
    _controllerStateEnum.value = ControllerState.busy;

    try {
      await _authenticationRepo.registerUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        fullName: '${firstnameController.text.trim()}'
            ' ${lastnameController.text.trim()}',
        number: phoneController.text.trim(),
        username: usernameController.text.trim(),
      );
      _controllerStateEnum.value = ControllerState.success;
      await Get.offAndToNamed('/smsCode');
      CustomSnackBarService.showSuccessSnackBar(
        'Success',
        'Account Successfully Created!',
      );
    } on SocketException {
      _controllerStateEnum.value = ControllerState.error;
      CustomSnackBarService.showErrorSnackBar(
        'Error',
        noInternetConnectionText,
      );
    } catch (e, s) {
      errorLog('$e', 'Error signing up in user', title: 'sign up', trace: '$s');

      _controllerStateEnum.value = ControllerState.error;
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
    }
  }

  String getFormattedPhoneNumber() {
    String phone = phoneController.text.trim();

    if (phone.startsWith('0')) {
      phone = phone.replaceFirst('0', '+234');
    }

    return phone;
  }

  Future<void> sendSms() async {
    await _authenticationRepo.firebaseAuth.verifyPhoneNumber(
      phoneNumber: getFormattedPhoneNumber(),
      // timeout: const Duration(seconds: 5),
      forceResendingToken: _resendToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        _verificationId = credential.verificationId;
        smsCodeController.text = credential.smsCode ?? '';
        CustomSnackBarService.showSuccessSnackBar(
          'Success',
          'Phone number automatically verified!',
        );

        await signInWithPhoneNumber();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }

        log(e.message ?? '');
        log(e.toString());
        log(e.stackTrace.toString());

        CustomSnackBarService.showErrorSnackBar('Error', e.message ?? '');
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        // CustomSnackBarService.showErrorSnackBar(
        //   'Error',
        //   'verification code: $verificationId',
        // );
      },
    );
  }

  Future<void> signInWithPhoneNumber() async {
    if (smsCodeController.text.trim().isEmpty) {
      return CustomSnackBarService.showErrorSnackBar(
        'Error',
        'Please Enter The Sms Code Sent!',
      );
    }

    try {
      smsState.value = ControllerState.busy;

      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCodeController.text.trim(),
      );

      await _authenticationRepo.firebaseAuth.currentUser
          ?.linkWithCredential(credential);

      await _authenticationRepo.updatePhonStatus();

      CustomSnackBarService.showSuccessSnackBar(
        'Success',
        'Phone Number Successfully Verify!',
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      smsState.value = ControllerState.success;

      Get.offNamed('update-profile');
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == 'account-exists-with-different-credential') {
        CustomSnackBarService.showErrorSnackBar(
          'Error',
          'User Already Exist, Please Login!',
        );
      }
      CustomSnackBarService.showErrorSnackBar(
        'Error',
        e.message ?? '',
      );
      smsState.value = ControllerState.error;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
      smsState.value = ControllerState.error;
    }
  }

  Future<void> createWalletPin() async {
    if (walletPinController.text.trim().isEmpty) {
      return CustomSnackBarService.showWarningSnackBar(
        'Error',
        'Please Enter Wallet Pin!',
      );
    }

    try {
      createWalletPinState.value = ControllerState.busy;

      final walletPin = walletPinController.text.trim();

      await _authenticationRepo.createWalletPin(walletPin);

      // log(url.toString());

      // if (url != null) {
      //   await _authenticationRepo.updateProfile(url);
      // }

      CustomSnackBarService.showSuccessSnackBar(
        'Success',
        'Wallet Pin Successfully Created!',
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      Get.offAllNamed('/home');

      createWalletPinState.value = ControllerState.success;
    } catch (e, s) {
      createWalletPinState.value = ControllerState.error;
      CustomSnackBarService.showErrorSnackBar('Error', e.toString());
      log(e.toString());
      log(s.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      firstnameController.text = 'olami';
      lastnameController.text = 'kod-x';
      usernameController.text = 'kod-x';
      emailController.text = 'ola100@gmail.com';
      phoneController.text = '07052936789'; // '09016468355'
      passwordController.text = 'test123456';
      confirmPasswordController.text = 'test123456';
    }
  }
}
