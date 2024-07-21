import 'package:avocadoslice/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';

class LoginController {

  static Future<void> login({required BuildContext context,required String email,required String password}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
          (context){
        return SplashScreen();
      }
      ),(route){
        return false;
      });
    }
    catch(e){
      SnackBar messageSnackBar = SnackBar(backgroundColor: Colors.red, content: Text(e.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),));
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
    }
  }
}