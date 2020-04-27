//
//import 'package:flutter/material.dart';
//import 'package:flutter_satit_app/auth.dart';
//
//
//class SignIn extends StatefulWidget {
//
//@override
//_SignInState createState() => _SignInState();
//}
//
//class _SignInState extends State<SignIn> {
//
//
//  final AuthService _auth = AuthService();
//
//  @override
//  Widget build(BuildContext context)
//  {
//  return Scaffold(
//      backgroundColor: Colors.brown[100],
//      appBar: AppBar(
//      backgroundColor: Colors.brown[400],
//      elevation: 0.0,
//      title: Text(
//      'Sign in to App'),
//      ),
//     body: Container(
//      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//      child: RaisedButton (
//      child: Text('Sing In Anon'),
//      onPressed: () async {
//        dynamic result = await _auth.signInAnon();
//        if (result == null) {
//          print('error in signing');
//        } else {
//          print('signing success');
//          print(result.uid);
//        }
//
//      }
//      ),
//      ),
//    );
//
//
//  }
//
//}