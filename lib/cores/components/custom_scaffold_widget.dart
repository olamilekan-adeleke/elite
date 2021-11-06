import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:flutter/material.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({
    Key? key,
    required this.body,
    this.appBar,
    this.usePadding = true,
  }) : super(key: key);

  final Widget body;
  final AppBar? appBar;
  final bool usePadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: usePadding ? sizerSp(10.0) : 0,
          ),
          child: body,
        ),
      ),
    );
  }
}
