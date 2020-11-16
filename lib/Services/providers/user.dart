import 'dart:collection';
import 'package:dakota/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier{
  List<UserModel> _personalUser = [];
  List<UserModel> _users = [];

  UserProvider _currentUserProvider;

  UnmodifiableListView<UserModel> get personalUser => UnmodifiableListView(_personalUser);
  UnmodifiableListView<UserModel> get users => UnmodifiableListView(_users);

  UserProvider get userProvider => _currentUserProvider;

  set personalUserList(List<UserModel> userList){
    _personalUser = userList;
    notifyListeners();
  }

  set users(List<UserModel> users){
    _users = users;
    notifyListeners();
  }

  set currentUser(UserProvider userProvider){
    _currentUserProvider = userProvider;
    notifyListeners();
  }
}