import 'package:dakota/Services/api/user.dart';
import 'package:dakota/Services/providers/user.dart';
import 'package:dakota/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<ScaffoldState> _profileKey = new GlobalKey<ScaffoldState>();
  List<UserModel> userData = [];
  String name;
  String email;
  String password ='n';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  bool showPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
  }

  void onRefresh(){
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    UserApi.userFetch(userProvider);
    setState(() {
      userData = userProvider.personalUser;
    });
    controllerSet();
  }

  void controllerSet(){
    setState(() {
      name = userData.first.name;
      email = userData.first.email;
      _nameController = new TextEditingController(text: userData.first.name);
      _emailController = new TextEditingController(text: userData.first.email);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _profileKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent.shade400,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blueAccent.shade400,
            ),
            onPressed: () {
//              Navigator.of(context).push(MaterialPageRoute(
//                  builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Text(
                "Howdy, ${userData.first.name}!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Image(image: (userData.first.privileges == 0)
                          ? NetworkImage(
                        "http://apidinper.reboeng.com/image/user.png",
                      )
                          : NetworkImage(
                          "http://apidinper.reboeng.com/image/crown.png")),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _nameController,
                  onChanged: (_val){
                    setState(() {
                      name = _val;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Nama Lengkap',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _emailController,
                  onChanged: (_val){
                    setState(() {
                      email = _val;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'E-mail',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: _passwordController,
                  onChanged: (_val){
                    setState(() {
                      password = _val;
                    });
                  },
                  obscureText: showPassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                            _passwordController = new TextEditingController(text: password);
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Ubah Password',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                ),
              ),
//              buildTextField("E-mail", userData.first.email, false),
//              buildTextField("Ubah Password", "", true),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: () async {
                      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
                      password == 'n' ?
                      await UserApi.userUpdateNoPassword(userProvider, name, email, userData.first.privileges)
                      : await UserApi.userUpdatewWithPassword(userProvider, name, email, password, userData.first.privileges);
                      _profileKey.currentState.showSnackBar(SnackBar(content: Text('Data berhasil diperbarui!', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blueAccent.shade400, duration: Duration(seconds: 5),));
                      onRefresh();
                    },
                    color: Colors.blueAccent.shade400,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "PERBARUI",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    TextEditingController _controller = TextEditingController();
    if(!isPasswordTextField){
      _controller = new TextEditingController(text: placeholder.toString());
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: _controller,
        onChanged: (_val){
          setState(() {

          });
        },
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                        _controller = new TextEditingController(text: placeholder.toString());
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
