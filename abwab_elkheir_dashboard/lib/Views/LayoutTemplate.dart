import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawer.dart';
import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/NavigationBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatefulWidget {
  final Widget child;
  const LayoutTemplate({Key key, this.child}) : super(key: key);
  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  void handleDrawer() {
    _key.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.of(context).size;
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        key: _key,
        backgroundColor: Colors.black,
        drawer: (sizingInformation.deviceScreenType ==
                    DeviceScreenType.mobile ||
                sizingInformation.deviceScreenType == DeviceScreenType.tablet)
            ? NavigationDrawer()
            : null,
        body: Stack(
          children: [
            widget.child,
            NavigationBarWidget(
              handleDrawer: handleDrawer,
            ),
          ],
        ),
      ),
    );
  }
}
