import '../../../../cores/components/custom_scaffold_widget.dart';
import 'package:elite/cores/utils/sizer_utils.dart';
import 'package:elite/features/auth/services/auth_services.dart';
import 'package:elite/features/home/views/widgets/home_background_widget.dart';
import 'package:elite/features/home/views/widgets/home_body_widet.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      usePadding: false,
      body: SizedBox(
        height: sizerHeight(100),
        child: Stack(
          children: const <Widget>[
            HomeBackgroundWidget(),
            HomeBodyWidget(),
          ],
        ),
      ),
    );
  }
}
