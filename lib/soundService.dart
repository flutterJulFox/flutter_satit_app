import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class UploadSound {

  String uid;
  String docID;
  String path;

  UploadSound({this.uid, this.docID, this.path});


  Future uploadSound() async {
//    print("my file's path is: $path");

    //basename() function will give you the filename
    String fileName = Path.basename( path );
//    print("my file's file name is: $fileName");

    //passing your path with the filename to Firebase Storage Reference
    StorageReference reference =
    FirebaseStorage.instance.ref( ).child( fileName );

    //upload the file to Firebase Storage
    StorageUploadTask uploadTask = reference.putFile( File(path) );

    //Snapshot of the uploading task
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final String url = (await taskSnapshot.ref.getDownloadURL( ));
//    print( 'the file url is: $url' );
    return url;
//    print( 'the file name is: $fileName' );

  }

}




