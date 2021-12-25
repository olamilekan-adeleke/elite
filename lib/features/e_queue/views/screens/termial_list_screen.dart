import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/features/e_queue/model/terminal_model.dart';
import 'package:elite/features/e_queue/views/widgets/terminal_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class TerminalsListScreen extends StatelessWidget {
  const TerminalsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilder: (int index, _, DocumentSnapshot<Object?> documentSnapshots) {
        final Map<String, dynamic>? data =
            documentSnapshots.data() as Map<String, dynamic>?;

        // log(data.toString());

        final TerminalModel terminalModel = TerminalModel.fromMap(
          {
            ...data ?? <String, dynamic>{},
            'id': documentSnapshots.id,
          },
        );

        return TerminalListTileWidget(terminalModel);
      },
      query: FirebaseFirestore.instance.collection('terminals').orderBy('name'),
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
    );
  }
}
