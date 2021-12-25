import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/e_queue/model/queue_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class QueueListWidget extends StatelessWidget {
  const QueueListWidget(this.terminalId, {Key? key}) : super(key: key);

  final String terminalId;

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilder: (int index, _, DocumentSnapshot<Object?> documentSnapshots) {
        final Map<String, dynamic>? data =
            documentSnapshots.data() as Map<String, dynamic>?;

        log(data.toString());

        final QueueModel queueModel = QueueModel.fromMap(
          data ?? <String, dynamic>{},
        );

        return QueueListTileWidget(queueModel);
      },
      query: FirebaseFirestore.instance
          .collection('terminals')
          .doc(terminalId)
          .collection('queue'),
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
      emptyDisplay: SizedBox(
        height: sizerSp(250),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                'assets/images/signup.svg',
                height: sizerSp(100),
                width: sizerSp(150),
              ),
            ),
            SizedBox(height: sizerSp(40)),
            CustomTextWidget(
              'No User On Queue',
              fontSize: sizerSp(18),
            ),
          ],
        ),
      ),
    );
  }
}

class QueueListTileWidget extends StatelessWidget {
  const QueueListTileWidget(
    this.queueModel, {
    Key? key,
  }) : super(key: key);

  final QueueModel queueModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizerSp(10.0)),
      height: sizerSp(80),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizerSp(10.0),
            vertical: sizerSp(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextWidget(
                    queueModel.user.fullName,
                    fontWeight: FontWeight.w600,
                    fontSize: sizerSp(14),
                  ),
                  CustomTextWidget(
                    'View Location',
                    fontWeight: FontWeight.w200,
                    fontSize: sizerSp(14),
                    textColor: const Color(0xff1F66D0),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: sizerSp(60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextWidget(
                      '${queueModel.numberOfSeats}',
                      fontWeight: FontWeight.bold,
                      fontSize: sizerSp(12),
                      textColor: Colors.green,
                    ),
                    CustomTextWidget(
                      'Seat(s)',
                      fontSize: sizerSp(13),
                      textColor: Colors.green,
                      fontWeight: FontWeight.w200,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(width: sizerSp(5)),
              SizedBox(
                width: sizerSp(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextWidget(
                      '${queueModel.serialNumber}',
                      fontWeight: FontWeight.bold,
                      fontSize: sizerSp(12),
                    ),
                    CustomTextWidget(
                      'S/N',
                      fontSize: sizerSp(13),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w200,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
