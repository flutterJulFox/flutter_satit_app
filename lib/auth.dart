import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_satit_app/dataBaseService.dart';
import 'package:flutter_satit_app/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user Object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return   user != null ? User(uid: user.uid) : null;
//    if(user != null){ return User(uid:user.uid);};

  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon () async{
    try{
        AuthResult result = await _auth.signInAnonymously();
        FirebaseUser user = result.user;
        //create new document with uid
//        await DatabaseService(uid: user.uid).updateUserData('titlePic', DateTime.now());
        return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
//      await DatabaseService(uid: user.uid).updateUserData();
      return _userFromFirebaseUser(user);
//    return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}
