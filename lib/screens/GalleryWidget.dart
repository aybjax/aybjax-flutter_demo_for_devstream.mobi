import 'package:flutter/material.dart';
import '../model/GalleryModel.dart';
import '../components/drawer.dart';

class GalleryWidget extends StatefulWidget {
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  Future data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  getData() async {
    return await GalleryModel.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text("Demo for devstram.mobi"),
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
              if (index.isOdd)
                return Divider(
                  color: Colors.black,
                  height: 0.0,
                  thickness: 2.0,
                );

              final itemIndex = index ~/ 2;

              if (itemIndex == snapshot.data.length - 1)
                setState(() {
                  data = getData();
                  return null;
                });
              ;
              return _returnTile(snapshot.data[itemIndex], itemIndex);
            });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _returnTile(GalleryModel model, int index) {
    return GestureDetector(
      child: Container(
        color: index.isEven ? Colors.orange[50] : Colors.green[50],
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 200.0),
              child: Image.network(model.thumb,
                  loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : Center(child: CircularProgressIndicator());
              }),
              // width: ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.title,
                  style: TextStyle(fontSize: 28.0),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "by " + model.author,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          ],
        ),
      ),
      onTap: () => {
        Navigator.pushNamed(context, '/image', arguments: {'item': model}),
      },
    );
  }
}
