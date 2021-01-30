import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/api/user.dart';
import 'Services/providers/user.dart';
import 'animations/FadeAnimation.dart';
import 'animations/sizeconfig.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<ScaffoldState> _signUpKey = new GlobalKey<ScaffoldState>();
  bool register = false;
  String privilegesTitle = "Pilih Salah Satu";
  int privileges;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: SizeConfig.heightMultiplier * 130,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(1, Text("Buat Akun", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),)),
                  SizedBox(height: 20,),
                  FadeAnimation(1.2, Text("Buat Akun dan tambahkan pengguna baru", style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700]
                  ),)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1.2, makeInput(label: "Nama Lengkap", controller: name)),
                  FadeAnimation(1.2, makeInput(label: "Email", controller: email)),
                  FadeAnimation(1.3, makeInput(label: "Kata Sandi", obscureText: true, controller: password)),
                  FadeAnimation(1.4, makeInput(label: "Konfirmasi Kata Sandi", obscureText: true, controller: cPassword)),
                  FadeAnimation(1.5, Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Hak Akses", style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87
                      ),),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.3,),
                      DropdownButton<String>(
                        hint: Text('$privilegesTitle'),
                        items: <String>['User', 'Admin'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_val) {
                          setState(() {
                            privilegesTitle = _val;
                          });
                          if(_val == "User"){
                            setState(() {
                              privileges = 0;
                            });
                          }else{
                            setState(() {
                              privileges = 1;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 30,),
                    ],
                  )
                  )
                ],
              ),
              FadeAnimation(1.5, Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )
                ),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
                    !register ? await UserApi.registerNewUser(userProvider, name.text, email.text, password.text, cPassword.text, privileges)
                        .then((value){
                          if(value == 200){
                            print("New User Registered Successfully");
                            setState(() {
                              register = true;
                            });
                            _signUpKey.currentState.showSnackBar(SnackBar(content: Text('Berhasil menambahkan user baru', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blueAccent.shade400, duration: Duration(seconds: 5),));
                          } else if(value == 500){
                            _signUpKey.currentState.showSnackBar(SnackBar(content: Text('Terjadi kesalahan server', style: TextStyle(color: Colors.white),), backgroundColor: Colors.redAccent.shade400, duration: Duration(seconds: 5),));
                          } else {
                            print(value.toString());
                          }
                    }) : Navigator.of(context).pop();
                  },
                  color: !register ? Colors.blueAccent[100] : Colors.blueAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text(!register ? "Buat Akun" : "Kembali", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    color: !register ? Colors.black : Colors.white
                  ),),
                ),
              )),
              FadeAnimation(1.6, Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Status registrasi akun baru : "),
                  Text(!register ? "Belum Terdata" : "Terdata", style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18
                  ),),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87
        ),),
        SizedBox(height: SizeConfig.heightMultiplier * 0.3,),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

}