import 'dart:collection';

import 'package:dakota/Dashboard/pie_chart.dart';
import 'package:dakota/model/BantuanUsahaModel.dart';
import 'package:flutter/cupertino.dart';

class BantuanUsaha with ChangeNotifier{
  List<Category> _jData;
  List<BantuanUsahaModel> _bantuanUsahaList = [];
  BantuanUsaha _currentBantuanUsaha;

  UnmodifiableListView<BantuanUsahaModel> get bantuanUsahaList => UnmodifiableListView(_bantuanUsahaList);
  BantuanUsaha get bantuanUsaha => _currentBantuanUsaha;

  get jData => _jData;

  set bantuanUsahaList(List<BantuanUsahaModel> bantuanUsahaList){
    _bantuanUsahaList = bantuanUsahaList;
    notifyListeners();
  }

  set currentBantuanUsaha(BantuanUsaha bantuanUsaha){
    _currentBantuanUsaha = bantuanUsaha;
    notifyListeners();
  }
//  String get countAlsintan => _jData['alsintan'].toString();
//  String get countSarpras => _jData['sarpras'].toString();
//  String get countBibit => _jData['bibit'].toString();
//  String get countTernak => _jData['ternak'].toString();
//  String get countPerikanan => _jData['perikanan'].toString();
//  String get countLainnya => _jData['lainnya'].toString();

  set jData(List<Category> data){
    _jData = data;
    notifyListeners();
  }
}