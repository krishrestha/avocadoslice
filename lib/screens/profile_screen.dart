import 'package:avocadoslice/providers/userProvider.dart';
import 'package:avocadoslice/screens/editprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String , dynamic>? userData = {};

  @override
  Widget build(BuildContext context) {

    var userProvider = Provider.of<UserProvider>(context);

    return  Scaffold(
      appBar: AppBar(
        title: Text('',style: TextStyle(fontSize: 32)),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(userProvider.userName[0]),
            ),
            SizedBox(height: 10,),
            Text(userProvider.userName,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21),),
            Text(userProvider.userEmail,style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:
                  (context){
                return EditProfileScreen();
              }
              ));
            }, child: Text('Edit Profile'))
          ],
        ),
      ),
    );
  }
}
