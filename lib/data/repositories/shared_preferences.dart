import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../models/url_download_model.dart';

class SharedPreferencesClass {
  static String storageDataList = 'storage-data-list';
  final SharedPreferences sharedPreferences;
  SharedPreferencesClass({required this.sharedPreferences});

  List<String> _storageDataAsList = [];
  List<String> get storageDataAsList => _storageDataAsList;

  //To Set SharedPreferences Items
  void storageDataFun(List<UrlDownloadModel> list) {
    _storageDataAsList = [];

    list.forEach((element) => _storageDataAsList.add(jsonEncode(element)));

    sharedPreferences.setStringList(storageDataList, _storageDataAsList);
  }

  //To Get SharedPreferences Items
  List<UrlDownloadModel> getStorageDataList() {
    // sharedPreferences.remove(storageDataList);
    List<String> storageDataStringList = [];
    if (sharedPreferences.containsKey(storageDataList)) {
      storageDataStringList = sharedPreferences.getStringList(storageDataList)!;
    }
    List<UrlDownloadModel> storageDataAsObjectList = [];
    try {
      storageDataStringList.forEach((element) => storageDataAsObjectList
          .add(UrlDownloadModel.formJson(jsonDecode(element))));
      print('List of Object is ${storageDataAsObjectList}' +
          'The length i s ${storageDataAsObjectList.length}');
    } catch (e) {
      print('Error is ' + e.toString());
    }

    return storageDataAsObjectList;
  }
}
