import 'package:flutter/material.dart';
import 'screens/GalleryWidget.dart';
import 'screens/ImageWidget.dart';

void main() {
  runApp(Demo());
}

class Demo extends StatelessWidget {
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
      case GalleryWidget.GalleryRoute:
        screen = GalleryWidget();
        break;
      case ImageWidget.ImageRoute:
        screen = ImageWidget(arguments['item']);
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
