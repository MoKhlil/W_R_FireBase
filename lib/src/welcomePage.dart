import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Conect/APICon.dart';
import 'Widget/bezierContainer.dart';
import 'loginPage.dart';
class WelcomePage extends StatefulWidget  {

  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();

}

class _WelcomePageState extends State<WelcomePage>  {
  Widget _signUpButton() {
    return
      Container(
        width: 250,
        child: new RaisedButton(
            textColor: Colors.lime,
            child: new Text("Serch..."),
            color: Colors.black,
            splashColor: Colors.lime[100],
            animationDuration: Duration(seconds: 60),
            padding: EdgeInsets.all(5.0),
            onPressed: ()  {},
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white),
            )
        ),
      );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF000000), Color(0xFF000000)]
              //colors: [Color(0xffffd600), Color(0xffffd600)]
            )
        ),
        height: height,
        child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .10,
                  right: -MediaQuery.of(context).size.width * .5,
                  child: BezierContainer()),
              Container(
                padding: const EdgeInsets.fromLTRB(70,0,70,0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      BezierContainer().title(),
                      SizedBox(height: 150),
                      _signUpButton(),
                      SizedBox(height: height * .055),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ]
        ),
      ),

    );

  }
}