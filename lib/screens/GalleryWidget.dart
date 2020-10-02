import 'package:flutter/material.dart';
import 'package:old/components/imageLoader.dart';
import 'package:old/components/loading.dart';
import '../model/GalleryModel.dart';
import '../components/drawer.dart';

class GalleryWidget extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text("Demo for devstram.mobi"),
      ),
      body: StreamBuilder(
        stream: model.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData)
            return Center(child: LoadingOrMsg("exit"));
          else {
            return ListView.builder(
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
                    return _returnTile(snapshot.data[itemIndex], itemIndex);
                  else {
                    return ListTile(
                      title: Center(
                        child: LoadingOrMsg('listtile'),
                      ),
                    );
                  }
                });
          }
        },
      ),
    );
  }

  Widget _returnTile(ImageModel image, int index) {
    GestureDetector child = GestureDetector(
      child: Container(
        color: index.isEven ? Colors.orange[50] : Colors.green[50],
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 200.0),
              child: Hero(
                child: LoadImage(image.thumb),
                tag: image.id,
              ),
              // width: ,
            ),
            Card(
              elevation: 24.0,
              color: Colors.greenAccent,
              margin: const EdgeInsets.all(12.0),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          image.title,
                          style: TextStyle(fontSize: 28.0),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "by " + image.author,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () => {
        Navigator.pushNamed(context, '/image', arguments: {'item': image}),
      },
    );
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: 1000),
        child: child,
        builder: (BuildContext context, double value, Widget child) {
          return Opacity(
            opacity: value,
            child: ClipRRect(
              child: Padding(
                child: child,
                padding: EdgeInsets.only(left: 50 * (1 - value)),
              ),
            ),
          );
        });
  }
}
