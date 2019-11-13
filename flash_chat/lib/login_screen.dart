import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'components/button.dart';
import './constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

 final _auth = FirebaseAuth.instance;
 String email;
 String password;
 bool showSpiner = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpiner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                onChanged: (value) {

                  //Do something with the user input.
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password= value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password')
              ),
              SizedBox(
                height: 24.0,
              ),
     Button(text: 'Log In',color: Colors.lightBlueAccent,onPressed: () async{
setState(() {

  showSpiner = true;
});
         try{
         final user =await _auth.signInWithEmailAndPassword(email: email, password: password);
         if(user!= null){
           Navigator.pushNamed(context, ChatScreen.id);
         }

         setState(() {

           showSpiner = false;
         });
         }
         catch(e){
           print(e);
         }

     },)
            ],
          ),
        ),
      ),
    );
  }
}