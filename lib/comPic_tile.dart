import 'package:flutter_satit_app/audioPlayer.dart';
import 'package:flutter_satit_app/comPic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
import 'package:flutter_satit_app/user.dart';
import 'package:provider/provider.dart';
import 'editPicTitle.dart';
import 'package:cache_image/cache_image.dart';


class ComPicTile extends StatelessWidget {

  final ComPic comPic;
  ComPicTile({this.comPic});

     @override
     Widget build(BuildContext context) {
       User user = Provider.of<User>(context);

       void _showPanel() {
         showModalBottomSheet(context: context, builder: (context) {
           return Container(
             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
             child: EditTitleForm(docID: comPic.id, title: comPic.title, pic: comPic.pic, voice: comPic.voice,),

           );
         });
       }

     return Padding(
         padding: EdgeInsets.only(top: 8.0),
         child: Card(
           margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
           child:
           ListTile(
             leading: Image(
               fit: BoxFit.cover,
               image: CacheImage(comPic.pic),
             ),
             title: Text(comPic.title),
             subtitle: ButtonBar(
               children: <Widget>[
                 comPic.voice == "" ? Container():
                 IconButton(
                   icon: Icon(Icons.speaker),
                   onPressed: (){
                    return AudioPlay(path: comPic.voice).play();
                   },
                 ),
                 IconButton(
                   icon: Icon(Icons.edit),
                   onPressed: (){
                    return _showPanel();
                   },
                 ),
                 IconButton(
                   icon: Icon(Icons.delete),
                   onPressed: (){
                     DatabaseService(uid: user.uid).deletePic(comPic.pic);
                     DatabaseService(uid: user.uid).deletePic(comPic.voice);
                     DatabaseService(uid: user.uid).deleteData(comPic.id);
                   },
                 ),


//                 Text(),

               ],
             ),

//              subtitle: Text ('${comPic.time}'),

           ),


         ),

       );

     }
   }

