import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/features/e_queue/model/queue_model.dart';
import 'package:elite/features/e_queue/model/terminal_model.dart';

class EQueueService {
  static final CollectionReference terminalRef =
      FirebaseFirestore.instance.collection('terminals');

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
    final DocumentReference docRef =
        terminalRef.doc(terminalId).collection('queue').doc();

    await docRef.set(
      <String, dynamic>{
        ...queueModel.toMap(),
        'id': docRef.id,
      },
    );
  }
}
