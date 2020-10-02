import 'package:flutter/material.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({Key key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/1.jpeg'),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("Aibat Zhakeyev"),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue[400],
              ),
            ),
            ListTile(
              title: Text(
                'aybat93@gmail.com',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                '+7-777-889-66-01 (Telegram)',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
