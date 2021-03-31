import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawerHeader.dart';
import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawerItem.dart';
import 'package:flutter/material.dart';

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
              title: 'All Cases',
              icon: Icons.home,
              onPressed: () {
                // Navigator.of(context)
                //     .pushReplacementNamed(HomeScreen.routeName);
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
                title: 'Add Case',
                icon: Icons.shopping_cart_rounded,
                onPressed: () {
                  // Navigator.of(context)
                  //     .pushReplacementNamed(ChannelsScreen.routeName);
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
