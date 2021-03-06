import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loginPage.dart';
import 'customClipper.dart';

class BezierContainer extends StatelessWidget {


  const BezierContainer({Key key}) : super(key: key);

  Widget DesignTextFild(String title,TextEditingController control,String Error,bool ErrorVa, {bool isPassword = false}) {
    FocusNode myFocusNode = new FocusNode();
    return
      TextFormField(
        controller: control,
        cursorWidth:10,
        cursorColor: Colors.lime,
        obscureText: isPassword,

        style: TextStyle(color: Colors.white,height:0.1,),
        decoration: InputDecoration(
          fillColor: Colors.white12,
          filled: true,
          errorText: ErrorVa ? Error : null,
          labelText: title,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Colors.lime : Colors.white
          ),

          //hintText: title,
          //hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            ),
          ),

          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.white12),
          ),

          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.lime),
          ),
        ),
      );
  }

  Widget title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'T',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffffd600),
          ),
          children: [
            TextSpan(
              text: 'ry',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),

          ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
          angle: -pi / 1.5,
          child: ClipPath(
            clipper: ClipPainter(),
            child: Container(
              height: MediaQuery.of(context).size.height *.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffffd600),Color(0xffffd600)]
                  )
              ),
            ),
          ),
        )
    );
  }
  Widget showAlertDialog(String title,String message,BuildContext context)  {

    // set up the button
    Widget okButton = OutlineButton(
      color: Colors.white,
        child: Text("Ok",style: TextStyle(color: Colors.black)),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)
        ),
        onPressed: () async {
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          if(localStorage.getString("Done")=="1") {
            Navigator.push( context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
          else {
            Navigator.of(context).pop();
          }
        }
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title,style: TextStyle(color: Colors.black),),
      content: Text(message,style: TextStyle(color: Colors.black)),
      elevation: 150.0,
      //shape: CircleBorder(),
      backgroundColor: Colors.lime,
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



}


