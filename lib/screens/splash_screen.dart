import 'package:avocadoslice/providers/userProvider.dart';
import 'package:avocadoslice/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:avocadoslice/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
var user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1),() {
      if(user == null){
        openLogin();
      }else{
        openDashboard();
      }
    });
    // TODO: implement initState
    super.initState();
  }


  void openDashboard(){
    Provider.of<UserProvider>(context,listen: false).getUserDetails();
    Navigator.pushReplacement(context, MaterialPageRoute(builder:
        (context){
      return DashboardScreen();
    }
    ));
  }

  void openLogin(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder:
        (context){
      return LoginScreen();
    }
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 250, height: 200,
                child: Image.asset("assets/images/logo.png")
            ),
            Text('Avocado Slice',style: TextStyle(fontSize: 32)),
          ],
        ),
      ),
    );
  }
}
