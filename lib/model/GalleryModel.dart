import 'package:http/http.dart' as http;
import 'package:old/constants/constant.dart';
import 'dart:convert';
import 'dart:async';

import 'ImageModel.dart';

//class with collection of imageModels
//do the business logic for models
class GalleryModel {
  Stream<List<ImageModel>> stream;
  bool fetching;
  StreamController<List<dynamic>> _controller;
  List<dynamic> _data;
  GalleryModel() {
    _data = List<dynamic>();
    _controller = StreamController<List<dynamic>>.broadcast();
    fetching = false;
    stream = _controller.stream.map((origData) {
      return origData.map((dynamic newData) {
        return ImageModel.fromJson(newData);
      }).toList();
    });
  }

  //used on refresh
  void refreshData() {
    _data = [];
  }

  //fetching batch of data
  Future<void> fetchPage(int urlPage) {
    //requested orientation has no effect
    if (fetching) {
      return Future.value();
    }

    fetching = true;

    return http.get(urlHalf + urlPage.toString()).then((response) {
      fetching = false;
      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(response.body);
        _data.addAll(json);
        _controller.add(_data);
      }
    });
  }
}
