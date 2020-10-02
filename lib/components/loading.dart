import 'dart:async';

import "package:flutter/material.dart";
import 'package:old/constants/constant.dart';

import 'Error.dart';

class LoadingOrMsg extends StatefulWidget {
  static const wait = 0;
  static const image = 1;
  static const exit = 2;
  static const listtile = 3;
  static const error = 4;

  final int msg;
  LoadingOrMsg(this.msg);
  @override
  _LoadingOrMsgState createState() => _LoadingOrMsgState();
}

//show progress widget or error info widget
class _LoadingOrMsgState extends State<LoadingOrMsg> {
  int _time = 1;

  int ret = LoadingOrMsg.wait;

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
    progress = widget.msg == LoadingOrMsg.image
        ? Image.asset('assets/images/loading.gif')
        : CircularProgressIndicator();
    childWidget = widget.msg == LoadingOrMsg.exit
        ? Center(
            child: NoInternet(),
          )
        : widget.msg == LoadingOrMsg.listtile
            ? Card(
                color: Colors.redAccent,
                elevation: 24.0,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      listTitleError,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    )),
              )
            : widget.msg == LoadingOrMsg.image
                ? Text(imageNotFoundError)
                : Text('Unknown Error');
  }

  void runTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (_time > 0)
          _time--;
        else {
          ret = LoadingOrMsg.error;
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ret == LoadingOrMsg.wait
        ? Center(child: progress)
        : Center(
            child: childWidget,
          );
  }
}
