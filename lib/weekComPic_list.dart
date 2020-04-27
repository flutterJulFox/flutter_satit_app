import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_satit_app/sq.dart';
import 'package:flutter_satit_app/weekTile.dart';
import 'package:provider/provider.dart';
import 'comPic.dart';
import 'dart:core';
//import 'comPicTileChoice.dart';

class WeekComPicList extends StatefulWidget {

  @override
  _WeekComPicListState createState() => _WeekComPicListState();
}

class _WeekComPicListState extends State<WeekComPicList> {



  @override
  Widget build(BuildContext context) {

    final sQs = Provider.of<List<SQ>>(context) ?? [];
//    final CollectionReference comPicCollection = Firestore.instance.collection('comPics');
//    ComPic comPicFromSnapshot;
    sQs.sort((a, b){
      var aDate = a.timestamp;
      var bDate = b.timestamp;
      return aDate.compareTo(bDate);
    });

    sQs.forEach((sq) {
      print( sq.id );
      print( sq.comPicID );
      print( sq.docID );
      print(sq.timestamp);
    }
      );

      Future<ComPic> _getData (String documentId) async {
      return
        await Firestore.instance.collection('comPics')
          .document(documentId).get().then((DocumentSnapshot picture){
         return
           ComPic(
           pic: picture.data['pic'],
           title: picture.data['title'],
           id: picture.data['id'],
               voice: picture.data['voice']
         );

      });

    }

     return
        ListView.builder(
          itemCount: sQs.length,
          itemBuilder: (context, index) {
            return
                FutureBuilder(
                  future: _getData(sQs[index].comPicID),
                  builder: (context, snapshot){
                    if (!snapshot.hasData){
                      return Center (child: CircularProgressIndicator(),);
                    }else {return
                      WeekTile(
                        comPic: snapshot.data,
                        docID: sQs[index].docID,
                        sqID: sQs[index].id,
                      );
                    }

                  },

                );

          },
        );

  }

}
