import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_satit_app/comPic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
import 'package:flutter_satit_app/user.dart';
import 'package:provider/provider.dart';
import 'package:cache_image/cache_image.dart';


// ignore: must_be_immutable
class ComPicTileChoice extends StatefulWidget {
  String docID;
  final ComPic comPic;

  ComPicTileChoice({this.comPic, this.docID});

  @override
  _ComPicTileChoiceState createState() => _ComPicTileChoiceState();
}

class _ComPicTileChoiceState extends State<ComPicTileChoice> {
  @override
  Widget build(BuildContext context) {



      User user = Provider.of<User>(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child:
        ListTile(
          leading: Image(
            fit: BoxFit.cover,
            image: CacheImage(widget.comPic.pic),
          ),
          title: Text(widget.comPic.title),
          subtitle: ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(
                    Icons.add_circle_outline),
//                iconSize: 35,
                onPressed: (){
                  String id = Firestore.instance.collection('sq').document().documentID;
//                  Firestore.instance.collection('sq').where('docID', isEqualTo: widget.docID).getDocuments().then((num){
//                  DatabaseService(uid: user.uid).addSq(id, widget.comPic.id, widget.docID, num.documents.length + 1);});
                  DatabaseService(uid: user.uid).addSq(id, widget.comPic.id, widget.docID);
                  Navigator.pop(context,
                          () {
                    setState(() {});
                  }
                  );
                },
              ),

            ],
          ),

        ),

      ),

    );

  }
}

