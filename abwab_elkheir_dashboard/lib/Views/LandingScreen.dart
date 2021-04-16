import 'package:abwab_elkheir_dashboard/Views/Desktop/LandingScreenDesktop.dart';
import 'package:abwab_elkheir_dashboard/Views/Mobile/LandingScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LandingScreen extends StatefulWidget {
  static final routeName = "/landingScreen";
  final void Function(BuildContext context) onLogin;
  LandingScreen({this.onLogin});
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isFormChanged = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      print(sizingInformation);
      return Scaffold(
        //backgroundColor: ConstantColors.purple,
        body: Container(
          height: deviceSize.height,
          child: ScreenTypeLayout(
            desktop: LandingScreenDesktop(
              deviceSize: deviceSize,
              onLogin: widget.onLogin,
            ),
            tablet: LandingScreenMobile(deviceSize: deviceSize),
            mobile: LandingScreenMobile(deviceSize: deviceSize),
          ),
        ),
      );
    });
  }
}
