import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ImageModel {
  final String thumb;
  final String image;
  final String author;
  final String title;
  final String id;
  ImageModel(this.id, this.thumb, this.image, this.title, this.author);
  factory ImageModel.fromJson(dynamic json) {
    String forTitle = '';
    if (json.containsKey('sponsorship') &&
        json['sponsorship'] != null &&
        json['sponsorship'].containsKey('tagline') &&
        json['sponsorship']['tagline'] != null &&
        json['sponsorship']['tagline'] != '') {
      forTitle = json['sponsorship']['tagline'];
    } else if (json.containsKey('description') && json['description'] != null) {
      forTitle = json['description'];
    } else if (json.containsKey('alt_description') &&
        json['alt_description'] != null &&
        json['alt_description'] != '') {
      forTitle = json['alt_description'];
    } else {
      forTitle = 'No title';
    }
    return ImageModel(json['id'], json['urls']['thumb'], json['urls']['small'],
        forTitle, json['user']['username']);
  }
}

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

  Future<void> fetchPage(int urlPage) {
    // String url, Function callback) async {
    final url =
        'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0&orientation=portrait&per_page=10&page=';

    if (fetching) {
      return Future.value();
    }

    fetching = true;

    return http.get(url + urlPage.toString()).then((response) {
      fetching = false;
      if (response.statusCode == 200) {
        final dynamic json = jsonDecode(response.body);
        _data.addAll(json);
        _controller.add(_data);
      }
    });
  }
}
