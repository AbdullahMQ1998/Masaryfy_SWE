import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Components/Rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'register_user_info.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = ColorTween(begin: Colors.grey , end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {
        
      });
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
                TypewriterAnimatedTextKit(text: [ 'Masaryfy'], textStyle: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                ),
                speed: Duration(milliseconds: 250),),

              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            paddingButton(Colors.lightBlueAccent,'Log in' , () {
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            paddingButton(Colors.blueAccent, 'Register', (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),
            paddingButton(Colors.blue, "Take me to info page", (){
              Navigator.pushNamed(context, RegisterUserInfo.id);
            })
          ],
        ),
      ),
    );
  }
}


