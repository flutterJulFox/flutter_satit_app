import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class EventsPageOld extends StatelessWidget {
  EventsPageOld();
  final List<String> entries = <String>['eventEventeventEvent A', 'event B', 'event C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  BoxDecoration myBoxDecoration() {
    return BoxDecoration( shape: BoxShape.circle );
  }

  @override
  Widget build(BuildContext context) {
    return
      Center(

          child:
          Column(
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
//          Row(
//            children:<Widget>[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(1),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      // children: <Widget>[
                      Container(
                        //height: 50,
                        color: Colors.grey[350],
                        //Colors.amber[colorCodes[index]],
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget>[
                              Column (children: <Widget>[
                                Text(' ${entries[index]}',
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      //height: 6,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)
                                ),
//                              Center(
//                                  child: Text(' ${entries[index]}')
//                              ),
                              ],
                              ),
                              Column (
                                children:<Widget>[
                                  Row(
                                    children: <Widget>[
                                      MaterialButton(
                                          child: Icon(Icons.edit,
                                              size: 40),
                                          onPressed: (){},
                                          padding: const EdgeInsets.all(2)
                                      ),
                                      MaterialButton(
                                          child: Icon(Icons.delete,
                                              size: 40),
                                          onPressed: (){},
                                          padding: const EdgeInsets.all(2)
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ]
                        ),
                      );


//                  Container(
//                  height: 50,
//                  color: Colors.amber[500],
//                  child: const Center(child: Text('Entry B')
//                  ),
//                  ),
//                  Container(
//                  height: 50,
//                  color: Colors.amber[100],
//                  child: const Center(child: Text('Entry C')),
//                  ),
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  // ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[

//                  FlatButton(
//                    shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(1000.0),
//                        side: BorderSide(color: Colors.grey)),
//                    color: Colors.white,
//                    //textColor: Colors.red,
//                    padding: EdgeInsets.all(8.0),
//                    onPressed: () {},
//                    child: Icon(Icons.add),
//                    child: Text(
//                      "Add to Cart".toUpperCase(),
//                      style: TextStyle(
//                        fontSize: 14.0,
//                      ),
//                    ),
//                  ),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child:
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                      RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                            side: BorderSide(color: Colors.grey[300])
                        ),
                        onPressed: () {},
                        color: Colors.white,
                        textColor: Colors.grey[500],

                        padding: EdgeInsets.all(5.0),
                        child:
                        Icon(
                          Icons.add,
                          size: 50,

                        ),


                        //                    Text("Buy now".toUpperCase(),
                        //                        style: TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),


                ],
              ),
              // ],
              //   ),
            ],
          )
      );
  }
}
