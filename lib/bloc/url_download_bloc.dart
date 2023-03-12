import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/screens/base_screens/downloading_screen.dart';
import '../data/models/url_download_model.dart';
import '../data/repositories/url_download_repository.dart';
part 'url_download_event.dart';
part 'url_download_state.dart';

class UrlDownloadBloc extends Bloc<UrlDownloadEvent, UrlDownloadState> {
  late UrlDownloadRepository _urlDownloadRepository;
  List<UrlDownloadModel> _storageData;
  List<UrlDownloadModel> get storageData => _storageData;

  set urlDownloadEndPointSetter(String url) {
    _urlDownloadRepository.urlDownloadEndPoint = url;
  }

  String? get urlDownloadEndPoint {
    return _urlDownloadRepository.urlDownloadEndPoint;
  }

  UrlDownloadModel? _urlDownloadItem;
  UrlDownloadModel? get urlDownloadItem => _urlDownloadItem;

  String _urlDownloadType = '';
  set urlDownloadTypeSetter(String urlDownloadType) {
    _urlDownloadType = urlDownloadType;
  }

  String get urlDownloadTypeGetter => _urlDownloadType;

  String _updateUrlDownloadType = '';
  String get updateUrlDownloadType => _updateUrlDownloadType;

  late bool _isDownloadingFinish;
  // when Progressing is Finish To emit UpdateState()
  set isDownloadingFinishSetter(bool isFinish) {
    _isDownloadingFinish = isFinish;
  }

  void removeStorageDataItem(String title) {
    // To Remove Item from Download List Screen
    _urlDownloadRepository.removeStorageDataItem(title);
    _storageData = _urlDownloadRepository.getStorageData();
  }

  bool get isDownloadingFinish => _isDownloadingFinish;

  String _filePathToOpen = '';
  set filePathToOpenSetter(String filePath) {
    _filePathToOpen = filePath;
  }

  String get filePathToOpen => _filePathToOpen;

  UrlDownloadBloc(this._urlDownloadRepository, this._storageData)
      : super(UrlInitialState()) {
    on<UrlDownloadEvent>((event, emit) {});
//Past link State has two status : Empty and Exist
    on<PressDownloadButtonEvent>((event, emit) async {
      bool _validUrl = Uri.parse(urlDownloadEndPoint!)
          .isAbsolute; // To Confirm if the url is valid or not

      if (urlDownloadEndPoint!.isEmpty) {
        // if the the link is not exist
        emit(EmptyUrlState());
      } else if (_validUrl) {
        // if the link is exist has three status:- Load , Check, Success
        emit(ExistUrlState());
        _urlDownloadItem = await _urlDownloadRepository.getUrlDownload(
            _urlDownloadRepository
                .urlDownloadEndPoint!); //Get EndPoint from TextField that user entered from Download-Link-Screen
        await Future.delayed(const Duration(seconds: 4));

        emit(LoadUrlDownloadState());

        await Future.delayed(const Duration(seconds: 4));

        while (_urlDownloadType.isEmpty) {
          // To know if the type is video or audio for downloading
          if (_urlDownloadType.isNotEmpty) break;

          emit(CheckUrlDownloadTypeState());
          await Future.delayed(const Duration(seconds: 6));
        }

        if (_urlDownloadType.isNotEmpty) {
          _updateUrlDownloadType = _urlDownloadType.substring(0, 5);
          print('UpDate UrlDownloadType is ' + _updateUrlDownloadType);
        }

        _urlDownloadRepository.urlDownloadTypeSetter =
            '.$_updateUrlDownloadType';

        var yt = _urlDownloadRepository.youtubeDownload;

        emit(SuccessUrlDownloadState(DownloadingScreen(
            url: urlDownloadEndPoint,
            yt: yt,
            urlDownloadItem: _urlDownloadItem,
            urlDownloadType: _updateUrlDownloadType)));

        await Future.delayed(const Duration(seconds: 10));

        while (!_isDownloadingFinish) {
          // if downloading dose not finish yet await,  if it is finishing break and emit(UpdateState)
          if (_isDownloadingFinish) break;

          await Future.delayed(const Duration(seconds: 4));
        }

        _urlDownloadRepository.addItemToDevice(
            _urlDownloadItem!, _filePathToOpen); // add item to device

        emit(UpdateDataState());
        _storageData = _urlDownloadRepository
            .getStorageData(); //Update The ListView Widget that displayed Videos and audios that exist in SharedPreferences
        await Future.delayed(const Duration(seconds: 10));
      } else {
        emit(ErrorUrlDownloadState(error: 'Sorry The Error is '));
      }
    });
  }
}
