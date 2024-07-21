import 'package:avocadoslice/controllers/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'dashboard_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var userForm = GlobalKey<FormState>();
  bool isLoading = false ;
  TextEditingController email  = TextEditingController();
  TextEditingController password  = TextEditingController();
  TextEditingController name  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: userForm,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
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
                      SizedBox(height: 20),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: name,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'name is required' ;
                          }
                        },
                        decoration: InputDecoration(label: Text('Name',style: TextStyle(fontSize: 18),)),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(onPressed: ()async{
                            if(userForm.currentState!.validate()){
                              isLoading = true ;
                              setState(() {});
                              await SignupController.createAccount(context: context, email: email.text, password: password.text,name: name.text);
                              isLoading = false ;
                              setState(() {});
                            }
                          }, child: isLoading ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          ) : Text('Sign Up',style: TextStyle(fontSize: 18),)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

