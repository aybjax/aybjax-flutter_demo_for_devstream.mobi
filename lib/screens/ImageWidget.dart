import 'package:flutter/material.dart';
import 'package:old/components/imageLoader.dart';
import 'package:old/model/ImageModel.dart';

class ImageWidget extends StatelessWidget {
  static const ImageRoute = '/image';

  final ImageModel image;
  ImageWidget(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(image.title),
      ),
      body: Container(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: double.infinity,
        ),
        child: Hero(
          tag: image.id,
          child: LoadImage(image.image),
        ),
      ),
    );
  }
}
