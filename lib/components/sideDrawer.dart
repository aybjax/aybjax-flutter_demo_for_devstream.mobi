import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//about info
class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                    backgroundImage: AssetImage('assets/images/me.jpg'),
                    radius: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("Aibat Zhakeyev"),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
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
            ListTile(
              title: Text(
                'github.com/aybjax',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pop(context);
                launchURL('https://github.com/aybjax');
              },
            ),
            ListTile(
              title: Text(
                'aybat.host20.uk/resume',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pop(context);
                launchURL('http://aybat.host20.uk/resume');
              },
            ),
            ListTile(
              title: Text(
                'LINK TO THIS APP IN GITHUB',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pop(context);
                launchURL(
                    'https://github.com/aybjax/aybjax-flutter_demo_for_devstream.mobi');
              },
            ),
          ],
        ),
      ),
    );
  }
}
