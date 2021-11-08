import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import '../../../cores/utils/firebase_messaging_utils.dart';
import '../../../cores/utils/local_database_repo.dart';
import '../../../cores/utils/logger.dart';
import '../../../features/auth/model/login_user_model.dart';
import '../../../features/auth/model/user_details_model.dart';

class AuthenticationRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final LocalDatabaseRepo localDatabaseRepo =
      Get.find<LocalDatabaseRepo>();
  final CollectionReference<dynamic> userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  LoginUserModel? userFromFirestore(User? user) {
    return user != null ? LoginUserModel(user.uid) : null;
  }

  String? getUserUid() {
    return firebaseAuth.currentUser?.uid;
  }

  Stream<LoginUserModel?> get userAuthState {
    return firebaseAuth
        .authStateChanges()
        .map((User? user) => userFromFirestore(user));
  }

  Future<void> loginUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User? user = userCredential.user;
    infoLog('userCredential: ${user?.uid}', title: 'user log in');

    final Map<String, dynamic> userData = await getLoggedInUser();
    userData.remove('date_joined');
    await localDatabaseRepo.saveUserDataToLocalDB(userData);
    await NotificationMethods.subscribeToTopic(user!.uid);
  }

  Future<bool> authenticateUser(String password) async {
    bool authenticated = false;
    final String email =
        (await localDatabaseRepo.getUserDataFromLocalDB()).email;

    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      authenticated = true;
    }

    return authenticated;
  }

  Future<void> registerUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required String username,
    required String number,
  }) async {
    final bool usernameCheck = await checkUsernameExist(username);

    if (usernameCheck) throw 'Username Already Exist!';

    final bool checkPhoneNumber = await checkPhoneNumberExist(number);

    if (checkPhoneNumber) throw 'Phone Number Already In Use By Another User!';

    final UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    final User? user = userCredential.user;

    if (user == null) throw Exception('Opps, an error occurred!');

    final UserDetailsModel userDetailsModel = UserDetailsModel(
      uid: user.uid,
      email: email,
      fullName: fullName,
      walletBalance: 0.0,
      phoneNumber: number,
      dateJoined: Timestamp.now(),
      username: username,
    );

    infoLog('userCredential: ${user.uid}', title: 'user sign up');

    await addUserDataToFirestore(userDetailsModel);

    await NotificationMethods.subscribeToTopic(user.uid);

    final UserDetailsModel userDetailsForLocalDb = UserDetailsModel(
      uid: user.uid,
      email: email,
      fullName: fullName,
      phoneNumber: number,
      walletBalance: 0.0,
      username: username,
    );

    await localDatabaseRepo
        .saveUserDataToLocalDB(userDetailsForLocalDb.toMap());
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    infoLog('user email: $email', title: 'reset password');
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      infoLog('user logging out', title: 'log out');
    } catch (e, s) {
      errorLog(
        e.toString(),
        'Error log out',
        title: 'log out',
        trace: s.toString(),
      );
      throw Exception('Error: $e');
    }
  }

  Future<void> addUserDataToFirestore(UserDetailsModel userDetails) async {
    await userCollectionRef.doc(userDetails.uid).set(userDetails.toMap());
    infoLog('Added User database', title: 'Add user data To Db');
  }

  Future<void> updateUserData(UserDetailsModel userDetails) async {
    try {
      await userCollectionRef.doc(userDetails.uid).update(userDetails.toMap());
      await localDatabaseRepo.saveUserDataToLocalDB(userDetails.toMap());
      infoLog('Updated User database', title: 'Updated user data To Db');
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> updatePhonStatus() async {
    try {
      await userCollectionRef.doc(getUserUid()).update(
        <String, dynamic>{'has_verify_number': true},
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> createWalletPin(String walletPin) async {
    try {
      // ! hash wallet pin
      await userCollectionRef.doc(getUserUid()).update(
        <String, dynamic>{
          'wallet_pin': walletPin,
          'has_create_wallet_pin': true,
        },
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> updateProfile(String url) async {
    try {
      await userCollectionRef.doc(getUserUid()).update(
        <String, dynamic>{'profile_pic_url': url},
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getLoggedInUser() async {
    final DocumentSnapshot<dynamic> documentSnapshot =
        await userCollectionRef.doc(getUserUid()).get();

    return documentSnapshot.data() as Map<String, dynamic>;
  }

  Future<bool> checkUsernameExist(String username) async {
    final QuerySnapshot querySnapshot =
        await userCollectionRef.where('username', isEqualTo: username).get();

    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkPhoneNumberExist(String phone) async {
    final QuerySnapshot querySnapshot =
        await userCollectionRef.where('phone_number', isEqualTo: phone).get();

    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> uploadImage(File file) async {
    String? imageUrl;

    try {
      Reference ref = FirebaseStorage.instance
          .ref('uploads/images/${DateTime.now().millisecond}');

      UploadTask uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %',
        );
        // loadingPercentage.value =
        //     (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        // print('loadingPercentage.value: ${loadingPercentage.value}');
      });

      await uploadTask;

      imageUrl = await ref.getDownloadURL();
      // loadingPercentage.value = 0;
      // imageCount.value++;

    } on FirebaseException catch (e) {
      log(e.toString());

      // e.g, e.code == 'canceled'
    }

    return imageUrl;
  }
}
