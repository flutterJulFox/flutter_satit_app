import 'package:flutter/material.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
import 'package:intl/intl.dart';

class EditEventTitleForm extends StatefulWidget {
  final String id;
  final String title;
  final String date;

  const EditEventTitleForm({this.id, this.title, this.date});

  @override
  _EditEventTitleFormState createState() => _EditEventTitleFormState();
}

class _EditEventTitleFormState extends State<EditEventTitleForm> {

  final _formKey = GlobalKey<FormState>();
  String _title;
  String _date = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column( children: <Widget>[
        TextFormField(
          initialValue: widget.title,
          decoration: InputDecoration(
              hintText: 'Enter the Title',
              fillColor: Colors.grey[100],
              filled: true,
              contentPadding: EdgeInsets.all( 12.0 ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.blueGrey, width: 2.0 ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue, width: 2.0 )
              )
          ),
          validator: (val) =>
          val.isEmpty
              ? 'Please enter title'
              : null,
          onChanged: (val) => setState( () => _title = val ),
        ),

        SizedBox( height: 10.0 ),
        RaisedButton(
          color: Colors.blue[500],
          child: Text( 'Update',
              style: TextStyle( color: Colors.white ) ),
          onPressed: () async {
            if (_formKey.currentState.validate( )){
              await DatabaseService(docID: widget.id).updateEvent(
                widget.id,
                _title ?? widget.title,
                _date ?? widget.date,

              );
              Navigator.pop(context);

            }

          },

        ),

      ]
      ),
    );

  }
//                );
}