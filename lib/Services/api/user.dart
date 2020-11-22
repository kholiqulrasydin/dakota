import 'dart:convert';

import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserApi{

  static Future<void> userFetch(UserProvider userProvider)async{
    final prefs = await SharedPreferences.getInstance();

    await http.get(
        'http://apidinper.reboeng.com/api/account/getUser',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        }).then((response){
          if(response.statusCode == 200){

            String content = response.body;
            List user = jsonDecode(content);
            userProvider.personalUserList = user.map((e) => UserModel.fromJson(e)).toList();
          }else{
            print('gagal mendapatkan info user!');
          }
    });
  }

  static Future<void> getAllUSer(UserProvider userProvider) async {
    final prefs = await SharedPreferences.getInstance();

    await http.get(
        'http://apidinper.reboeng.com/api/account/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        }).then((response){
      if(response.statusCode == 200){

        String content = response.body;
        List user = jsonDecode(content);
        userProvider.usersList = user.map((e) => UserModel.fromJson(e)).toList();
      }else{
        print('gagal mendapatkan List User!');
      }
    });
  }


  static Future<int> registerNewUser(UserProvider userProvider, String name, String email, String password, String cPassword, int privileges)async{
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.post(
        'http://apidinper.reboeng.com/api/account/register',
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
    body: {
          'name' : name,
          'email' : email,
          'password' : password,
          'c_password' : cPassword,
          'privileges' : privileges.toString()
    });

    return response.statusCode;
  }

  static Future<void> userUpdateNoPassword(UserProvider userProvider, String name, String email, int privileges)async{
    final prefs = await SharedPreferences.getInstance();
    await http.put(
        'http://apidinper.reboeng.com/api/account/update',
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: {
          'name' : name,
          'email' : email,
          'privileges' : privileges.toString()
        }).then((response){
      if(response.statusCode == 200){
        print('oke! ${response.statusCode.toString()}');
      }else{
        print('gagal memperbarui user!');
      }
    });
  }

  static Future<void> userUpdatewWithPassword(UserProvider userProvider, String id, String name, String email, String password, int privileges)async{
    final prefs = await SharedPreferences.getInstance();
    await http.post(
        'http://apidinper.reboeng.com/api/account/update',
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: {
          'id' : id,
          'name' : name,
          'email' : email,
          'password' : password,
          'privileges' : privileges.toString()
        }).then((response){
      if(response.statusCode == 200){
        print('oke! ${response.statusCode.toString()}');
      }else{
        print('gagal memperbarui user! ${response.statusCode.toString()}');
      }
    });
  }

  static Future<int> userPasswordUpdate(int id, String password)async{
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.post(
        'http://apidinper.reboeng.com/api/account/updatePassword',
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: {
          'id' : id.toString(),
          'password' : password
        });
    return response.statusCode;
  }

  static Future<int> userPrivilegesUpdate(int id, int privileges)async{
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.post(
        'http://apidinper.reboeng.com/api/account/updatePrivileges',
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: {
          'id' : id.toString(),
          'privileges' : privileges.toString()
        });
    return response.statusCode;
  }

  static Future<int> userDelete(int id)async{
    final prefs = await SharedPreferences.getInstance();
    final http.Response response = await http.delete(
        'http://apidinper.reboeng.com/api/account/delete/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        });

    return response.statusCode;
  }

}