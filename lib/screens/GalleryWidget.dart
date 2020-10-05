import 'package:flutter/material.dart';
import 'package:old/components/loading.dart';
import 'package:old/components/tiles.dart';
import 'package:old/constants/constant.dart';
import 'package:old/model/ImageModel.dart';
import 'package:old/screens/ImageWidget.dart';
import '../model/GalleryModel.dart';
import '../components/drawer.dart';

class GalleryWidget extends StatefulWidget {
  static const GalleryRoute = '/';

  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  final controller = ScrollController();

  GalleryModel model;

  int urlPage = 1;

  int currentIndex = 0;
  bool animate = true;

  @override
  void initState() {
    super.initState();
    model = GalleryModel();
    model.fetchPage(urlPage);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          urlPage++;
        });
        model.fetchPage(urlPage);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Function ontap = (
    BuildContext context,
  ) {
    return (ImageModel image) {
      Navigator.pushNamed(context, ImageWidget.ImageRoute,
          arguments: {'item': image});
    };
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(appName),
      ),
      body: StreamBuilder(
        stream: model.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData)
            return Center(child: LoadingOrMsg(Msg.EXIT));
          else {
            return RefreshIndicator(
              onRefresh: () {
                setState(() {
                  urlPage++;
                });
                model.fetchPage(urlPage);
                return Future.value();
              },
              child: ListView.builder(
                  controller: controller,
                  itemCount: snapshot.data.length * 2 + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index.isOdd)
                      return Divider(
                        color: Colors.black,
                        height: 0.0,
                        thickness: 2.0,
                      );

                    final itemIndex = index ~/ 2;
                    if (itemIndex < snapshot.data.length)
                      return ReturnTile(
                          snapshot.data[itemIndex], itemIndex, ontap(context));
                    else {
                      return ListTile(
                        title: Center(
                          child: LoadingOrMsg(Msg.LISTTILE),
                        ),
                      );
                    }
                  }),
            );
          }
        },
      ),
    );
  }
}
