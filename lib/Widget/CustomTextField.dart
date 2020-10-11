import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget{

  final IconData data;
  final TextEditingController controller;
  final String labelText;
  bool isObscureText = true;


  CustomTextField(this.controller ,this.isObscureText , this.data , this.labelText,);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20 , top: 15 , bottom: 10),

        child: TextFormField(

          obscureText: isObscureText,
          controller: controller,



          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                )
            ),

            prefixIcon: Icon(
              data,
              color: Colors.black
            ),
            focusColor: Colors.black,
          ),

        ),
      ),
    );
  }

}