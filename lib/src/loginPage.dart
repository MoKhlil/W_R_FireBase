import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_try/src/signup.dart';
import 'package:flutter_app_try/src/welcomePage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Conect/APICon.dart';
import 'Widget/bezierContainer.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final PasswordController = TextEditingController();
  final EmailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();





  bool _PAssvalidate = false;
  bool _Mailvalidate = false;
  bool _saving = false;

  var encrypter;

  Widget _submitButton() {
    return Container(
      width: 150,
      height:50,
      child: new RaisedButton(

          child: new Text("login",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.lime)),
          color: Colors.black,
          splashColor: Colors.lime,
          animationDuration: Duration(seconds: 60),
          padding: EdgeInsets.all(5.0),
          onPressed: () async {

            //localStorage.clear();
            setState((){
              EmailController.text.isEmpty ? _Mailvalidate = true : _Mailvalidate = false;
              PasswordController.text.isEmpty ? _PAssvalidate = true : _PAssvalidate = false;
            });
            if(EmailController.text.isEmpty||PasswordController.text.isEmpty)
            {
               return ;
            }
            setState(() {
              _saving = true;
            });
            if(await Network().readData(EmailController.text,PasswordController.text)== "true")
            {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()));
            }
            else{
            BezierContainer().showAlertDialog("Error","الاسم اوكلمة السر خطء",context)  ;
            }
            new Future.delayed(new Duration(seconds: 2), () {
              setState(() {
                _saving = false;
              });
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white),
          )
      ),
    );
  }

  Widget _emailWidget() {
    return Column(
      children: <Widget>[
        BezierContainer().DesignTextFild("ID",EmailController,"ID Value Can\'t Be Empty",_Mailvalidate,isPassword: false),
        SizedBox(height: 10),
        BezierContainer().DesignTextFild("Passowrd",PasswordController,"Passowrd Value Can\'t Be Empty",_PAssvalidate, isPassword: true),
      ],
    );
  }
  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
                'Don\'t have an account ?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Register',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.lime),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
       resizeToAvoidBottomInset: false, // set it to false
        key: _scaffoldKey,
        body: ModalProgressHUD(child:Container(
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
           // alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom  , // so that the whole thing always move +10
            ),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BezierContainer().title(),
                SizedBox(height: 30),
                _emailWidget(),
                 SizedBox(height: 20),
                _submitButton(),
                //SizedBox(height:20),
              ],
            ),
          ),
          Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _createAccountLabel(),
                      SizedBox(height:10),
                      ]
                ),
          ),
            ],
          ),
        ),inAsyncCall: _saving),


    );
  }


}
