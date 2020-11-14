import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class Network {
  final String _url = 'your server ';
  final con=  FirebaseDatabase.instance.reference().child("Login") ;
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  Future<String> fetchAlbum(var x) async {
    http.Response Res = await http.get(
        Uri.encodeFull('https://jsonplaceholder.typicode.com/posts'),
        headers: {
          "Accept": "application/" + x
        }
    );
    print(Res.body);
  }

  Future<void> createData(String Id,String Pass,String Gender,String Country) async {
    try
    {
      await con.child(Id)
          .set
        ({
        'Passowrd': Pass,
        'Gender': Gender,
        'Country': Country,
         });
      readData(Id,Pass);
    }
    catch  (e)
    {
      //print('Erreo: ${e.value }');
    }

  }

  Future<String> readData(String Id,String Pass)   async {
    try
    {
      final snapshot =await con.child(Id).once();
        print('where: ${snapshot.value["Passowrd"].toString()}');
        if (snapshot.value != null) {
          getdat('username',"true");

          if(snapshot.value['Passowrd'].toString()==Pass)
          {
            getdat('pass',"true");
          }
          else{
          getdat('pass',"false");
          }
        }
        else{
          getdat('username',"false");
        }
    }
    catch  (e)
    {
      getdat('ErrorCon',"true");
      //print('Erreo: ${e.value }');
    }

  }

  getdat (String Key,String Value) async
  {

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    //localStorage.setString(Key, json.encode(Value).replaceAll('"', ''));
    localStorage.setString(Key,Value);

  }
}
