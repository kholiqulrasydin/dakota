import 'package:dakota/Services/auth.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/animations/fade_in.dart';
import 'package:dakota/forgot_password.dart';
import 'package:dakota/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  void auth(String email, String pass) async {
    String myurl =
        "apidinper.reboeng.com/api/login";
    http.post(myurl, headers: {
      'Accept': 'application/json',
    }, body: {
      "email": email,
      "password": pass
    }).then((response) {
      print(response.statusCode);
      print(response.body);

      });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50.0, right: 30.0, left: 30.0),
            child: FadeIn(1.0, Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alatsi',
                  ),
                ),
//                InkWell(
//                  child: Text(
//                    'Sign Up',
//                    textAlign: TextAlign.end,
//                    style: TextStyle(
//                      color: Colors.grey,
//                      fontSize: 25.0,
//                      fontWeight: FontWeight.bold,
//                      fontFamily: 'Alatsi',
//                    ),
//                  ),
//                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => Signup()),
//                    );
//                  },
//                ),
              ],
            ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 50.0, left: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeIn(1.4, TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Username or Email Address',
                          contentPadding:
                          const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        ),
                      ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FadeIn(1.6, TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: _viewPassword,
                          ),
                          contentPadding:
                          const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        ),
                        obscureText: _obscureText,
                      ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      FadeIn(1.8, Container(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Alatsi',
                              fontSize: 15.0,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPassword()),
                            );
                          },
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                FadeIn(2.0, InkWell(
                  child: Container(
                    height: 45.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.grey[300],
                      color: Colors.white,
                      borderOnForeground: false,
                      elevation: 5.0,
                      child: GestureDetector(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 7.0,
                              ),
                              Text(
                                "LOG IN",
                                style: TextStyle(
                                  fontFamily: 'Alatsi',
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    print('Login Start');
//                    auth(_emailController.text, _passwordController.text);
                    await AuthServices.signIn(context, authProvider,_emailController.text, _passwordController.text);
                  },
                ),
                ),
                SizedBox(
                  height: 25.0,
                ),
//                FadeIn(2.2, Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      'Don\'t Have an Account?',
//                      style: TextStyle(
//                        color: Colors.grey[600],
//                        fontSize: 15.0,
//                        fontFamily: 'Alatsi',
//                      ),
//                    ),
//                    SizedBox(
//                      width: 5.0,
//                    ),
//                    InkWell(
//                      child: Text(
//                        'Register',
//                        style: TextStyle(
//                          color: Colors.grey[700],
//                          fontSize: 18.0,
//                          fontFamily: 'Alatsi',
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
//                      onTap: () {
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => Signup()),
//                        );
//                      },
//                    ),
//                  ],
//                ),
//                ),
//                SizedBox(
//                  height: 15.0,
//                ),
//                FadeIn(2.4, Text(
//                  "Continue with",
//                  style: TextStyle(
//                    color: Colors.grey,
//                    fontSize: 18.0,
//                    fontFamily: 'Alatsi',
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//                ),
//                SizedBox(
//                  height: 15.0,
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    FadeIn(2.6, InkWell(
//                      child: Container(
//                        width: 60.0,
//                        height: 60.0,
//                        decoration: new BoxDecoration(
//                          color: Theme.of(context).primaryColor,
//                          image: new DecorationImage(
//                            image: new AssetImage('assets/google_plus.png'),
//                            fit: BoxFit.cover,
//                          ),
//                          borderRadius:
//                          new BorderRadius.all(new Radius.circular(30.0)),
//                          border: new Border.all(width: 0.0),
//                        ),
//                      ),
//                      onTap: () {},
//                    ),
//                    ),
//                    SizedBox(
//                      width: 18.0,
//                    ),
//                    FadeIn(2.8, InkWell(
//                      child: Container(
//                        width: 60.0,
//                        height: 60.0,
//                        decoration: new BoxDecoration(
//                          color: const Color(0xff7c94b6),
//                          image: new DecorationImage(
//                            image: new AssetImage('assets/fb.png'),
//                            fit: BoxFit.cover,
//                          ),
//                          borderRadius:
//                          new BorderRadius.all(new Radius.circular(30.0)),
//                          border: new Border.all(width: 0.0),
//                        ),
//                      ),
//                      onTap: () {},
//                    ),
//                    ),
//                  ],
//                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
