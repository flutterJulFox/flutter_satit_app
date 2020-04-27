import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_satit_app/weekDay.dart';

import 'comPicWeekPage.dart';


class WeekDayPage extends StatefulWidget {

  @override
  _WeekDayPageState createState() => _WeekDayPageState();
}

class _WeekDayPageState extends State<WeekDayPage> {
  DateTime date = DateTime.now( );
  List<WeekDay> weekDay = [
    WeekDay( name: 'Monday', id: 1 ),
    WeekDay( name: 'Tuesday', id: 2 ),
    WeekDay( name: 'Wednesday', id: 3 ),
    WeekDay( name: 'Thursday', id: 4 ),
    WeekDay( name: 'Friday', id: 5 ),
    WeekDay( name: 'Saturday', id: 6 ),
    WeekDay( name: 'Sunday', id: 7 ),
  ];

  Color chooseTextColor(int _day) {
    if (_day == date.weekday) {
      return Colors.blue;
    }
    else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
        weekDay.map((day) => Expanded(
          child:FlatButton(
            padding: EdgeInsets.all(5.0),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    String docID = 'dayIs${day.id}';
//                    print('documentID on weekPage is: $docID');
                    return ComPicWeekPage(docID: docID);
                  },
                ),
              );

            },
            color: Colors.grey[300],
              textColor: chooseTextColor(day.id),
              splashColor: Colors.blueAccent,
              child: Center(
                child:  Text(
                    '${day.name}',
                    style: TextStyle(fontSize: 40.0, )
                ),
              )

          )

        )
        ).toList(),
      );

  }
}
