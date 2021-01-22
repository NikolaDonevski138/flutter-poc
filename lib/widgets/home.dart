import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../helpers/apihelper.dart';
import '../models/photos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HttpService httpService = HttpService();
  int currentPage = 1;
  int lastAlbumId;
  Future<List<Photos>> data;

  @override
  void initState() {
    super.initState();
    data = httpService.getPhotos(currentPage);
  }

  _increment() {
    setState(() {
      currentPage = currentPage + 1;
    });
  }

  _decrement() {
    if (currentPage == 1) {
      return;
    }
    setState(() {
      currentPage = currentPage - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(currentPage);
    return Scaffold(
        body: FutureBuilder(
            future: httpService.getPhotos(currentPage),
            builder:
                (BuildContext context, AsyncSnapshot<List<Photos>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                List<Photos> photos = snapshot.data;
                print(photos);
                return Container(
                  height: 400,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Album')),
                              DataColumn(label: Text('id')),
                              DataColumn(label: Text('title')),
                              DataColumn(label: Text('Image'))
                            ],
                            rows: photos
                                .map((e) => DataRow(cells: [
                                      DataCell(Text(e.albumId.toString())),
                                      DataCell(Text(e.id.toString())),
                                      DataCell(Text(e.title.toString())),
                                      DataCell(Image.network(e.url))
                                    ]))
                                .toList(),
                          ),
                        ),
                      ),
                      ListTile(
                          title: Row(
                        children: [
                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            onPressed: _decrement,
                            child: Column(
                              children: [Icon(Icons.navigate_before)],
                            ),
                          ),
                          FlatButton(
                            color: Colors.blue,
                            textColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            onPressed: _increment,
                            child: Column(
                              children: [Icon(Icons.navigate_next)],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                );
              }
            }));
  }
}
