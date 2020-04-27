import 'package:flutter/material.dart';
import 'package:flutter_satit_app/comPic.dart';
import 'package:provider/provider.dart';
import 'package:flutter_satit_app/comPic_tile.dart';

import 'comPicTileChoice.dart';

// ignore: must_be_immutable
class ComPicListChoice extends StatefulWidget {
  String docID;
  ComPicListChoice ({this.docID});
  @override
  _ComPicListChoiceState createState() => _ComPicListChoiceState();
}

class _ComPicListChoiceState extends State<ComPicListChoice> {
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
        return ComPicTileChoice(
          comPic: comPics[index],
          docID: widget.docID,
        );
      },
    );
  }
}

