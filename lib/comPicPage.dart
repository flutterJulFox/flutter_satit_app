import 'package:flutter_satit_app/imageService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
//import 'package:flutter_satit_app/imageService.dart';
import 'package:flutter_satit_app/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_satit_app/comPic_list.dart';
import 'package:flutter_satit_app/comPic.dart';

class ComPicPage extends StatefulWidget {

  @override
  _ComPicPageState createState() => _ComPicPageState();
}

class _ComPicPageState extends State<ComPicPage> {

  BoxDecoration myBoxDecoration() {
    return BoxDecoration( shape: BoxShape.circle );
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

//    void _showPanel(){
//      showModalBottomSheet(context: context, builder: (context){
//        return Container(
//          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
//          child: ButtonBar(
//            alignment: MainAxisAlignment.spaceAround,
//
//            children: <Widget>[
//              IconButton(
//                onPressed: (){},
//                icon: Icon(Icons.camera_alt),
//                iconSize: 40.0,
//              ),
//              IconButton(
//                onPressed: (){},
//                icon: Icon(Icons.folder),
//                iconSize: 40.0,
//              )
//            ],
//          ),
//        );
//      });
//    }

    return StreamProvider<List<ComPic>>.value(
        value: DatabaseService().comPics,

        child: Center(

            child: Scaffold(
              body: ComPicList(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  String docID = Firestore.instance.collection('comPics').document().documentID;
                  Upload(uid: user.uid, docID: docID).uploadPic();
              },

                backgroundColor: Colors.white,
                hoverColor: Colors.grey[300],
                focusColor: Colors.grey[400],
                splashColor: Colors.grey[500],
                tooltip: 'Add Picture',
                child: const Icon(Icons.add,
                  size: 50,
                  color: Colors.grey),
              ),


          ),


        ),
      );
  }
}
