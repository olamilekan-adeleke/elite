import 'package:elite/cores/components/custom_text_widget.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:flutter/material.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    Key? key,
    required this.title,
    required this.routeName,
    this.big = false,
  }) : super(key: key);

  final String title;
  final String routeName;
  final bool big;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizerSp(20.0)),
      padding: EdgeInsets.symmetric(
        horizontal: sizerSp(10.0),
        vertical: sizerSp(big ? 40 : 15),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizerSp(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomTextWidget(
            title,
            fontSize: sizerSp(22),
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: sizerSp(18),
                color: Colors.grey.shade800,
              ),
            ],
          )
        ],
      ),
    );
  }
}
