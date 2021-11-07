import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import 'package:flutter/material.dart';

class HomeBackgroundWidget extends StatelessWidget {
  const HomeBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizerHeight(100),
      color: kcBackground,
      child: Column(
        children: <Widget>[
          Container(
            height: sizerHeight(36),
            decoration: BoxDecoration(
              color: kcPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(sizerSp(25)),
                bottomRight: Radius.circular(sizerSp(25)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
