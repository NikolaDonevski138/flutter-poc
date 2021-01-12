import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screen/map_screen.dart';
import 'map_screen.dart';
import 'map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    final double latitude = selectedPlace.location.latitude;
    final double longitude = selectedPlace.location.longitude;

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(children: <Widget>[
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          selectedPlace.location.address,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton(
            child: Text('View on map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              //   Navigator.of(context).pushReplacementNamed(
              //     MapScreen.routeName,
              //     arguments: {'selectedPlace': selectedPlace},
              //   );
              // },
              Navigator.pushReplacementNamed(context, MapScreen.routeName,
                  arguments: {'latitude': latitude, 'longitude': longitude});
            })
      ]),
    );
  }
}
