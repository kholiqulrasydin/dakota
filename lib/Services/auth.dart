import 'dart:convert';

import 'package:dakota/Services/api/bantuan_usaha.dart';
import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/api/user.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/home.dart';
import 'package:dakota/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static Future<void> signIn(
      BuildContext context,
      GlobalKey<ScaffoldState> loginKey,
      AuthProvider authProvider,
      String email,
      String password,
      BantuanUsaha bantuanUsaha,
      DakotaProvider dakotaProvider,
      UserProvider userProvider) async {
    final prefs = await SharedPreferences.getInstance();

    print('Logging in API');
    final http.Response response = await http.post(
        'http://apidinper.reboeng.com/api/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      Map<String, dynamic> abstract = jsonDecode(response.body);
      Map<String, dynamic> userToken = abstract['success'];

      print(userToken['token']);
      authProvider.token = userToken['token'];

      prefs.setString('token', userToken['token']);

      await UserApi.userFetch(userProvider);

      return Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));

//      return await initialLogged(context, bantuanUsaha, dakotaProvider).then(
//          (value) => Navigator.of(context)
//              .pushReplacement(MaterialPageRoute(builder: (context) => HomePage())));
    } else {
      print('Login Error');
      if(response.statusCode == 500){
      loginKey.currentState.showSnackBar(SnackBar(
        content: Text('Terjadi Kesalahan Server',style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.redAccent.shade400,
      ));}else{
        loginKey.currentState.showSnackBar(SnackBar(
          content: Text('email atau password anda tidak terdaftar',style: TextStyle(color: Colors.white),),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.redAccent.shade400,
        ));
      }

    }
  }

  static Future<void> signOut(BuildContext context) async {
    print('Loging Out API');
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.post(
      'http://apidinper.reboeng.com/api/logout',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> abstract = jsonDecode(response.body);
      print(abstract);
      prefs.setString('token', null);
      return Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print('Logout Error');
    }
  }

  static Future<void> forgotPassword(GlobalKey<ScaffoldState> scaffoldKey, String email) async {
    final http.Response response = await http.post(
        'http://apidinper.reboeng.com/api/password/reset',
        headers: <String, String>{
          'Accept': 'application/json',
        },
        body: {
          'email': email
        });

    if (response.statusCode == 200) {
      print(response.body.toString());

      return scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Link reset password telah dikirim'),
        duration: Duration(seconds: 5),
      ));
    } else {
      print('something wrong, link not sent :)');
      return scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Email tidak terdaftar'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  static Future<void> initialLogged(BuildContext context,
      BantuanUsaha bantuanUsaha, DakotaProvider dakotaProvider) async {
    await DakotaApi.getLast(dakotaProvider);
    return await BantuanUsahaApi.getCountData(bantuanUsaha);
  }

  Future<String> getToken() async {
    String token;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    return token;
  }
}
