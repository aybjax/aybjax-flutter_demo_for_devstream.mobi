import 'package:old/helper.dart/cutString.dart';

//one card object
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
        cutString(forTitle), json['user']['username']);
  }
}
