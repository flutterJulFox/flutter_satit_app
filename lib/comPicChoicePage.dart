import 'package:flutter_satit_app/comPicListChoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
//import 'package:flutter_satit_app/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_satit_app/comPic.dart';

// ignore: must_be_immutable
class ComPicChoicePage extends StatefulWidget {
  String docID;
  ComPicChoicePage({this.docID});

  @override
  _ComPicChoicePageState createState() => _ComPicChoicePageState();
}

class _ComPicChoicePageState extends State<ComPicChoicePage> {

  BoxDecoration myBoxDecoration() {
    return BoxDecoration( shape: BoxShape.circle );
  }

  @override
  Widget build(BuildContext context) {

//    final user = Provider.of<User>(context);

    return StreamProvider<List<ComPic>>.value(
      value: DatabaseService().comPics,

      child: Center(
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () { Navigator.pop(context); },
                );
              },
            ),
          ),
          body: ComPicListChoice(docID: widget.docID),

        ),


      ),
    );
  }
}
