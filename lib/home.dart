

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_satit_app/weekPage.dart';

import 'comPicPage.dart';
import 'eventsPage.dart';

class HomePage extends StatefulWidget {
//  final String title;
//
//  HomePage({this.title});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  HomePage({Key key, this.title}) : super(key: key);
//
//
//final String title;

  int _currentIndex = 0;
  final List<Widget> _children = [
    WeekDayPage(),
    EventsPage(),
    ComPicPage()
  ];

  Color color;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text('saTit'),
      ),

      body: _children[_currentIndex],


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Week'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Events'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            title: Text('comPics'),
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
  }
//}
