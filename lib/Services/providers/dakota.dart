import 'dart:collection';

import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/cupertino.dart';

class DakotaProvider with ChangeNotifier{
  List<DakotaModel> _dakotaList = [];
  DakotaProvider _currentDakota;

  UnmodifiableListView<DakotaModel> get dakotaList => UnmodifiableListView(_dakotaList);
  DakotaProvider get dakotaProvider => _currentDakota;

  set dakotaList(List<DakotaModel> dakotaList){
    _dakotaList = dakotaList;
    notifyListeners();
  }

  set currentDakota(DakotaProvider dakotaProvider){
    _currentDakota = dakotaProvider;
    notifyListeners();
  }

  static Future<void> getCategory(BuildContext context, AuthProvider authProvider, DakotaProvider dakotaProvider, String category) async {
    DakotaApi.fetchDakota(authProvider, dakotaProvider, category);
  }
}