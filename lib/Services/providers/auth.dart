import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier{
  String _token;

  set token(String token){
    _token = token;
    notifyListeners();
  }

  String get currentToken => _token;

  Future<void> getTokenFromPrefs()async{
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString('token');
  }

}