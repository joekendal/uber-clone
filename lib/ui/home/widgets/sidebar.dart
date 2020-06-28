import 'package:flutter/material.dart';

class UberSidebar extends StatelessWidget {
  const UberSidebar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      minRadius: 25,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 35,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      'John Appleseed',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Do more with your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Get food delivery',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
          _SidebarMenuItem(text: 'Your trips'),
          _SidebarMenuItem(text: 'Help'),
          _SidebarMenuItem(text: 'Payment'),
          _SidebarMenuItem(text: 'Get discounts'),
          _SidebarMenuItem(text: 'Settings'),
        ],
      ),
    );
  }
}

class _SidebarMenuItem extends StatelessWidget {
  final String text;
  const _SidebarMenuItem({
    Key key,
    String text,
  })  : this.text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 17),
      ),
      onTap: () {},
    );
  }
}
