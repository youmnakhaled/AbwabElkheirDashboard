import 'package:abwab_elkheir_dashboard/Constants/ConstantColors.dart';
import 'package:abwab_elkheir_dashboard/Views/Desktop/AddHasadScreenDesktop.dart';
import 'package:abwab_elkheir_dashboard/Views/Mobile/AddHasadScreenMobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddHasadScreen extends StatefulWidget {
  static final routeName = "/AddHasad";

  @override
  _AddHasadScreen createState() => _AddHasadScreen();
}

class _AddHasadScreen extends State<AddHasadScreen> {
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
        backgroundColor: ConstantColors.purple,
        body: Container(
          height: deviceSize.height,
          child: ScreenTypeLayout(
            desktop: AddHasadScreenDesktop(deviceSize: deviceSize),
            tablet: AddHasadScreenDesktop(deviceSize: deviceSize),
            mobile: AddHasadScreenMobile(deviceSize: deviceSize),
          ),
        ),
      );
    });
  }
}
