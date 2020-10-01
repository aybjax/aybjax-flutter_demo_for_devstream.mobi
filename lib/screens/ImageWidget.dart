import 'package:flutter/material.dart';
import 'package:old/model/GalleryModel.dart';

class ImageWidget extends StatelessWidget {
  final GalleryModel model;
  const ImageWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: Container(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: double.infinity,
        ),
        child: Image.network(
          model.image,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            return loadingProgress == null
                ? child
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
