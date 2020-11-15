import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Conect/APICon.dart';
import 'Widget/bezierContainer.dart';
import 'Widget/cupertino_radio_choice.dart';
import 'loginPage.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PasswordController = TextEditingController();
  final EmailController = TextEditingController();
  final ConPassController = TextEditingController();


  bool _PAssvalidate = false;
  bool _Mailvalidate = false;
  bool _ConPassvalidate = false;
  Item selectedUser;
  static final Map<String, String> genderMap = {
    'male': 'Male',
    'female': 'Female',
  };




  void onGenderSelected(String genderKey) {
    setState(() {
      _selectedGender = genderKey;
    });
  }

  String _selectedGender = genderMap.keys.first;

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

  Widget _submitButton() {
    return Container(
      width: 150,
      height: 50,
      child: new RaisedButton(
          child: new Text("Register Now", style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lime)),
          color: Colors.black,
          splashColor: Colors.lime,
          animationDuration: Duration(seconds: 60),
          padding: EdgeInsets.all(5.0),
          onPressed: () async {
            setState(() {
              EmailController.text.isEmpty
                  ? _Mailvalidate = true
                  : _Mailvalidate = false;
              PasswordController.text.isEmpty
                  ? _PAssvalidate = true
                  : _PAssvalidate = false;
              ConPassController.text.isEmpty
                  ? _ConPassvalidate = true
                  : _ConPassvalidate = false;
            });
            if (EmailController.text.isEmpty ||
                PasswordController.text.isEmpty ||
                ConPassController.text.isEmpty) {
              return;
            }
            if(await Network().Checkuser(EmailController.text)=="true"){ BezierContainer().showAlertDialog("Error","الاسم مستخدم",context);return;}
          if(  await Network().createData(EmailController.text,PasswordController.text,_selectedGender,selectedUser.name)=="true")
            {
              BezierContainer().showAlertDialog("Done","تم انشاء الحساب",context)  ;
            }
          else{
            BezierContainer().showAlertDialog("Error","حدث خطء يرجى اعادة المحاولة",context)  ;
          }
          },
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white),
          )
      ),

    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(0),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Already have an account ?', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lime),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        BezierContainer().DesignTextFild(
            "Username", EmailController, "Username Value Can\'t Be Empty",
            _Mailvalidate, isPassword: false),

        SizedBox(height: 10),
        BezierContainer().DesignTextFild(
            "Password", PasswordController, "Password Value Can\'t Be Empty",
            _PAssvalidate, isPassword: true),

        SizedBox(height: 10),
        BezierContainer().DesignTextFild("ConfermPassword", ConPassController,
            "ConfermPassword Value Can\'t Be Empty", _ConPassvalidate,
            isPassword: true),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
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
                right: -MediaQuery
                    .of(context)
                    .size
                    .width * .5,
                child: BezierContainer()),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 70),
                    BezierContainer().title(),
                    SizedBox(height: 20),
                    _emailPasswordWidget(),
                    SizedBox(height: 5),

                            Container(
                              child:Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Color(0xff000000),
                                ),
                                child: DropdownButton<Item>(
                                  underline: Container(
                                    height: 1.1,
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  hint:  Text("Select country",style: TextStyle(color: Colors.white,fontSize: 16),),
                                  value: selectedUser,
                                  onChanged: (Item Value) {
                                    setState(() {
                                      selectedUser = Value;
                                    });
                                  },
                                  items: users.map((Item user) {
                                    return  DropdownMenuItem<Item>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          user.icon,
                                          Text(
                                            user.name,
                                            style:  TextStyle(color: Colors.white,fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              ]),
                            ),

                            SizedBox(height: 10),

                            Container(

                              child:   CupertinoRadioChoice(
                                  choices: genderMap,
                                  onChange: onGenderSelected,
                                  initialKeyValue: _selectedGender),

                    ),
                    SizedBox(height: 90),
                    _submitButton(),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _loginAccountLabel(),
                    SizedBox(height:10),
                  ]
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}




List<Item> users = <Item>[
  const Item("Afghanistan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Albania",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Algeria",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Andorra",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Angola",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Antigua and Barbuda",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Argentina",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Armenia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Australia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Austria",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Azerbaijan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("The Bahamas",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Bahrain",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Bangladesh",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Barbados",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Belarus",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Belgium",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Belize",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Benin",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Bhutan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Bolivia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Bosnia and Herzegovina",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Botswana",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Brazil",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Brunei",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Bulgaria",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Burkina Faso",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Burundi",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Cambodia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Cameroon",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Canada",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Cape Verde",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Central African Republic",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Chad",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Chile",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("China",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Colombia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Comoros",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Congo, Republic of the",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Congo",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Costa Rica",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Cote d'Ivoire",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Croatia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Cuba",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Cyprus",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Czech Republic",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Denmark",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Djibouti",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Dominica",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Dominican Republic",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("East Timor (Timor-Leste)",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Ecuador",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Egypt",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("El Salvador",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Equatorial Guinea",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Eritrea",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Estonia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Ethiopia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Fiji",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Finland",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("France",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Gabon",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("The Gambia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Georgia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Germany",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Ghana",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Greece",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Grenada",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Guatemala",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Guinea",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Guinea-Bissau",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Guyana",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Haiti",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Honduras",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Hungary",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Iceland",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("India",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Indonesia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Iran",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Iraq",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Ireland",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Israel",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Italy",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Jamaica",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Japan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Jordan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Kazakhstan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Kenya",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Kiribati",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Korea, North",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Korea, South",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Kosovo",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Kuwait",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Kyrgyzstan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Laos",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Latvia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Lebanon",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Lesotho",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Liberia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Libya",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Liechtenstein",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Lithuania",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Luxembourg",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Macedonia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Madagascar",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Malawi",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Malaysia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Maldives",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Mali",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Malta",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Marshall Islands",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Mauritania",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Mauritius",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Mexico",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Micronesia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Moldova",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Monaco",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Mongolia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Montenegro",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Morocco",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Mozambique",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Myanmar (Burma)",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Namibia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Nauru",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Nepal",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Netherlands",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("New Zealand",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Nicaragua",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Niger",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Nigeria",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Norway",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Oman",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Pakistan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Palau",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Panama",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Papua New Guinea",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Paraguay",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Peru",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Philippines",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Poland",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Portugal",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Qatar",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Romania",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Russia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Rwanda",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Saint Kitts and Nevis",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Saint Lucia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Saint Vincent and the Grenadines",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Samoa",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("San Marino",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Sao Tome and Principe",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Saudi Arabia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Senegal",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Serbia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Seychelles",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Sierra Leone",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Singapore",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Slovakia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Slovenia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Solomon Islands",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Somalia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("South Africa",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("South Sudan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Spain",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Sri Lanka",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Sudan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Suriname",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Swaziland",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Sweden",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Switzerland",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Syria",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Taiwan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Tajikistan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Tanzania",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Thailand",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Togo",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Tonga",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Trinidad and Tobago",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Tunisia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Turkey",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Turkmenistan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Tuvalu",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Uganda",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Ukraine",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("United Arab Emirates",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("United Kingdom",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("United States of America",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Uruguay",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Uzbekistan",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Vanuatu",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Vatican City (Holy See)",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Venezuela",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Vietnam",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Yemen",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Zambia",Icon(Icons.flag,color:  const Color(0xffcddc39),)),
  const Item("Zimbabwe",Icon(Icons.flag,color:  const Color(0xffcddc39),)),


];

