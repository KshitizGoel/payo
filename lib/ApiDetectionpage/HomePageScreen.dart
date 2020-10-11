import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:payo/Authentication/LoginPageScreen.dart';
import 'package:payo/Profile/ProfileScreen.dart';

class HomePageScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HomePageScreenState();
  }

}

class HomePageScreenState extends State<HomePageScreen> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String apiUrl = "https://reqres.in/api/users?page=1";

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['data'];
  }

  int _id(dynamic user) {
    return user['id'];
  }

  String _email(dynamic user) {
    return user['email'];
  }

  String _firstName(dynamic user) {
    return user['first_name'];
  }

  String _lastName(dynamic user) {
    return user['last_name'];
  }

  Future<String> deleteWithBodyExample(String id) async {
    final url = Uri.parse("https://reqres.in/api/users?page=1");
    final request = http.Request("DELETE", url);
    request.headers.addAll(<String, String>{
      "page":"1",
      "per_page":"6",
      "total":"12",
      "total_pages":"2",
    });
    request.body = jsonEncode({"id": id});
    final response = await request.send();
    return await response.stream.bytesToString();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,

        title: Text(
          "Records",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black
              )
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0, top: 20),
              child: GestureDetector(
                  onTap: () {
                    _signOut();
                  },
                  child: Text(
                    "LOGOUT",
                    style: GoogleFonts.sansita(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        )
                    ),
                  )
              )
          ),

        ],
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('My Profile',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle
                      (
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30
                    )
                ),),

              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.account_box,
                color: Colors.black,
              ),
              title: Text('Show my profile',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ));
              },

            ),
          ],
        ),
      ),
      body: ListView(

        shrinkWrap: true,

        children: <Widget>[

          FutureBuilder<List<dynamic>>(
            future: fetchUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.length ,
                    itemBuilder: (BuildContext context, int index) {
                      return
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: SizedBox( height: 100,

                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),

                                elevation: 10,
                                child: ListView(
                                  children: <Widget>[

                                    ListTile(
                                        onLongPress: (){

                                          deleteWithBodyExample(  _id(snapshot.data[index]).toString());
                                        },
                                        leading:
                                        CircleAvatar(

                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                snapshot.data[index]['avatar'])),
                                        title: Text(
                                          _firstName(snapshot.data[index]) + " " +
                                              _lastName(snapshot.data[index]),
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              )
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Text(
                                            _email(snapshot.data[index]),
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey
                                                )
                                            ),),
                                        ),
                                        trailing: Padding(
                                          padding: EdgeInsets.only(top: 1),

                                          child: Text(
                                            _id(snapshot.data[index]).toString(),

                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                )
                                            ),
                                          ),

                                        )


                                    )
                                  ],
                                ),
                              ),
                            )

                        );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },


          ),
        ]
      ),
    );
  }


  void _signOut() async {
    await _firebaseAuth.signOut();

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => LoginPageScreen(),
    ));
  }
}

