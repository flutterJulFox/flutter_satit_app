import 'package:flutter_satit_app/comPic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_satit_app/comPicListChoice.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
import 'package:flutter_satit_app/user.dart';
import 'package:flutter_satit_app/weekComPic_list.dart';
import 'package:provider/provider.dart';
import 'audioPlayer.dart';
import 'package:cache_image/cache_image.dart';

import 'comPicWeekPage.dart';


// ignore: must_be_immutable
class WeekTile extends StatefulWidget {
  String docID;
  final ComPic comPic;
  String sqID;

 WeekTile({this.comPic, this.docID, this.sqID});


  @override
  _WeekTileState createState() => _WeekTileState();
}

class _WeekTileState extends State<WeekTile> {
  @override
  Widget build(BuildContext context) {

//    void _showPanel() {
//      showModalBottomSheet(context: context, builder: (context) {
//        return Container(
//          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
//          child: EditTitleForm(docID: widget.comPic.id, title: widget.comPic.title, pic: widget.comPic.pic),
//        );
//      });
//
//    }


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
              widget.comPic.voice == null ? Container():
              IconButton(
                icon: Icon(Icons.speaker),
                onPressed: (){
                  return AudioPlay(path: widget.comPic.voice).play();

                },
              ),
//              IconButton(
//                icon: Icon(Icons.edit),
//                onPressed: (){
//                  return _showPanel();
//                },
//              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
//                  print ('the ID of SQ is: ${widget.sqID}');
                  DatabaseService(uid: user.uid).deleteSq(widget.sqID);
                },
              ),

            ],
          ),

        ),

      ),

    );

  }
}

