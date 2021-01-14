import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../helpers/apihelper.dart';
import '../helpers/apihelper.dart';
import '../helpers/apihelper.dart';
import '../models/photos.dart';
import 'package:pl_grid/pl_grid.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HttpService httpService = HttpService();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _rowsOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: httpService.getPhotos(),
        builder: (BuildContext context, AsyncSnapshot<List<Photos>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<Photos> photos = snapshot.data;

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
                curPage: 1,
                maxPages: 1,
              ),
            );
          }
        },
      ),
    );
  }
}
