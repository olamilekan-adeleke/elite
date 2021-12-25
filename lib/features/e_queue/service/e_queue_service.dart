import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/features/e_queue/model/terminal_model.dart';

class EQueueService {
  static final CollectionReference terminalRef =
      FirebaseFirestore.instance.collection('terminals');

  Future<List<TerminalModel>> getTerminals() async {
    final QuerySnapshot<Object?> querySnapshot = await terminalRef.get();

    final List<TerminalModel> list =
        querySnapshot.docs.map((QueryDocumentSnapshot<Object?> doc) {
      return TerminalModel.fromMap((doc.data() ?? {}) as Map<String, dynamic>);
    }).toList();

    return list;
  }
}
