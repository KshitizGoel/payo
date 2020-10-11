import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';
import 'Authentication/AuthenticationPage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return new SplashScreen(

      seconds: 3,
      navigateAfterSeconds: AuthenticationPageScreen(),
      image: new Image.asset(
          'image/logo.png'),
      photoSize: 150.0,
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
    );
  }
}