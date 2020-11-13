import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/home.dart';
import 'package:dakota/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_,authProvider,__){
      authProvider.getTokenFromPrefs();
      return (authProvider.currentToken == null) ? LoginPage() : HomePage() ;
    });
  }
}
