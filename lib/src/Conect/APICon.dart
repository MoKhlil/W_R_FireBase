import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class Network {
  final String _url = 'your server ';

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
  Future<void> createData(String Id,String Pass) async {

    await FirebaseDatabase.instance.reference().child('Login').child(Id)
        .set({
      'title': 'Realtime db rocks',
      'created_at': 'mo',
    });
    // await  databaseReference.child(Id).set({
    //   'passw0rd': Pass,
    // });
  }

  Future<String> readData(String Id)   async {
     await FirebaseDatabase.instance.reference().once().then((DataSnapshot snapshot)     async {
      if(snapshot.value[Id] != null) {
        getdat('firreadData', snapshot.value[Id]['pass'].toString());
      }
    });
///////////////////////////////////////
  }

  getdat (String Key,String Value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    //localStorage.setString(Key, json.encode(Value).replaceAll('"', ''));
    localStorage.setString(Key,Value);
  }
}
