import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class DataBase extends StatefulWidget {
  @override
  _DataBaseState createState() => new _DataBaseState();
}


  class _DataBaseState extends State<DataBase> {
    List _comPic = [];


    void initState() {
      // TODO: implement initState
      super.initState();

      GetItemsFromDb.getItems().then((list){
        print("Now the list is here");
        setState(() {
          for (int i=0; i < list.length; i++) {
            Map<String, dynamic> map = list[i];

            ComPic comPic = new ComPic.fromMap(map);
            _comPic.add(comPic);
          }
        });

      });
    }

//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    throw UnimplementedError();
//  }

    @override
    Widget build(BuildContext context) {
      var itemTile = new ListTile(
        title: new Text("$_comPic"),
      );

      return
//
//        new ListView(
//          children: <Widget>[itemTile
//          ],
//        );

        new Scaffold(
        appBar: new AppBar(
          title: new Text("App Bar Title"),
        ),
        body: new ListView(
          children: <Widget>[
            itemTile,
          ],
        ),
      );
    }





}

class ComPic {
  String title;
  String enterTime;


  // empty constructor
  ComPic();

  // constructor for firebase databases
  ComPic.fromMap(Map<String, dynamic> map){
    title = map["title"];
    //  enterTime  = map["date"];
  }
}
class GetItemsFromDb {
          static Future<List> getItems( ) async {
            Completer <List> completer = new Completer<List>();

          FirebaseDatabase.instance
                .reference()
                .child('picID')
                .once()
                .then( (DataSnapshot snapshot) {
             print(snapshot.value);
              List map = snapshot.value;
              completer.complete(map);
            } );

            return completer.future;
          }
        }



