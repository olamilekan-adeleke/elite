import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/components/image_widget.dart';
import 'package:elite/cores/utils/emums.dart';
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

        // log(data.toString());

        final QueueModel queueModel = QueueModel.fromMap(
          data ?? <String, dynamic>{},
        );

        return QueueListTileWidget(
          index + 1,
          queueModel,
        );
      },
      query: FirebaseFirestore.instance
          .collection('terminals')
          .doc(terminalId)
          .collection('queue')
          .orderBy('timeJoined', descending: false),
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
    this.index,
    this.queueModel, {
    Key? key,
  }) : super(key: key);

  final QueueModel queueModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: sizerSp(10.0)),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizerSp(10.0),
            vertical: sizerSp(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if ((queueModel.user.profilePicUrl ?? '').isNotEmpty)
                    SizedBox(
                      height: sizerSp(35),
                      width: sizerSp(35),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(sizerSp(100)),
                        child: CustomImageWidget(
                          imageUrl: queueModel.user.profilePicUrl ?? '',
                          imageTypes: ImageTypes.network,
                        ),
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: sizerSp(30),
                      child: const Icon(Icons.person),
                    ),
                  SizedBox(width: sizerSp(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextWidget(
                        queueModel.user.fullName,
                        fontWeight: FontWeight.w500,
                        fontSize: sizerSp(15),
                      ),
                      CustomTextWidget(
                        '@${queueModel.user.username}',
                        fontWeight: FontWeight.w200,
                        fontSize: sizerSp(13),
                      ),
                    ],
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
                    ),
                    CustomTextWidget(
                      'Seat(s)',
                      fontSize: sizerSp(13),
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
                      '$index',
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
