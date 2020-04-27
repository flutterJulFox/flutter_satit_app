import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_satit_app/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
import 'package:flutter_satit_app/event.dart';
import 'package:intl/intl.dart';
import 'event_list.dart';


class EventsPage extends StatefulWidget {

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Event>>.value(
      value: DatabaseService().events,
      child: Center(
        child: Scaffold(
            body: EventList(),
             floatingActionButton: FloatingActionButton(
             onPressed: () {
                var format = DateFormat.yMd();
                var date = format.format(DateTime.now());
                String id = Firestore.instance.collection('events').document().documentID;
               DatabaseService(uid: user.uid).addEvent(id, 'Event Name', date);
             },
              backgroundColor: Colors.white,
              hoverColor: Colors.grey[300],
              focusColor: Colors.grey[400],
              splashColor: Colors.grey[500],
              tooltip: 'Add Event',
              child: const Icon(Icons.add,
              size: 50,
              color: Colors.grey),


              ),
      ),


    ),
    );
  }
}

