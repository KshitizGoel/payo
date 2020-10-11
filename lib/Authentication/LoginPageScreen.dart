import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payo/ApiDetectionpage/HomePageScreen.dart';
import 'package:payo/DialogBox.dart';
import 'package:payo/Widget/CustomTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPageScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginPageScreenState();
  }

}


class LoginPageScreenState extends State<LoginPageScreen>{

  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();
  bool _success;
  DialogBox alertDialog = DialogBox();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SharedPreferences sharedPreferences;

  DialogBox dialogBox = DialogBox();

  String email = " ";
  String password = " ";

  DatabaseReference dbRef = FirebaseDatabase.instance.reference();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
         
          child:  ListView(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(10.0),
                child: getImageAsset(),

              ),

              Padding(
                padding: EdgeInsets.only(top:10.0, left: 90),
                child: Text(
                  "Login to your account",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      )
                  ),
                ),

              ),

              CustomTextField(_emailTextEditingController,false,Icons.account_circle , "Your email ID"),
              CustomTextField(_passwordTextEditingController,true,Icons.lock , "Password"),



              Padding(
                  padding: EdgeInsets.only(left:20.0, right: 20.0, bottom: 20.0, top: 50.0),

                  child: ButtonTheme(

                    height: 50.0,


                    child: RaisedButton(

                      color: Colors.white,

                      onPressed: (){
                        //Used in backend for logging in authentically..

                        if(_emailTextEditingController.text.isNotEmpty && _passwordTextEditingController.text.isNotEmpty){

                          email = _emailTextEditingController.text.toString();
                          password = _passwordTextEditingController.text.toString();

                          _signInWithEmailAndPassword();
                        }
                        else{
                          alertDialog.information(context,"Error! Can't Proceed :(","Please enter the details correctly!");

                        }


                      },
                      child: Column(
                        children: <Widget>[

                          Icon(
                              Icons.details,
                              color:Colors.black
                          ),

                          Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          )

                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),

                      ),


                    ),
                  )
              ),


            ],
          ),
        )

    );
  }

  void _signInWithEmailAndPassword() async {

    try{
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailTextEditingController.text,
        password: _passwordTextEditingController.text,
      )).user;

      if (user != null) {
        setState(() {
          _success = true;
          email = user.email;
        });

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomePageScreen()
        ));

        addStringToSF();
      } else {
        setState(() {
          _success = false;
        });
        alertDialog.information(context, "Invalid Entry :(", "Try Again!");
      }

    }
    catch(e){
      alertDialog.information(context, "Invalid Entry :(", "Try Again!");

    }
  }

  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', _emailTextEditingController.text.toString());
  }

}
class getImageAsset extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage("image/Login.png");
    Image image = Image(image: assetImage);

    return Container(
      child: image,
    );
  }
}