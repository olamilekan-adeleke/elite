import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../auth/services/auth_services.dart';
import '../../model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:intl/intl.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilder: (int index, _, DocumentSnapshot<Object?> documentSnapshots) {
        final Map<String, dynamic>? data =
            documentSnapshots.data() as Map<String, dynamic>?;

        // log(data.toString());

        if (data == null) return Container();

        final TransactionModel transactionModel =
            TransactionModel.fromMap(data);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TransactionHistoryItem(transactionModel),
            const Divider(),
          ],
        );
      },
      query: FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<AuthenticationRepo>().getUserUid())
          .collection('transactions')
          .orderBy('timestamp', descending: true),
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
      emptyDisplay: SizedBox(
        height: sizerSp(150),
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
              'No Transaction History Found.',
              fontSize: sizerSp(18),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionHistoryItem extends StatelessWidget {
  const TransactionHistoryItem(this.transaction, {Key? key}) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        iconWidget(transaction),
        SizedBox(width: sizerSp(10)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: sizerWidth(75),
              child: formatTitle(transaction),
            ),
            formatStatus(transaction),
            SizedBox(height: sizerSp(5)),
            formatTime(transaction.timestamp),
          ],
        ),
      ],
    );
  }

  Widget iconWidget(TransactionModel transaction) {
    return Container(
      height: sizerSp(25),
      width: sizerSp(25),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(sizerSp(10)),
      ),
    );
  }

  Widget formatTitle(TransactionModel transaction) {
    if (transaction.type == TransactionType.fundWallet) {
      return CustomTextWidget(
        'You made a deposit of NGN ${currencyFormatter(transaction.amount)} to you cash wallet',
        fontSize: sizerSp(15),
        fontWeight: FontWeight.w600,
      );
    } else if (transaction.type == TransactionType.sendFund) {
      return CustomTextWidget(
        'You made a fund transfer of NGN ${currencyFormatter(transaction.amount)} to @${transaction.userDetails?.username} ',
        fontSize: sizerSp(15),
        fontWeight: FontWeight.w600,
      );
    } else if (transaction.type == TransactionType.receiveFund) {
      return CustomTextWidget(
        'You received a fund transfer of NGN ${currencyFormatter(transaction.amount)} from @${transaction.userDetails?.username} ',
        fontSize: sizerSp(15),
        fontWeight: FontWeight.w600,
      );
    } else {
      return Container();
    }
  }

  Widget formatStatus(TransactionModel transaction) {
    if (transaction.status == TransactionStatus.pending) {
      return RichText(
        text: TextSpan(
          text: 'Status: ',
          style: GoogleFonts.signikaNegative(
            fontSize: sizerSp(12),
            color: kcTextColor,
            fontWeight: FontWeight.w300,
          ),
          children: [
            TextSpan(
              text: 'Pending..',
              style: GoogleFonts.signikaNegative(
                fontSize: sizerSp(12),
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      );
    } else if (transaction.status == TransactionStatus.success) {
      return RichText(
        text: TextSpan(
          text: 'Status: ',
          style: GoogleFonts.signikaNegative(
            fontSize: sizerSp(12),
            color: kcTextColor,
            fontWeight: FontWeight.w300,
          ),
          children: [
            TextSpan(
              text: 'Completed',
              style: GoogleFonts.signikaNegative(
                fontSize: sizerSp(12),
                color: Colors.green,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      );
    } else if (transaction.status == TransactionStatus.failed) {
      return RichText(
        text: TextSpan(
          text: 'Status: ',
          style: GoogleFonts.signikaNegative(
            fontSize: sizerSp(12),
            color: kcTextColor,
            fontWeight: FontWeight.w300,
          ),
          children: [
            TextSpan(
              text: 'Failed',
              style: GoogleFonts.signikaNegative(
                fontSize: sizerSp(12),
                color: Colors.red,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget formatTime(int timestamp) {
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);

    return CustomTextWidget(
      '${DateFormat().format(dateTime)}',
      fontSize: sizerSp(13),
      fontWeight: FontWeight.w200,
    );
  }
}
