import 'package:flutter/material.dart';
import 'LoginPageScreen.dart';
import 'RegisterPageScreen.dart';


class AuthenticationPageScreen extends StatefulWidget {
  @override
  _AuthenticationPageScreenState createState() => _AuthenticationPageScreenState();
}

class _AuthenticationPageScreenState extends State<AuthenticationPageScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.lightBlue],
                    begin: FractionalOffset(0.0 , 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.mirror
                )
            ),
          ),
          title:  Image.asset('image/logo.png',
            fit:BoxFit.cover,
            height:50.00,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                text:
                "Login",


              ),

              Tab(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                text:
                "Sign Up",

              ),

            ],

            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
          ),
        ),


        body: Container(

          child: TabBarView(
            children: [

              LoginPageScreen(),
              RegisterPageScreen(),

            ],
          ),

        ),

      ),

    );
  }
}