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
  Widget showAlertDialog(String title,String message,BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
        child: Text("OK",style: TextStyle(color: Colors.black)),
        onPressed: () { Navigator.of(context).pop();  }
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
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



}

List<RadioModel> sampleData = new List<RadioModel>();
void initState() {
  // TODO: implement initState
  //super.initState();
  sampleData.add(new RadioModel(false, 'A', 'April 18'));
  sampleData.add(new RadioModel(false, 'B', 'April 17'));

}
class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color:
                      _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Colors.blueAccent
                  : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected
                      ? Colors.blueAccent
                      : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}