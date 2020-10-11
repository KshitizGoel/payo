import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DialogBox.dart';
import 'Posts.dart';

class ProfileScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }

}

class ProfileScreenState extends State <ProfileScreen>{

  List <Posts> postsList = [];
  DialogBox dialogBox = DialogBox();

  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Path");

  Future <void> retrieveAllTheData() async {
    final prefs = await SharedPreferences.getInstance();

    String emailId = prefs.getString("stringValue");

    dbRef.orderByChild("email").equalTo(emailId).once().then((
        DataSnapshot snap) {
      var DATA = snap.value;

      postsList.clear();
      if (DATA != null) {
        var KEYS = snap.value.keys;


        for (var individualKey in KEYS) {
          Posts posts = Posts(
            DATA[individualKey]["address"],
            DATA[individualKey]["contact"],
            DATA[individualKey]["email"],
            DATA[individualKey]["firstName"],
            DATA[individualKey]["lastName"],
            DATA[individualKey]["password"],
          );
          postsList.add(posts);
        }

        setState(() {
          this.postsList = postsList;
        });
      }
      else {
        //Alert Dialog
        postsList.clear();

        dialogBox.information(context, "No Information :(",
            "Can't get any info.");
      }
    });
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(

          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "My Profile",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25
              ),
            ),
        ),

          body: ListView(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(

                  elevation: 10,

                  color: Colors.white,

                  onPressed: () {
                    retrieveAllTheData();
                  },

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),

                  ),

                  child: Column(
                    children: <Widget>[

                      Icon(
                        Icons.details,
                        color: Colors.black,
                      ),

                      Text(
                        "Details",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            )
                        ),
                      )

                    ],
                  ),
                ),
              ),

              Center(
               child:  enableUpload()
              )


            ],
          )

      );
    }

  Widget enableUpload() {
    return Form(


        child: ListView(
            shrinkWrap: true,
        padding: EdgeInsets.all(20.0),

    children: <Widget>[
    ListView.builder(
    shrinkWrap: true,
    itemCount: postsList.length,
    itemBuilder: (BuildContext context, int ind){



    return Card(


    elevation: 20.0,

    child: Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[

    Padding(
    padding: EdgeInsets.all(20.0),

    child:  Text(
    "FULL NAME : ${postsList[ind].contact.toString()} ${postsList[ind].firstName}   ",

      style:GoogleFonts.poppins(
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          color: Colors.blueGrey
        ),
      )
    ),


    ),

    Padding(
    padding: EdgeInsets.all(20.0),

    child:  Text(
    "ADDRESS :  ${postsList[ind].email.toString()} ",

        style:GoogleFonts.poppins(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.blueGrey
          ),
        )
    ),


    ),

    Padding(
    padding: EdgeInsets.all(20.0),

    child:  Text(
        "PHONE NO : ${postsList[ind].password.toString()}",

        style:GoogleFonts.poppins(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.blueGrey
          ),
        )
    ),
 ),


      Padding(
        padding: EdgeInsets.all(20.0),

        child:  Text(
          "EMAIL : ${postsList[ind].address.toString()} ",

            style:GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blueGrey
              ),
            )
        ),
      ),

      Padding(
        padding: EdgeInsets.all(20.0),

        child:  Text(
          "PASSWORD : ${postsList[ind].lastName}",

            style:GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blueGrey
              ),
            )
        ),
      ),

    ],

    ),

    );
    }),
 ]) );

}}