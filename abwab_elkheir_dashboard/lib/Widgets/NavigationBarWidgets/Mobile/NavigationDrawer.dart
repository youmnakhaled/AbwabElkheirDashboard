import 'package:flutter/material.dart';

import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawerHeader.dart';
import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawerItem.dart';

import 'package:vrouter/vrouter.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 20,
      child: Container(
        width: 240,
        height: deviceSize.height,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.white30,
            blurRadius: 16,
          )
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            NavigationDrawerHeader(),
            SizedBox(
              height: 50,
            ),
            DrawerItem(
              title: 'الحالات ',
              icon: Icons.home,
              onPressed: () {
                context.vRouter.pushReplacement("/cases");
              },
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              width: 160,
              child: Divider(
                thickness: 1.0,
                color: Colors.black54,
              ),
            ),
            DrawerItem(
                title: ' اضافة حالة',
                icon: Icons.shopping_cart_rounded,
                onPressed: () {
                  context.vRouter.pushReplacement("/addCase");
                }),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              width: 160,
              child: Divider(
                thickness: 1.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
