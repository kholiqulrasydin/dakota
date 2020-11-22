import 'package:dakota/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/api/user.dart';
import 'Services/providers/user.dart';
import 'animations/loader.dart';
import 'animations/sizeconfig.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final GlobalKey<ScaffoldState> _userListViewKey = new GlobalKey<ScaffoldState>();
  String stateSetter = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    UserApi.getAllUSer(userProvider);
  }

  Future<void> _onRefresh() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.usersList.isEmpty;
    UserApi.getAllUSer(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    void _onSelectedPopUp(String value) {
      TextEditingController _password = TextEditingController();
      switch (value.substring(0, 1)) {
        case "c":
          print('changing password with id ${value.substring(1)}');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Ubah Password'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Masukkan password baru'),
                      TextField(
                        controller: _password,
                        decoration: InputDecoration(
                          labelText: 'Password'
                        ),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () async {
                          await UserApi.userPasswordUpdate(int.parse(value.substring(1)), _password.text)
                              .then((value) {
                                if(value == 200){
                                  _userListViewKey.currentState.showSnackBar(SnackBar(content: Text('Password berhasil diperbarui!', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blueAccent.shade400, duration: Duration(seconds: 5),));
                                  Navigator.pop(context);
                                  _onRefresh();
                                }else{
                                  _userListViewKey.currentState.showSnackBar(SnackBar(content: Text('Mohon maaf, kesalahan server', style: TextStyle(color: Colors.white),), backgroundColor: Colors.redAccent.shade400, duration: Duration(seconds: 5),));
                                  Navigator.pop(context);
                                }
                          });
                        },
                        child: Text(
                          "Ubah Password",
                          style: TextStyle(color: Colors.blueAccent.shade400),
                        )),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Batal", style: TextStyle(color: Colors.blueGrey))),
                  ],
                );
              });
          break;
        case "p":
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Ubah Hak Akses'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'Apakah anda yakin ingin mengubah hak akses pengguna ini?'),
                        FlatButton(
                            onPressed: () async {
                              if (value.substring(1, 2) == "1") {
                                print(
                                    'changing privileges with id ${value.substring(2)} to users privileges');
                                UserApi.userPrivilegesUpdate(int.parse(value.substring(2)), 0)
                                .then((value) {
                                  if(value == 200){
                                    _userListViewKey.currentState.showSnackBar(SnackBar(content: Text('Hak Akses berhasil diubah!', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blueAccent.shade400, duration: Duration(seconds: 5),));
                                    Navigator.pop(context);
                                    _onRefresh();
                                  }else{
                                    _userListViewKey.currentState.showSnackBar(SnackBar(content: Text('Mohon maaf, kesalahan server', style: TextStyle(color: Colors.white),), backgroundColor: Colors.redAccent.shade400, duration: Duration(seconds: 5),));
                                    Navigator.pop(context);
                                  }
                                });
                              } else if (value.substring(1, 2) == "0") {
                                print(
                                    'changing privileges with id ${value.substring(2)} to admins privileges');
                                UserApi.userPrivilegesUpdate(int.parse(value.substring(2)), 1)
                                    .then((value) {
                                  if(value == 200){
                                    _userListViewKey.currentState.showSnackBar(SnackBar(content: Text('Hak Akses berhasil diubah!', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blueAccent.shade400, duration: Duration(seconds: 5),));
                                    Navigator.pop(context);
                                    _onRefresh();
                                  }else{
                                    _userListViewKey.currentState.showSnackBar(SnackBar(content: Text('Mohon maaf, kesalahan server', style: TextStyle(color: Colors.white),), backgroundColor: Colors.redAccent.shade400, duration: Duration(seconds: 5),));
                                    Navigator.pop(context);
                                  }
                                });
                              }
                            },
                            child: Text(
                              "Iya Ubah!",
                              style:
                                  TextStyle(color: Colors.blueAccent.shade400),
                            )),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Tidak")),
                      ],
                    ));
              });
          break;

        case "d":
          print('deleting user with id ${value.substring(1)}');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Hapus Data'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Apakah anda yakin ingin menghapus pengguna ini?'),
                        FlatButton(
                            onPressed: () async {
                              await UserApi.userDelete(int.parse(value.substring(1)))
                                  .then((value) {
                                if(value == 200){
                                  _userListViewKey.currentState.showSnackBar(SnackBar(content: Text('Pengguna telah dihapus', style: TextStyle(color: Colors.white),), backgroundColor: Colors.blueAccent.shade400, duration: Duration(seconds: 5),));
                                  Navigator.pop(context);
                                  _onRefresh();
                                }else{
                                  _userListViewKey.currentState.showSnackBar(SnackBar(content: Text('Mohon maaf, kesalahan server', style: TextStyle(color: Colors.white),), backgroundColor: Colors.redAccent.shade400, duration: Duration(seconds: 5),));
                                  Navigator.pop(context);
                                }
                              });
                            },
                            child: Text(
                              "Iya Hapus!",
                              style:
                                  TextStyle(color: Colors.redAccent.shade400),
                            )),
                        FlatButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Text("Tidak")),
                      ],
                    ));
              });
          break;
      }
    }

    return Consumer<UserProvider>(
      builder: (_, userProvider, __) => Loader(
        inAsyncCall: userProvider.usersList.isEmpty,
        child: Scaffold(
          key: _userListViewKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Data Pengguna',
              style: TextStyle(color: Colors.blueGrey),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.blueGrey,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  }),
            ],
          ),
          body: Center(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 2,
                    vertical: SizeConfig.heightMultiplier * 1),
                itemCount: userProvider.usersList.length,
                itemBuilder: (BuildContext context, int index) {
                  final _user = userProvider.usersList[index];
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.imageSizeMultiplier * 10,
                          height: SizeConfig.imageSizeMultiplier * 10,
                          child: Image.asset('assets/user.png'),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: SizeConfig.widthMultiplier * 5),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _user.name,
                                  style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 3,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 1,
                                ),
                                Container(
                                  width: SizeConfig.widthMultiplier * 60,
                                  child: Text(
                                    _user.email,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        color: Colors.grey[500]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: (_user.email != 'admin@email.com')
                              ? PopupMenuButton(
                                  onSelected: _onSelectedPopUp,
                                  itemBuilder: (BuildContext context) => [
                                        PopupMenuItem(
                                            value: 'c${_user.id}',
                                            child: Text('Ubah Password')),
                                        PopupMenuItem(
                                            value:
                                                'p${_user.privileges}${_user.id}',
                                            child: Text(
                                                'Ubah Hak Akses ${_user.privileges != 1 ? 'ke Administrator' : 'ke User'}')),
                                        PopupMenuItem(
                                            value: 'd${_user.id}',
                                            child: Text('Hapus Pengguna')),
                                      ])
                              : Text('R. Act  '),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
