import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_satit_app/home.dart';
import 'package:flutter_satit_app/user.dart';
import 'package:flutter_satit_app/weekPage.dart';
import 'package:flutter_satit_app/eventsPage.dart';
import 'package:flutter_satit_app/comPicPage.dart';
import 'package:flutter_satit_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(value: AuthService().user,
    child: MaterialApp(
      title: 'saTit - app for special parents and special children',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage (
          title: 'saTit'
      ),
    ),
    );


  }
  
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  int _currentIndex = 0;
//  final List<Widget> _children = [
//    WeekDayPage(),
//    EventsPage(),
//    ComPicPage()
//  ];
//
//  Color color;
//
//  static const TextStyle optionStyle =
//  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//
//
//  void _onItemTapped(int index) {
//    setState(() {
//      _currentIndex = index;
//
//    });
//  }

  final AuthService _auth = AuthService();

  @override
  void initState() {
    _signInOnStartUp().then((result) {
      if (result != null) {
        print('Ok');
        print(result.uid);
//        print(result.mail);
      } else {
        print('Fail :(');
    }
    });

    // TODO: implement initState
    super.initState();
    }

      @override
  Widget build(BuildContext context) {
//        final user = Provider.of<User>(context);
//        String uid = user.uid;
        return HomePage();
//    return Wrapper(uid);
      }


//    return Scaffold(
//
//      appBar: AppBar(
//
//        title: Text(widget.title),
//      ),
//
//      body: _children[_currentIndex],
//
//
//      bottomNavigationBar: BottomNavigationBar(
//        items: const <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(Icons.calendar_today),
//            title: Text('Week'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.list),
//            title: Text('Events'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.photo),
//            title: Text('comPics'),
//          ),
//        ],
//        currentIndex: _currentIndex,
//        selectedItemColor: Colors.amber[800],
//        onTap: _onItemTapped,
//      ),
//    );
//  }

  Future _signInOnStartUp() {
    return _auth.signInAnon();
  }
}

