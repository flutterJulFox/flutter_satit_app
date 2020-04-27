import 'package:flutter_satit_app/editEventTile.dart';
import 'package:flutter_satit_app/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'comPicWeekPage.dart';
import 'dataBaseService.dart';
import 'user.dart';

class EventTile extends StatelessWidget{
  final Event event;
  EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    void _showPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
          child: EditEventTitleForm(id: event.id, title: event.title, date: event.date),
        );
      });
    }
    return Padding(
          padding: EdgeInsets.only(top: 8.0),
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(
                    leading: Text(event.date),
                    title: Text(event.title),
                subtitle: ButtonBar(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      splashColor: Colors.blueAccent,
                      onPressed: (){
                        return _showPanel();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        DatabaseService( uid: user.uid ).deleteEvent(
                            event.id );
                        DatabaseService( uid: user.uid, docID: event.id )
                            .deleteNumSq( );
                      }
                    ),
  //                 Text(),

                  ],
                ),
                    onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComPicWeekPage(docID: event.id),
                      ),
                    );
                    },



                ),
            ),
       );
  }
}
