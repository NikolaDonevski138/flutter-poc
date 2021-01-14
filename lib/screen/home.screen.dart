import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/images.dart';
import '../providers/great_places.dart';
import '../screen/places_list_screen.dart';
import '../widgets/home.dart';
import '../screen/add_place_screen.dart';
import '../screen/create_post.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': Home(), 'title': 'Home'},
    {'page': PlacesListScreen(), 'title': 'Take Picture'},
    {
      'page': CreatePost(),
      'title': 'Create Post',
    }
  ];

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // ChangeNotifierProvider.value(
          //   value: Images(),
          // ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(_pages[_selectedPageIndex]['title']),
            actions: [
              _pages[_selectedPageIndex]['title'] == 'Take Picture'
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddPlaceScreen.routeName);
                      })
                  : Container()
            ],
          ),
          body: _pages[_selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            unselectedItemColor: Colors.purple,
            selectedItemColor: Colors.blue,
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera), title: Text('Camera')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add),title: Text('Add Post'))
            ],
          ),
        ));
  }
}
