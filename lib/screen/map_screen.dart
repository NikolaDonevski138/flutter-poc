import 'package:flutter/material.dart';
import '../helpers/location_helper.dart';

class MapScreen extends StatefulWidget {
  static String routeName = '/map-screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  String _previewImageUrl;
  Map data = {};

  void _showPreview() {
    double lat = data['latitude'];
    double lng = data['longitude'];
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    _showPreview();
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Container(
        height: 500,
        width: double.infinity,
        child: Column(
          children: [
            Image.network(
              _previewImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
