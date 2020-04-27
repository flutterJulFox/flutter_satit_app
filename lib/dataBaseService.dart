import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:flutter_satit_app/comPic.dart';
import 'package:flutter_satit_app/event.dart';
import 'package:flutter_satit_app/sq.dart';
import 'package:flutter_satit_app/user.dart';
import 'package:path/path.dart' as Path;


class DatabaseService {
//property
  final String uid;
  final String docID;
  //constructor
  DatabaseService({this.uid, this.docID});

  //collection references
  final CollectionReference comPicCollection = Firestore.instance.collection('comPics');
  final CollectionReference eventCollection = Firestore.instance.collection('events');
  final CollectionReference sqCollection = Firestore.instance.collection('sq');
//Method(?)
// ß

  Future<void> updateComPic(String pic, String title, DateTime time, String docID, String voice) async{

    return await comPicCollection.document('$docID').setData({
      'pic': pic,
      'title': title,
      'time': time,
      'id': docID,
      'voice': voice
    }
    );
  }

  //create list from snapshot
  List <ComPic> _comPicListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
     return ComPic (
       pic: doc.data['pic'] ??'',
       title: doc.data['title'] ?? '',
       id: doc.data['id'] ?? '',
       voice: doc.data['voice'] ?? ''
     );
    }).toList();
  }

// user Data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      title: snapshot.data['title']
    );
  }
//get record's stream as list
Stream<List<ComPic>> get comPics {
    return comPicCollection.snapshots().map(_comPicListFromSnapshot);
}

  List<SQ> _sqListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return SQ (
        id: doc.data['id'] ??'',
        comPicID: doc.data['comPic'] ?? '',
        docID: doc.data['docID'] ?? '',
//        recNum: doc.data['recNum'] ?? '',
        timestamp: doc.data['timeStamp'] ?? ''
      );
    }).toList();

  }

  Stream<List<SQ>> get sq {
    return sqCollection.where('docID', isEqualTo: '$docID').snapshots().map(_sqListFromSnapshot);
  }
//  Stream<List<SQ>> get sq {
//    return sqCollection.where('docID', isEqualTo: '$docID').orderBy('timeStamp', descending: false).snapshots().map(_sqListFromSnapshot);
//  }

//get user doc stream

Stream<UserData> get userData {
    return comPicCollection.document(uid).snapshots().map(_userDataFromSnapshot);
    
}

  Stream<List<Event>> get events {
    return eventCollection.snapshots().map(_eventListFromSnapshot);
  }

  List <Event> _eventListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Event (
        id: doc.data['id'] ??'',
        title: doc.data['title'] ?? '',
        date: doc.data['date'] ?? ''

      );
    }).toList();
  }

  Future<void> addEvent (String id, String title, String date) async{
    return await eventCollection.document('$id').setData({
      'id': id,
      'title': title,
      'date': date,

    }
    );
  }

  Future<void> updateEvent(String id, String title, String date) async{

    return await eventCollection.document('$id').setData({
      'id': id,
      'title': title,
      'date': date
    }
    );
  }

Future<void> addRecord (String pic, String title, DateTime time, String docID) async{
    return await comPicCollection.document('$docID').setData({
      'pic': pic,
      'title': title,
      'time': time,
     'id': docID,
//return print('title is: $title . id is:  $id . time is: $time');

  }
  );
}

  Future<void> deleteData(String docID) async{

    return await comPicCollection.document('$docID').delete();
  }

  Future<void> deleteEvent(String docID) async{

    return await eventCollection.document('$docID').delete();
  }

  Future<void> deleteSq(String sqID) async{
    return await sqCollection.document('$sqID').delete();
  }

  Future<void> deleteNumSq() async{
    return await sqCollection.where('docID', isEqualTo: docID).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
  }

  Future<void> deletePic(String pic) async{
    print(pic);

    var fileUrl = Path.basename(pic).split('?')[0];
//    print(fileUrl);
//    pic.replaceAll(new
//    RegExp(r'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/default_images%2F'), '').split('?')[0];
//    Uri.decodeFull(Path.basename(pic)).replaceAll(new RegExp(r'(\?alt).*'), '');

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
//    return await comPicCollection.document('$docID').delete();
  }

  Future<void> addSq (String id, String comPicID, String docID) async{

    return await sqCollection.document('$id').setData({
      'id': id,
      'comPic': comPicID,
      'docID': docID,
      'timeStamp': DateTime.now()
//return print('title is: $title . id is:  $id . time is: $time');

    }
    );
  }


}
