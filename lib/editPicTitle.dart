import 'package:flutter/material.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
import 'package:flutter_satit_app/soundService.dart';
import 'package:flutter_satit_app/user.dart';
//import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';


class EditTitleForm extends StatefulWidget {
  final String docID;
  final String title;
  final String pic;
  final String voice;
  final LocalFileSystem localFileSystem;

//  const EditTitleForm({this.docID, this.title, this.pic, this.localFileSystem});
  const EditTitleForm({this.localFileSystem, this.docID, this.title, this.pic, this.voice});

  @override
  _EditTitleFormState createState() => _EditTitleFormState();
}

class _EditTitleFormState extends State<EditTitleForm> {

  final _formKey = GlobalKey<FormState>();
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  String voiceFileUrl;
  String fileURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  // form value
  DateTime _time;
  String _title;
  bool _canShowButton = false;
  bool _isVisible = true;

//  FlutterSound flutterSound = new FlutterSound();

//  String _pic;
//  User user;

  void showToast(){
    setState(() {
      _isVisible = !_isVisible;
    });
  }


  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    String uid = user.uid;

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
                            onChanged: (val) => setState( () {
                              _title = val;
                            _canShowButton = true;}),
                          ),
                          SizedBox( height: 10.0 ),
                          Visibility(
                            visible: _isVisible,
                            child:  IconButton(
                              onPressed: () {
//                                if(_canShowButton = true){
//                                  setState(() {
//                                    _canShowButton = false;
//                                  });}
                                showToast();
                                _start();
                              },
                              icon: Icon(Icons.record_voice_over),),
                            replacement:     IconButton(
                              onPressed: () {
                                _stop(uid);
                              },
                              icon: Icon(Icons.stop),),
                          ),

                          SizedBox( height: 10.0 ),
                          Center(
                            child:  _canShowButton
                                ?  RaisedButton(
                              color: Colors.blue[500],
                                  child: Text( 'Update',
                                  style: TextStyle( color: Colors.white ) ),

                              onPressed: () async {

                                    if (_formKey.currentState.validate( )){
                                      if( voiceFileUrl != null) {
                                        fileURL = await UploadSound(
                                            uid: uid, path: voiceFileUrl )
                                            .uploadSound( )
                                            .then( (urlVoice) {
                                          return (urlVoice).toString( );
                                        } );
                                        if (fileURL != null) {
                                          await DatabaseService(
                                              docID: widget.docID )
                                              .updateComPic(
                                              widget.pic,
                                              _title ?? widget.title,
                                              _time ?? DateTime.now( ),
                                              widget.docID,
                                              fileURL
                                          );
                                          print(
                                              'and now we are out: $fileURL' );
                                        }
                                      }else{
                                          await DatabaseService(docID: widget.docID).updateComPic(
                                              widget.pic,
                                              _title ?? widget.title,
                                              _time ?? DateTime.now(),
                                              widget.docID,
                                              widget.voice);
                                        }

                                    Navigator.pop(context);}

//                                  print('from Update button: $voiceFileUrl and $fileUrl');

                              },
                            )
                                  : SizedBox(),
                          ),
                        ]
                        ),
                      );

                  }
//                );
  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {

    if(_canShowButton = true){
      setState(() {
        _canShowButton = false;
      });}

    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
      print("Recording...");
    } catch (e) {
      print(e);
    }
  }

  _stop(String uid) async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    _canShowButton = true;
    showToast();
    voiceFileUrl = result.path;

    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
    return voiceFileUrl;

  }
}



