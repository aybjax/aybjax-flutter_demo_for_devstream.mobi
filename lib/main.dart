import 'package:flutter/material.dart';
import 'screens/GalleryWidget.dart';
import 'screens/ImageWidget.dart';

const GalleryRoute = '/';
const ImageRoute = '/image';

void main() {
  runApp(Demo());
}

class Demo extends StatelessWidget {
  const Demo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
    );
  }
}

RouteFactory _routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case GalleryRoute:
        screen = GalleryWidget();
        break;
      case ImageRoute:
        screen = ImageWidget(arguments['item']);
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
