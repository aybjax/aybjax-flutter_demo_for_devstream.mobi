import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'loading.dart';

class LoadImage extends StatefulWidget {
  final String url;

  LoadImage(this.url);
  @override
  _LoadImageState createState() => _LoadImageState();
}

class _LoadImageState extends State<LoadImage> {
  String url;
  Widget child;

  @override
  void initState() {
    super.initState();
    url = widget.url;
    child = CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => LoadingOrMsg(Msg.IMAGE),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
