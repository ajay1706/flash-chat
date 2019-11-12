import 'package:flutter/material.dart';
import './welcome_screen.dart';
import './login_screen.dart';
import './registration_screen.dart';
import './chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
            body1: TextStyle(
              color: Colors.black54
            )
        )
      ),
      home: WelcomeScreen(),
      initialRoute:WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context)=> WelcomeScreen(),
        'login-screen':(context) => LoginScreen(),
        'registration-screen' : (context) => RegistrationScreen(),
        'chat-screen' : (context) => ChatScreen()
      },
    );
  }
}


