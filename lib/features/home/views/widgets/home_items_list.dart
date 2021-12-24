import '../../../../cores/utils/route_name.dart';
import '../../../../cores/utils/sizer_utils.dart';
import 'home_item_widget.dart';
import 'package:flutter/material.dart';

class HomeItemsList extends StatelessWidget {
  const HomeItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        const HomeItemWidget(
          title: 'E Queue',
          routeName: RouteName.eQueueScreen,
          big: true,
        ),
        SizedBox(height: sizerSp(20)),
        const HomeItemWidget(
          title: 'Instant Ride',
          routeName: RouteName.eQueueScreen,
        ),
        SizedBox(height: sizerSp(20)),
        const HomeItemWidget(
          title: 'Bouns Ride',
          routeName: RouteName.eQueueScreen,
        ),
      ],
    );
  }
}
