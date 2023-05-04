import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login>{
  Future<UserCredential?> signInWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser==null){
      return null;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.idToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(onPressed: signInWithGoogle, child: Image.asset('assets/Images/login_button.png'))
        ],
      ),
    );
  }
}