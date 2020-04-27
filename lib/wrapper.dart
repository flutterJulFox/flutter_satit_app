import 'package:flutter_satit_app/home.dart';
import 'package:flutter_satit_app/register.dart';
import 'package:flutter_satit_app/sign_in.dart';
import 'package:flutter_satit_app/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final String uid;
  Wrapper (this.uid);

  @override
  Widget build(BuildContext context) {

//    final user = Provider.of<User>(context);

    if(uid == null){
      print ('nope. No uid in the wrapper');
//      return Register();
    }
    else {
      print ('user uid in wrapper is: $uid}');
      return Register();}
//      return HomePage();}

  }
}
