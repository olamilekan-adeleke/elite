import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:get/get.dart';

class WalletService {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  final CollectionReference<dynamic> walletCollectionRef =
      FirebaseFirestore.instance.collection('wallets');

  Stream<DocumentSnapshot<dynamic>> walletData() async* {
    yield* walletCollectionRef.doc(authenticationRepo.getUserUid()).snapshots();
  }
}
