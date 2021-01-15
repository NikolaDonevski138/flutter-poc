import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pl_grid/pl_grid.dart';

import '../helpers/apihelper.dart';
import '../models/photos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HttpService httpService = HttpService();

  Future<List<Photos>> data;

  @override
  void initState() {
    print('call again');
    //calls this multiple times when route is changed
    super.initState();
    data = httpService.getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<List<Photos>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<Photos> photos = snapshot.data;
            int page;
            return Container(
              height: 700,
              width: double.infinity,
              child: PlGrid(
                headerColumns: ['Album Id', 'id', 'title', 'image'],
                data: photos
                    .map(
                        (e) => [e.albumId, e.id, e.title, Image.network(e.url)])
                    .toList(),
                showSearchBar: false,
                paginationDynamicStyle: (page) => TextStyle(color: Colors.blue),
                applyZebraEffect: false,
                columnWidthsPercentages: <double>[20, 20, 30, 30],
                onPaginationItemClick: (currentPage) {},
                headerStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                curPage: page,
                maxPages: 3,
              ),
            );
          }
        },
      ),
    );
  }
}
