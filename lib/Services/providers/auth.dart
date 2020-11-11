import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier{
  String _token;

  set token(String token){
    _token = token;
    notifyListeners();
  }

  String get currentToken => _token;

}