import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:youtube_downloader_app/data/models/url_download_model.dart';
import 'package:youtube_downloader_app/data/repositories/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:convert';

class UrlDownloadRepository {
  late String? urlDownloadEndPoint;
  final SharedPreferences sharedPreferences;

  UrlDownloadRepository(
      {required this.urlDownloadEndPoint, required this.sharedPreferences});

  var youtubeDownload = YoutubeExplode(); //Initialize YouTubeDownload

  List<UrlDownloadModel> _urlDownloadList = [];
  List<UrlDownloadModel> get urlDownloadList => _urlDownloadList;

  Map<String, UrlDownloadModel> _urlDownloadItems = {};

  late final SharedPreferencesClass _sharedPreferencesClass =
      SharedPreferencesClass(sharedPreferences: sharedPreferences);

  String _urlDownloadType = ''; // To get urlDownload if it is video or audio
  set urlDownloadTypeSetter(String type) {
    _urlDownloadType = type;
  }

  String get urlDownloadType => _urlDownloadType;

  List<UrlDownloadModel> _storageDataObjectListRepo = [];

  Future<UrlDownloadModel> getUrlDownload(String url) async {
    final UrlDownloadModel urlDownloadModel;

    print("Hi I am getUrlDownload");
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Yes statusCode is ${response.statusCode}');

      var video = await youtubeDownload.videos.get(Uri.parse(url));
      var id = video.id;
      var title = video.title;
      var author = video.author;
      var duration = video.duration;
      var thumbnails = 'https://img.youtube.com/vi/$id/mqdefault.jpg';

      urlDownloadModel = UrlDownloadModel(
          urlDownloadId: id,
          urlDownloadTitle: title,
          urlDownloadAuthor: author,
          urlDownloadDuration: duration,
          urlDownloadThumbnail: thumbnails,
          urlDownloadPath: 'none');

      return urlDownloadModel;
    } else {
      print('Sorry :( ${response.reasonPhrase}');
      throw Exception(response.reasonPhrase);
    }
  }

// To add UrlDownload Items to list for saving more than one item
  void addItemToDevice(UrlDownloadModel localUrlDownloadModel, path) {
    localUrlDownloadModel.urlDownloadTitle =
        localUrlDownloadModel.urlDownloadTitle + urlDownloadType;
    addItem(localUrlDownloadModel, path);
    _urlDownloadItems.forEach((key, value) {
      _urlDownloadList = [];
      _urlDownloadList = _urlDownloadItems.values.toList();
      print('UrlDownload is  ${localUrlDownloadModel.urlDownloadTitle}');
    });

    _sharedPreferencesClass
        .storageDataFun(_urlDownloadList); // To save items in SharedPreferences
  }

  void addItem(UrlDownloadModel urlDownloadModel, String path) {
    if (_urlDownloadItems.containsKey(urlDownloadModel.urlDownloadTitle)) {
      _urlDownloadItems.update(urlDownloadModel.urlDownloadTitle, (value) {
        return UrlDownloadModel(
            urlDownloadId: value.urlDownloadId,
            urlDownloadTitle: value.urlDownloadTitle,
            urlDownloadAuthor: value.urlDownloadAuthor,
            urlDownloadDuration: value.urlDownloadDuration,
            urlDownloadThumbnail: value.urlDownloadThumbnail,
            urlDownloadPath: path);
      });
    } else {
      _urlDownloadItems.putIfAbsent(urlDownloadModel.urlDownloadTitle, () {
        return UrlDownloadModel(
            urlDownloadId: urlDownloadModel.urlDownloadId,
            urlDownloadTitle: urlDownloadModel.urlDownloadTitle,
            urlDownloadAuthor: urlDownloadModel.urlDownloadAuthor,
            urlDownloadDuration: urlDownloadModel.urlDownloadDuration,
            urlDownloadThumbnail: urlDownloadModel.urlDownloadThumbnail,
            urlDownloadPath: path);
      });
    }
  }

  // To get items from SharedPreferences to display in listView
  List<UrlDownloadModel> getStorageData() {
    setStorageData = _sharedPreferencesClass.getStorageDataList();
    print('Set is ' +
        _sharedPreferencesClass.getStorageDataList().length.toString());
    return _storageDataObjectListRepo;
  }

  set setStorageData(List<UrlDownloadModel> items) {
    _storageDataObjectListRepo = items;
    print('length of items prefrs' +
        _storageDataObjectListRepo.length.toString());
    for (int i = 0; i < _storageDataObjectListRepo.length; i++) {
      _urlDownloadItems.putIfAbsent(
          _storageDataObjectListRepo[i].urlDownloadTitle,
          () => _storageDataObjectListRepo[i]);
    }
  }

  void removeStorageDataItem(String title) {
    //Remove Data from SharedPreferences
    print('Length Before' + '${_urlDownloadItems.length}');
    print('Repo Remove Item');
    _urlDownloadItems.removeWhere((key, value) => key == title);
    _urlDownloadList = _urlDownloadItems.values.toList();
    _sharedPreferencesClass.storageDataFun(_urlDownloadList);
    print('Length After' + '${_urlDownloadItems.length}');
    print('repo Removed');
  }
}
