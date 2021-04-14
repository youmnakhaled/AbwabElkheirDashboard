import 'package:flutter/material.dart';

class NavigationBarMobileWidget extends StatelessWidget {
  NavigationBarMobileWidget({@required this.handleDrawer});
  final Function handleDrawer;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
    return Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.filter_alt_rounded, color: Colors.white),
              onPressed: () {
                handleDrawer();
              },
            ),
            Spacer(),
          ]),
    );
  }
}
