import 'package:flutter/material.dart';
import 'package:old/model/ImageModel.dart';

import 'columns.dart';

class ReturnTile extends StatefulWidget {
  final ImageModel image;
  final int index;
  final Function ontap;

  ReturnTile(this.image, this.index, this.ontap);

  @override
  _ReturnTileState createState() => _ReturnTileState();
}

//just the backbone of listtiles in listview
class _ReturnTileState extends State<ReturnTile> {
  GestureDetector child;
  @override
  void initState() {
    super.initState();
    child = GestureDetector(
      child: Container(
        color: widget.index.isEven ? Colors.orange[400] : Colors.green[400],
        padding: const EdgeInsets.all(5.0),
        child: CardColumn(widget.image),
      ),
      onTap: () {
        widget.ontap(widget.image);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        key: ValueKey(widget.image.id),
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: 1000),
        child: child,
        builder: (BuildContext context, double value, Widget child) {
          return Opacity(
            opacity: value,
            child: ClipRRect(
              child: Padding(
                child: child,
                padding: EdgeInsets.only(left: 50 * (1 - value)),
              ),
            ),
          );
        });
  }
}
