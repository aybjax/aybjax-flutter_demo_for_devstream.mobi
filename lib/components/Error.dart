import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:old/constants/constant.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text(
          alertTile,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: Text(
          alertContent,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text(
              exitButtonAlert,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
