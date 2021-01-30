import 'package:dakota/Services/auth.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/Services/providers/bantuan_usaha.dart';
import 'package:dakota/Services/providers/dakota.dart';
import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/animations/FadeAnimation.dart';
import 'package:dakota/animations/sizeconfig.dart';
import 'package:dakota/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _loginPageKey = new GlobalKey<ScaffoldState>();

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _viewPassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    DakotaProvider dakotaProvider = Provider.of<DakotaProvider>(context);
    BantuanUsaha bantuanUsaha = Provider.of<BantuanUsaha>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        SizeConfig().init(constraints, orientation);
        return Scaffold(
          key: _loginPageKey,
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blue[900],
              Colors.blue[800],
              Colors.blue[400]
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.heightMultiplier * 8,
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.widthMultiplier * 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "SIMENTAN",
                            style: TextStyle(color: Colors.white, fontSize: SizeConfig.textMultiplier * 5),
                          )),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      FadeAnimation(
                          1.3,
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: SizeConfig.textMultiplier * 3),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 5),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 5,
                            ),
                            FadeAnimation(
                                1.4,
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Color.fromRGBO(27, 75, 225, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              hintText: "Email",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: TextField(
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.remove_red_eye),
                                              onPressed: _viewPassword,
                                            ),
                                          ),
                                          obscureText: _obscureText,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                1.5,
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPassword()));
                                    },
                                    child: Text(
                                      "Lupa Password?",
                                      style: TextStyle(color: Colors.grey),
                                    ))),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                1.6,
                                InkWell(
                                  onTap: () async {
                                    print('Login Start');
                                    await AuthServices.signIn(
                                        authProvider,
                                        _emailController.text,
                                        _passwordController.text,
                                        bantuanUsaha,
                                        dakotaProvider,
                                        userProvider)
                                        .then((response)
                                    => response ?
                                    SchedulerBinding.instance.addPostFrameCallback((_) {
                                      Navigator.of(context).pushReplacementNamed('Home Page');
                                    })
                                        :
                                    _loginPageKey.currentState.showSnackBar(SnackBar(
                                          content: Text('email atau password anda tidak terdaftar',style: TextStyle(color: Colors.white),),
                                          duration: Duration(seconds: 5),
                                          backgroundColor: Colors.redAccent.shade400,
                                        ))
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.blue[900]),
                                    child: Center(
                                      child: Text("Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            FadeAnimation(
                                1.5,
                                Text(
                                  "Sistem Informasi, Monitoring dan Evaluasi Pertanian dan Perikanan.\n\nDikelola oleh : ",
                                  style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            FadeAnimation(
                              1.5,
                              Container(
                                  width: 60,
                                  height: 70,
                                  child: Image.asset(
                                      'assets/Lambang_Kabupaten_Ponorogo.png')),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                                1.5,
                                Text(
                                  "Dinas Pertanian, Ketahanan Pangan, dan Perikanan\nKabupaten Ponorogo",
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
    });
  }
}
