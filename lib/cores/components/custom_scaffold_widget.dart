import 'package:flutter/material.dart';
import '../utils/sizer_utils.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({
    Key? key,
    required this.body,
    this.appBar,
    this.usePadding = true,
    this.bg,
    this.scaffoldKey,
    this.drawer,
  }) : super(key: key);

  final Widget? drawer;
  final Widget body;
  final AppBar? appBar;
  final bool usePadding;
  final Color? bg;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        backgroundColor: bg ?? Colors.white.withOpacity(0.98),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: usePadding ? sizerSp(15.0) : 0,
          ),
          child: body,
        ),
        drawer: drawer,
      ),
    );
  }
}
