import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryModel {
  final String thumb;
  final String image;
  final String author;
  final String title;
  final String id;

  GalleryModel(this.id, this.thumb, this.image, this.title, this.author);

  static Future<List<GalleryModel>> fetchAll() async {
    // String url, Function callback) async {
    final url =
        'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';

    print(url);
    final response = await http.get(url);

    List<GalleryModel> list = [];

    final dynamic json = jsonDecode(response.body);
    for (int i = 0; i < json.length; i++) {
      list.add(GalleryModel(json[i]['id'], json[i]['urls']['thumb'],
          json[i]['urls']['regular'], "hello", json[i]['user']['username']));
    }

    return list;
  }
}
