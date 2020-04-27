import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
import 'package:flutter_satit_app/sq.dart';
//import 'package:flutter_satit_app/user.dart';
import 'package:flutter_satit_app/weekComPic_list.dart';
import 'package:provider/provider.dart';
import 'comPicChoicePage.dart';

class ComPicWeekPage extends StatefulWidget {
  String docID;
  ComPicWeekPage ({this.docID});

  @override
  _ComPicWeekPageState createState() => _ComPicWeekPageState();
}

class _ComPicWeekPageState extends State<ComPicWeekPage> {

  BoxDecoration myBoxDecoration() {
    return BoxDecoration( shape: BoxShape.circle );
  }

  @override
  Widget build(BuildContext context) {

//    final user = Provider.of<User>(context);
//    print('docID from compicWeekPage is: ${widget.docID}');

    return StreamProvider<List<SQ>>.value(
      value: DatabaseService(docID: '${widget.docID}').sq,

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
          body: WeekComPicList(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ComPicChoicePage(docID: widget.docID),
                  ),
              );
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
