import 'dart:async';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class LoadingOrMsg extends StatefulWidget {
  final String msg;
  LoadingOrMsg(this.msg);
  @override
  _LoadingOrMsgState createState() => _LoadingOrMsgState();
}

class _LoadingOrMsgState extends State<LoadingOrMsg> {
  int _time = 1;

  String ret = 'wait';

  Timer _timer;
  Widget childWidget;
  Widget progress;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    runTimer();
    progress = widget.msg == 'image'
        ? Image.asset('assets/images/loading.gif')
        : CircularProgressIndicator();
    childWidget = widget.msg == 'exit'
        ? AlertDialog(
            title: Text(
              "Loading timeout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: Text(
              "Loading is taking too much time.\nCheck internet connection",
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
                  "Exit app",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              // FlatButton(
              //   onPressed: () {
              //     RestartWidget.restartApp(context);
              //   },
              //   child: Text(
              //     "Give another try",
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
            backgroundColor: Colors.cyan,
          )
        : widget.msg == 'listtile'
            ? Card(
                color: Colors.redAccent,
                elevation: 24.0,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Loading error...\nCheck internet Connection",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    )),
              )
            : widget.msg == 'image'
                ? Text('Image has not been Dowloaded')
                : Text('Unknown Error');
  }

  void runTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (_time > 0)
          _time--;
        else
          ret = 'error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ret == 'wait'
        ? Center(child: progress)
        : Center(
            child: childWidget,
          );
  }
}
