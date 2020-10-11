import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payo/Authentication/LoginPageScreen.dart';
import 'package:payo/DialogBox.dart';
import 'package:payo/Widget/CustomTextField.dart';

class RegisterPageScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return RegisterPageScreenState();
  }

}

class RegisterPageScreenState extends State <RegisterPageScreen>{

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  DialogBox alertDialog = DialogBox();


  FirebaseAuth _auth = FirebaseAuth.instance;

  final fb = FirebaseDatabase.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.all(20.0),
              child:   getImage(),
            ),


            Padding(
              padding: EdgeInsets.only(top:15.0, left: 100),

              child: Text(
                "Sign Up your account",
                style: GoogleFonts.poppins(

                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20
                    )

                ),
              ),

            ),

            CustomTextField(_firstNameController,false,Icons.assignment_ind , "Your first name"),
            CustomTextField(_lastNameController,false,Icons.assignment_ind , "Your last name"),
            CustomTextField(_emailController,false,Icons.account_circle , "Your email ID"),
            CustomTextField(_passwordController,true,Icons.lock , "Password"),
            CustomTextField(_confirmPasswordController,false,Icons.lock_open , "Confirm Password"),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20 , top: 15 , bottom: 10),

              child: TextFormField(

                controller: _mobileNumberController,
                keyboardType: TextInputType.number ,
                obscureText: false,

                decoration: InputDecoration(
                  labelText: "Contact Number",

                    labelStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        )
                    ),

                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.black,

                )
                ),

              ) ,

            ),
            CustomTextField(_addressController,false,Icons.home , "Your Address"),

            Padding(
                padding: EdgeInsets.only(left:20.0, right: 20.0, bottom: 20.0, top: 50.0),

                child: ButtonTheme(

                  height: 50.0,


                  child: RaisedButton(

                    color: Colors.white,

                    onPressed: () async{

                      if(_firstNameController.text.isNotEmpty &&
                          _lastNameController.text.isNotEmpty &&
                          _mobileNumberController.text.isNotEmpty &&
                          _addressController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _confirmPasswordController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty
                      ){
                        if(_passwordController.text.toString() == _confirmPasswordController.text.toString()){

                            _registerUser();

                        }
                        else{
                          alertDialog.information(context,"Error! Can't Proceed :(","The Passwords don't match :(");
                        }

                      }else{

                        alertDialog.information(context,"Error! Can't Proceed :(","Please enter the details correctly!");

                      }
                    },
                    child: Column(
                      children: <Widget>[

                        Icon(
                            Icons.account_circle,
                            color:Colors.black
                        ),

                        Text(
                          "Sign Up",
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
        )
    );
  }

  void _registerUser() async{

    User firebaseUser;

    await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text).then((auth) {
          firebaseUser = auth.user;
    });

    if(firebaseUser != null){
      saveUserInfoToFireStore(firebaseUser).then((value){
        alertDialog.information(context,"Registration Successful!","Now go to Login tab to continue...");

      });
    }

  }

  Future saveUserInfoToFireStore(User fUser) async{

    final dbRef = fb.reference().child("Path");

    dbRef.child(fUser.uid).set({
      "uid" : fUser.uid,
      "email" : fUser.email,
      "firstName" : _firstNameController.text.trim(),
      "lastName" : _lastNameController.text.trim(),
      "password" : _passwordController.text.trim(),
      "address" : _addressController.text.trim(),
      "contact" : _mobileNumberController.text.trim()
    });

    //Storing the above details in Shared Preferences to fetch the above details later on..

  }

}

class getImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage("image/Register.png");
    Image image = Image(image: assetImage);

    return Container(
      child: image,
    );
  }
}