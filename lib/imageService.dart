import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'dataBaseService.dart';
//import 'package:image_picker_modern/image_picker_modern.dart';



class Upload {

  String uid;
  String docID;

  Upload({this.uid, this.docID});

  Future<void> uploadPic() async {
    //pick image   use ImageSource.camera for accessing camera.
    File image = await ImagePicker.pickImage( source: ImageSource.gallery );

    //basename() function will give you the filename
    String fileName = Path.basename( image.path );

    //passing your path with the filename to Firebase Storage Reference
    StorageReference reference =
    FirebaseStorage.instance.ref( ).child( fileName );

    //upload the file to Firebase Storage
    StorageUploadTask uploadTask = reference.putFile( image );

    //Snapshot of the uploading task
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final String url = (await taskSnapshot.ref.getDownloadURL( ));
//    print( 'the file url is: $url' );
//    print( 'the file name is: $fileName' );
    
    if (url != null) {
      DateTime time = DateTime.now( );
      DatabaseService( uid: uid ).addRecord( url, 'title', time, docID );
    }
  }


}




