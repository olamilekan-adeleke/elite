// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:elite/features/e_queue/model/queue_model.dart';
import 'package:elite/features/e_queue/model/terminal_model.dart';
import 'package:get/get.dart';

class EQueueService {
  static final AuthenticationRepo authenticationRepo =
      Get.find<AuthenticationRepo>();
  static final CollectionReference terminalRef =
      FirebaseFirestore.instance.collection('terminals');
  final CollectionReference<dynamic> userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  Future<List<TerminalModel>> getTerminals() async {
    final QuerySnapshot<Object?> querySnapshot = await terminalRef.get();

    final List<TerminalModel> list =
        querySnapshot.docs.map((QueryDocumentSnapshot<Object?> doc) {
      return TerminalModel.fromMap(<String, dynamic>{
        ...(doc.data() ?? {}) as Map<String, dynamic>,
        'id': doc.id,
      });
    }).toList();

    return list;
  }

  Future<void> addToEQueue(String terminalId, QueueModel queueModel) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();

    final DocumentReference queueDocRef =
        terminalRef.doc(terminalId).collection('queue').doc();

    final DocumentReference userDocRef =
        userCollectionRef.doc(authenticationRepo.getUserUid());

    batch.set(
      queueDocRef,
      <String, dynamic>{
        ...queueModel.toMap(),
        'id': queueDocRef.id,
      },
    );

    batch.update(userDocRef, {'is_in_queue': true});

    await batch.commit();
  }
}
