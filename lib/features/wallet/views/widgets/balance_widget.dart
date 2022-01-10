import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../services/wallet_service.dart';
import 'package:flutter/material.dart';


class CashWalletWidget extends StatelessWidget {
  const CashWalletWidget({
    Key? key,
  }) : super(key: key);

  static WalletService walletService = WalletService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<dynamic>>(
      stream: walletService.walletData(),
      builder: (_, AsyncSnapshot<DocumentSnapshot<dynamic>> snapshot) {
        // log((snapshot.data?.data() ?? {}).toString());

        // final Map<String, dynamic> data =
        //     (snapshot.data?.data ?? {}) as Map<String, dynamic>;

        return SizedBox(
          height: sizerSp(140),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: sizerSp(10)),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(sizerSp(10)),
                ),
                width: sizerWidth(70),
                height: sizerSp(130),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextWidget(
                      'Naira balance',
                      fontSize: sizerSp(20),
                      fontWeight: FontWeight.w300,
                      textColor: Colors.white,
                    ),
                    CustomTextWidget(
                      'NGN ${(snapshot.data?.data() ?? {})['cash_balance'] ?? 0}',
                      fontSize: sizerSp(35),
                      fontWeight: FontWeight.w300,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: sizerSp(10)),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(sizerSp(10)),
                ),
                width: sizerWidth(70),
                height: sizerSp(130),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextWidget(
                      'coin balance',
                      fontSize: sizerSp(20),
                      fontWeight: FontWeight.w300,
                      textColor: Colors.white,
                    ),
                    CustomTextWidget(
                      '# ${(snapshot.data?.data() ?? {})['coin_balance'] ?? 0}',
                      fontSize: sizerSp(35),
                      fontWeight: FontWeight.w300,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
