class SelectRiderScreen extends StatelessWidget {
  const SelectRiderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      usePadding: false,
      body: LiquidSwipe(
        pages: const <Widget>[
          EQueueWidget(),
          InstantRideWidget(),
        ],
      ),
    );
  }
}
