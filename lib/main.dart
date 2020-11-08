import 'package:dakota/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(DakotaStart());
}

class DakotaStart extends StatefulWidget {
  @override
  _DakotaStartState createState() => _DakotaStartState();
}

class _DakotaStartState extends State<DakotaStart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dinas Pertanian App',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.white,
      ),
      theme: ThemeData(
        canvasColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
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
    );
  }
}
