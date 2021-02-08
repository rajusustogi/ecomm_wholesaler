import 'dart:convert';

import 'package:ecomm_wholesaler/LoginPage.dart';
import 'package:ecomm_wholesaler/Models/UserModel.dart';
import 'package:ecomm_wholesaler/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SController());
  }
}
class SController extends StatefulWidget {
  
  @override
  _SControllerState createState() => _SControllerState();
}

class _SControllerState extends State<SController> {
  String p;
  UserData user;
  isLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
     
    print(token);
    if (token == null) {
      setState(() {
        p = 'login';
      });
    } else {
      setState(() {
        p = 'home';
        user = UserData.fromJson(json.decode(pref.getString('user')));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    switch (p) {
      case 'login':
        return LoginPage();
      case 'home':
        return ProductDetails(user:user);
      default:
        return LoginPage();
    }
  }
}
