import 'package:flutter/material.dart';
import 'package:old/model/ImageModel.dart';

import 'imageLoader.dart';

//component for displaying 1 imagemodel in listview
class CardColumn extends StatelessWidget {
  final ImageModel image;

  CardColumn(this.image);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: Key(image.id),
          constraints: BoxConstraints.expand(height: 200.0),
          child: Hero(
            child: LoadImage(image.thumb),
            tag: image.id,
          ),
          // width: ,
        ),
        Card(
          key: Key(image.id + "card"),
          elevation: 24.0,
          color: Colors.greenAccent,
          margin: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      image.title,
                      style: TextStyle(fontSize: 28.0),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "by " + image.author,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
