import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  const DrawerItem(
      {@required this.title, @required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(icon),
              SizedBox(width: 30),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          )),
    );
  }
}
