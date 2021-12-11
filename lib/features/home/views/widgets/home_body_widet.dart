import 'package:elite/features/e_queue/views/screens/termial_list_screen.dart';
import 'package:flutter/material.dart';

import '../../../../cores/utils/sizer_utils.dart';
import 'home_header_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizerHeight(100),
      child: Column(
        children: <Widget>[
          SizedBox(height: sizerSp(15.0)),
          const HomeHeaderWidget(),
          SizedBox(height: sizerSp(20.0)),
          SizedBox(
            height: sizerHeight(45),
            child: const TerminalsListScreen(),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
