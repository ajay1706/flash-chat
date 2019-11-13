import 'package:flash_chat/registration_screen.dart';
import 'package:flutter/material.dart';
import './login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import './components/button.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome-screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {


  AnimationController controller;
  Animation animation;


@override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
//    upperBound: 100,
    duration: Duration(seconds: 1));
    
//    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

animation = ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);

    controller.forward();

//    animation.addStatusListener((status){
//      if(status == AnimationStatus.completed){
//        controller.reverse(from: 1);
//      }else if (status == AnimationStatus.dismissed){
//        controller.forward();
//      }
//    });

    controller.addListener((){
      setState(() {

      });

      print(animation.value);
    });
  }

  @override
  void dispose() {
  controller.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                TyperAnimatedTextKit(
          text :        [ 'Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,

                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
        Button(text: 'Log In',color: Colors.lightBlueAccent,onPressed: (){ Navigator.pushNamed(context, LoginScreen.id);}),

        Button(text: 'Register',color: Colors.blueAccent,onPressed: (){ Navigator.pushNamed(context, RegistrationScreen.id);})
    ])));
  }
}


