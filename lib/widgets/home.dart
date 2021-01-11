import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../providers/images.dart';
import '../helpers/apihelper.dart';
import '../models/image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int numberOfItems;
  var dts = DTS();
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;

  _getImages() async {
    var provider = Provider.of<Images>(context, listen: false);
    var response = await APIHelper.getImagesApi();
    if (response.isSuccessful) {
      provider.setImagesList(response.data);
    } else {
      provider.setIsProcessing(false);
    }
  }

  @override
  void initState() {
    _getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
          header: Text('Data Table Header'),
          columns: [
            DataColumn(label: Text('col#1'), tooltip: 'rasd'),
            DataColumn(label: Text('col#2')),
            DataColumn(label: Text('col#3')),
            DataColumn(label: Text('col#4'))
          ],
          source: dts,
          onRowsPerPageChanged: (r) {
            setState(() {
              _rowPerPage = r;
            });
          },
          rowsPerPage: _rowPerPage),
    );
  }
}

class DTS extends DataTableSource {
  DTS();

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('#cel1$index')),
      DataCell(Text('#cel2$index')),
      DataCell(Text('#cel3$index')),
      DataCell(Text('#cel4$index'))
    ]);
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
