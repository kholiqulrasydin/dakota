import 'dart:convert';

import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AuthServices{

  static Future<void> signIn(BuildContext context, AuthProvider authProvider, String email, String password) async{
    print('Logging in API');
    final http.Response response =
    await http.post('http://apidinper.reboeng.com/api/login',
        headers: <String, String>{
          'Content-Type' : 'application/json; charset=UTF-8',
          'Accept': 'application/json',
    },
      body: jsonEncode(<String, String>{
        'email' : email,
        'password' : password
      })
    );

    if(response.statusCode == 200){
      Map<String, dynamic> abstract = jsonDecode(response.body);
      Map<String, dynamic> userToken = abstract['success'];

      print(userToken['token']);
      authProvider.token = userToken['token'];
      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wrapper()));
    }else{
      print('Login Error');
    }
  }

  static Future<void> signOut(BuildContext context, AuthProvider authProvider) async {
    print('Loging Out API');
    final http.Response response =
        await http.post('http://apidinper.reboeng.com/api/logout',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${authProvider.currentToken}'
            },
    );

    if(response.statusCode == 200){
      Map<String, dynamic> abstract = jsonDecode(response.body);

      print(abstract);
      authProvider.token = null;
      return Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wrapper()));
    }else{
      print('Logout Error');
    }
  }
}