import 'package:flutter/material.dart';
import './components/button.dart';
import './constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration-screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
final _auth  = FirebaseAuth.instance;

  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
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
                 email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,

                obscureText: true,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter you Password' )
              ),
              SizedBox(
                height: 24.0,
              ),
        Button(
          text: 'Register',
          color: Colors.blueAccent,
        onPressed: ()async{
            setState(() {

              showSpinner = true;
            });
//          print(email);
//          print(password);
        try {
          final newUser = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          if(newUser != null){
            Navigator.pushNamed(context, ChatScreen.id);

          }
          setState(() {
            showSpinner = false;
          });
        }

        catch (e){
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