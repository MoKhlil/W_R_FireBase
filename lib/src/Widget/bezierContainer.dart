import 'dart:math';
import 'package:flutter/material.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);



  Widget DesignTextFild(String title,TextEditingController control,String Error,bool ErrorVa, {bool isPassword = false}) {
    FocusNode myFocusNode = new FocusNode();
    return
      TextFormField(
        controller: control,

        cursorColor: Colors.lime,
        obscureText: isPassword,
        style: TextStyle(color: Colors.white),
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
              color: Colors.white,
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


}