import 'package:flutter/material.dart';
import 'package:flutter_satit_app/comPic.dart';
import 'package:provider/provider.dart';
import 'package:flutter_satit_app/comPic_tile.dart';

class ComPicList extends StatefulWidget {
  @override
  _ComPicListState createState() => _ComPicListState();
}

class _ComPicListState extends State<ComPicList> {
  @override
  Widget build(BuildContext context) {

    final comPics = Provider.of<List<ComPic>>(context) ?? [];

    comPics.forEach((pic){
     print(pic.title);
     print(pic.id);
     print(pic.pic);
     print(pic.voice);
    });

    return ListView.builder(
      itemCount: comPics.length,
      itemBuilder: (context, index) {
      return ComPicTile(
          comPic: comPics[index],
      );
    },
    );
  }
}

