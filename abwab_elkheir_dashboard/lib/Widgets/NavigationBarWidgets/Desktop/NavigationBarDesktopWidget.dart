import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Desktop/NavigationBarItem.dart';
import 'package:flutter/material.dart';

class NavigationBarDesktopWidget extends StatefulWidget {
  const NavigationBarDesktopWidget({Key key}) : super(key: key);

  @override
  _NavigationBarDesktopWidgetState createState() =>
      _NavigationBarDesktopWidgetState();
}

class _NavigationBarDesktopWidgetState
    extends State<NavigationBarDesktopWidget> {
  //AuthenticationViewModel auth;
  @override
  void initState() {
    //auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                NavBarItem(
                  title: 'All Cases',
                  onPressed: () {
                    // locator<NavigationService>().navigateTo(HomeRoute);
                    // Navigator.of(context)
                    //     .pushReplacementNamed(HomeScreen.routeName);
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                NavBarItem(
                  title: 'Add Case',
                  onPressed: () {
                    // locator<NavigationService>().navigateTo(StoreRoute);
                    // Navigator.of(context)
                    //     .pushReplacementNamed(ChannelsScreen.routeName);
                  },
                ),
                Spacer(),
                NavBarItem(
                    title: 'Logout',
                    onPressed: () async {
                      {
                        try {
                          //await auth.signOut(context);
                          Navigator.pop(context);
                        } catch (error) {}
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
