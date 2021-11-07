import '../../../../cores/utils/sizer_utils.dart';
import 'home_header_widget.dart';
import 'home_items_list.dart';
import 'package:flutter/material.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: sizerSp(35.0)),
        const HomeHeaderWidget(),
        SizedBox(height: sizerSp(65.0)),
        const HomeItemsList(),
      ],
    );
  }
}
