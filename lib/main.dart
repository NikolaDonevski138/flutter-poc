import 'package:flutter/material.dart';
import './screen/login.screen.dart';
import './screen/home.screen.dart';
import './screen/add_place_screen.dart';
import './screen/places_list_screen.dart';
import './providers/great_places.dart';
import 'package:provider/provider.dart';
import './screen/place_detail_screen.dart';
import './screen/map_screen.dart';
import 'screen/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
            // PlacesListScreen.routeName: (ctx) => PlacesListScreen(),
            PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
            MapScreen.routeName: (ctx) => MapScreen()
          }),
    );
  }
}
