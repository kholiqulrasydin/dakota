import 'dart:collection';

import 'package:dakota/Services/api/dakota.dart';
import 'package:dakota/Services/providers/auth.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/cupertino.dart';

class DakotaProvider with ChangeNotifier{
  List<DakotaModel> _dakotaList = [];
  List<DakotaModel> _dakotaListLatest = [];
  List<DakotaModel> _dakotaListOnce = [];
  DakotaProvider _currentDakota;

  UnmodifiableListView<DakotaModel> get dakotaList => UnmodifiableListView(_dakotaList);
  UnmodifiableListView<DakotaModel> get dakotaListLatest => UnmodifiableListView(_dakotaListLatest);
  UnmodifiableListView<DakotaModel> get dakotaListOnce => UnmodifiableListView(_dakotaListOnce);
  DakotaProvider get dakotaProvider => _currentDakota;

  set dakotaList(List<DakotaModel> dakotaList){
    _dakotaList = dakotaList;
    notifyListeners();
  }

  set dakotaListLatest(List<DakotaModel> dakotaList){
    _dakotaListLatest = dakotaList;
    notifyListeners();
  }

  set dakotaListOnce(List<DakotaModel> dakotaList){
    _dakotaListOnce = dakotaList;
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