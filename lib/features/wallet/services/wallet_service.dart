import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/services/auth_services.dart';
import '../model/transaction_model.dart';
import 'package:get/get.dart';

class WalletService {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  final CollectionReference<dynamic> _userCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<dynamic> _walletCollectionRef =
      FirebaseFirestore.instance.collection('wallets');

  Stream<DocumentSnapshot<dynamic>> walletData() async* {
    yield* _walletCollectionRef
        .doc(authenticationRepo.getUserUid())
        .snapshots();
  }

  Future<void> fundWallet(
    TransactionModel transactions, {
    required String reference,
    
  }) async {
    await _userCollectionRef
        .doc(authenticationRepo.getUserUid())
        .collection('transactions')
        .add(
      {
        ...transactions.toMap(),
        "reference": reference,
        
      },
    );
  }
}
