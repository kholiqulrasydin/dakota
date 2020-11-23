import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GalleryApi extends Dynamicaly{

  Future<List> fetchAll(Function callback) async {
    print("requested");
    final response = await doGet(setURL(""));
    List<dynamic> list = [];

    if (response.statusCode == 200) {
      for (var item in json.decode(response.body)) {
        list.add(this.convertJsonToObj(item));
        callback(list);
      }
      return list;
    }
    return throw Exception("Failed to load $entity");
  }
  
  Future<List> fetchOnce(int id, Function callback) async {
    print("requested once");
    final response = await doGet(setURL("getOne/$id"));
    List<dynamic> list = [];

    if(response.statusCode == 200){
      for (var item in json.decode(response.body)) {
        list.add(this.convertJsonToObj(item));
        callback(list);
      }
      return list;
    }
    return throw Exception("Failed to load $entity Once");
  }
  
  Future<dynamic> stringUpdate(dynamic obj, Function callback) async {
    final response = await doStringPost(setURL('update'), convertObjToJson(obj));

    if (response.statusCode == 200) {
      var result = convertJsonToObj(json.decode(response.body));
      callback(result);
      return result;
    } else {
      print(response.statusCode.toString());
      throw Exception('Failed to update $entity');
    }
  }

  void printString(dynamic obj) {
    print(this.convertObjToJson(obj));
  }

  void printStringList(List list) {
    for (var item in list) {
      printString(item);
    }
  }

  Future<dynamic> insert(dynamic obj, File image, Function callback) async {
    final response = await doPost(setURL('store'), image, convertObjToJson(obj));
    if (response.statusCode == 200) {
      var result = convertJsonToObj(json.decode(response.body));
      callback(result);
      return result;
    } else {
      print(response.statusCode.toString());
      throw Exception('Failed to insert $entity');
    }
  }

  Future<dynamic> update(dynamic obj, image, Function callback) async {
    final response = await doPost(setURL('update'), image, convertObjToJson(obj));
    if (response.statusCode == 200) {
      var result = convertJsonToObj(json.decode(response.body));
      callback(result);
      return result;
    } else {
      throw Exception('Failed to insert $entity');
    }
  }

  Future delete(id, Function callback) async {
    final response = await doDelete(setURL('delete'), id);
    if (response.statusCode == 200) {
      callback(true);
      return true;
    } else {
      throw Exception('Failed to delete $entity');
    }
  }

  Future doPost(String url, image, jsonObj) async {

    final prefs = await SharedPreferences.getInstance();
    await delayResponse();
    var request = http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('token')}'
    };

    final mimeTypeData = lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
    final file = await http.MultipartFile.fromPath('image', image.path, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    request.fields['title'] = jsonObj['title'];
    request.fields['subtitle'] = jsonObj['subtitle'];
    request.fields['details'] = jsonObj['details'];
    request.files.add(file);
    request.headers.addAll(header);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  Future doStringPost(String url, jsonObj) async {
    final prefs = await SharedPreferences.getInstance();
    await delayResponse();
    final response = await http.post('$url', headers: <String, String>{
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('token')}'
    }, body: jsonObj);

    return response;
  }
  
  Future doDelete(String url, String id) async {
    final prefs = await SharedPreferences.getInstance();
    await delayResponse();
    final response = await http.delete('$url/$id', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${prefs.getString('token')}'
    });

    return response;
  }

  Future doGet(String url) async {
    // startLoading();
    final prefs = await SharedPreferences.getInstance();
    await delayResponse();
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${prefs.getString('token')}'
    });
    // endLoading();
    return response;
  }

  Future delayResponse() async {
    var result =
    await Future.delayed(Duration(milliseconds: delayDuration), () {
      return "Finish";
    });
    return result;
  }

  String setURL(apiPath, [String queryString]) {
    apiPath = apiPath != null && apiPath != "" ? '/$apiPath' : "";
    queryString =
    queryString != null && queryString != "" ? '?$queryString' : "";
    return '$serverURL$entity$apiPath$queryString';
  }

  @override
  convertJsonToObj(json) {
    dynamic jsonn;
    jsonn = json;
    return jsonn;
  }

  @override
  convertObjToJson(json) {
    dynamic jsonn;
    jsonn = json;
    return jsonn;
  }
}

abstract class Dynamicaly{
  dynamic convertJsonToObj(dynamic json);
  dynamic convertObjToJson(dynamic obj);
  final delayDuration = 300;
  String entity = "";
  String serverURL = "http://apidinper.reboeng.com/api/gallery";

  Future<dynamic> insert(dynamic obj, File image, Function callback);

  // update
  Future<dynamic> update(dynamic obj, File image, Function callback);
  
  Future<dynamic> stringUpdate(dynamic obj, Function callback);

  // delete
  Future delete(id, Function callback);


}