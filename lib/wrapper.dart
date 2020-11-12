import 'package:dakota/Services/auth.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/home.dart';
import 'package:dakota/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    return Consumer<AuthProvider>(builder: (_,authProvider,__){
      return (authServices.getToken().toString().length > 2 && authProvider.currentToken != null) ? HomePage() : LoginPage();
    });
  }
}
