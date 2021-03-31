import 'package:flutter/material.dart';

class NavBarItem extends StatefulWidget {
  final String title;
  final Function onPressed;
  final String fontFamily;
  const NavBarItem(
      {@required this.onPressed, @required this.title, this.fontFamily});

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (_) {
        setState(() {
          isHovering = !isHovering;
        });
      },
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: widget.fontFamily != null
                  ? widget.fontFamily
                  : 'ArcadeClassic',
              decoration:
                  isHovering ? TextDecoration.underline : TextDecoration.none),
        ),
      ),
    );
  }
}
