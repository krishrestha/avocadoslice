import 'package:avocadoslice/controllers/signup_controller.dart';
import 'package:avocadoslice/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../controllers/login_controller.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userForm = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController email  = TextEditingController();
  TextEditingController password  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Log In',style: TextStyle(fontSize: 32),), centerTitle: true,),
      body: Form(
        key: userForm,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100, height: 100,
                  child: Image.asset("assets/images/logo.png")),
              SizedBox(height: 25,),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: email,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'email is required' ;
                  }
                },
                decoration: InputDecoration(label: Text('Email',style: TextStyle(fontSize: 18),)),
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: password,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'password is required' ;
                  }
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(label: Text('Password',style: TextStyle(fontSize: 18),)),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: ()async{
                      if(userForm.currentState!.validate()){
                        isLoading = true ;
                        setState(() {});
                        await LoginController.login(context: context, email: email.text, password: password.text);
                        isLoading = false ;
                        setState(() {});
                      }
                    }, child: isLoading ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(),
                    ) : Text('Log In',style: TextStyle(fontSize: 18),)),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account',style: TextStyle(fontSize: 18),),
                  SizedBox(width: 10,),
                  InkWell(onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder:(context){
                      return SignupScreen();
                    }
                    ));
                  },
                  child: Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple[200],fontSize: 18),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

