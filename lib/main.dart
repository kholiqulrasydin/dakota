import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/home.dart';
import 'package:dakota/login_page.dart';
import 'package:dakota/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(StartDakota());
}

class StartDakota extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      systemNavigationBarColor: Colors.blue[600],
//      statusBarBrightness: Brightness.light,
//      statusBarIconBrightness: Brightness.dark
//    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => DakotaProvider()),
        ChangeNotifierProvider(create: (context) => BantuanUsaha()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            'Home Page' : (BuildContext context) => HomePage(),
            'Login' : (BuildContext context) => LoginPage(),
          },
          title: 'Dinas Pertanian App',
          theme: ThemeData(
            primaryColor: Colors.blue[400],
            textTheme: TextTheme(
              headline1: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.w900,
                  color: Color.fromRGBO(49, 68, 105, 1),
                ),
              ),
              headline4: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(49, 68, 105, 1),
                ),
              ),
            ),
          ),
          home: Wrapper()
      ),
    );
  }
}
