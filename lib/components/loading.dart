import 'dart:async';

import "package:flutter/material.dart";
import 'package:old/constants/constant.dart';

import 'Error.dart';

enum Msg {
  WAIT,
  IMAGE,
  EXIT,
  LISTTILE,
  ERROR,
}

class LoadingOrMsg extends StatefulWidget {
  final Msg msg;
  LoadingOrMsg(this.msg);
  @override
  _LoadingOrMsgState createState() => _LoadingOrMsgState();
}

//show progress widget or error info widget
class _LoadingOrMsgState extends State<LoadingOrMsg> {
  int _time = 1;

  Msg ret = Msg.WAIT;

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
    progress = widget.msg == Msg.IMAGE
        ? Image.asset('assets/images/loading.gif')
        : CircularProgressIndicator();
    childWidget = widget.msg == Msg.EXIT
        ? Center(
            child: NoInternet(),
          )
        : widget.msg == Msg.LISTTILE
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
            : widget.msg == Msg.IMAGE
                ? Text(imageNotFoundError)
                : Text('Unknown Error');
  }

  void runTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (_time > 0)
          _time--;
        else {
          ret = Msg.ERROR;
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ret == Msg.WAIT
        ? Center(child: progress)
        : Center(
            child: childWidget,
          );
  }
}
