import 'package:flutter/material.dart';

class NavigationDrawerHeader extends StatelessWidget {
  const NavigationDrawerHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
        // color: primaryColor,
        alignment: Alignment.center,
        child: Image.asset('assets/logo.png'));
  }
}
