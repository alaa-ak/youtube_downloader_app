import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_downloader_app/bloc/url_download_bloc.dart';
import 'package:youtube_downloader_app/data/models/url_download_model.dart';
import 'package:youtube_downloader_app/route/route_helper.dart';
import 'package:youtube_downloader_app/screensWidget/text_widget.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '/screensWidget/alert_snack_bar_widget.dart' as alertSnackBarWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_downloader_app/bloc/url_download_bloc.dart';
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';

class DownloadingScreen extends StatefulWidget {
  final String? url;
  final YoutubeExplode yt;
  final UrlDownloadModel? urlDownloadItem;
  final String urlDownloadType;

  DownloadingScreen({
    super.key,
    required this.url,
    required this.yt,
    required this.urlDownloadItem,
    required this.urlDownloadType,
  });

  @override
  State<DownloadingScreen> createState() => _DownloadingScreenState();
}

class _DownloadingScreenState extends State<DownloadingScreen> {
  double _progress = 0;
  bool _downloading = true;
  bool _isProgressingFinish = false;
  late String _filePath;

  @override
  void initState() {
    BlocProvider.of<UrlDownloadBloc>(context).isDownloadingFinishSetter =
        false; //Initializing the value of isDownloadingFinishSetter
    print(
        'is Downloading is ${BlocProvider.of<UrlDownloadBloc>(context).isDownloadingFinish}');
    _prepareSaveDir();
    _ytDownloadToStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
          primary: true,
          backgroundColor: AppColors.mainColor,
          title: Container(
            margin: EdgeInsets.only(left: Dimensions.width15 * 4),
            child: TextWidget(
              text: "Downloading",
              size: Dimensions.font20,
            ),
          ),
          leading: GestureDetector(
              onTap: () {
                _onPressedFun();
              },
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Icon(
                  Icons.close,
                  size: Dimensions.iconSize25,
                  color: AppColors.textColor,
                ),
              ))),
      body: _downloading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.download,
                  color: AppColors.textColor,
                  size: Dimensions.iconSize30 * 4,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height20,
                        horizontal: Dimensions.height20),
                    child: LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.grey.shade900,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.textColor),
                    )),
              ],
            )
          : const Center(
              child:
                  Text('Sorry There is something wrong, Please Try Again :)')),
    );
  }

//If pressed Cancel Button ✖
  void _onPressedFun() {
    if (!_isProgressingFinish) {
      ScaffoldMessenger.of(context)
          .showSnackBar(alertSnackBarWidget.AlertSnackBarFunction('Cancel'));
      BlocProvider.of<UrlDownloadBloc>(context).urlDownloadEndPointSetter = '';
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouteHelper.getHomeScreen(),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        RouteHelper.getHomeScreen(),
        (route) => false,
      );
    }
  }

//Downloading the link content
  Future<void> _ytDownloadToStorage() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      if (mounted) {
        // if the state is exist
        setState(() {
          _downloading = true;
          _progress = 0;
        });
      }

      var manifest = await widget.yt.videos.streamsClient
          .getManifest(widget.urlDownloadItem!.urlDownloadId);

      var streams = manifest.muxed.withHighestBitrate();
      var fileType = streams; // Audio Or Video
      var fileTypeStream = widget.yt.videos.streamsClient.get(fileType);

      var file;
      if (widget.urlDownloadType == 'video') {
        file = File('$_filePath/${widget.urlDownloadItem!.urlDownloadId}.mp4');

        BlocProvider.of<UrlDownloadBloc>(context).filePathToOpenSetter =
            '$_filePath/${widget.urlDownloadItem!.urlDownloadId}.mp4';
      }
      if (widget.urlDownloadType == 'audio') {
        file = File('$_filePath/${widget.urlDownloadItem!.urlDownloadId}.mp3');
        BlocProvider.of<UrlDownloadBloc>(context).filePathToOpenSetter =
            '$_filePath/${widget.urlDownloadItem!.urlDownloadId}.mp3';
      }

      //Delete file if exist
      if (file.existsSync()) {
        file.deleteSync();
      }

      //To open file
      var output = file.openWrite(mode: FileMode.writeOnlyAppend);
      var size = fileType.size.totalBytes;
      var count = 0;

      await for (final data in fileTypeStream) {
        // Keep track of the current downloading data
        count += data.length;

        //Calculate the current progress
        double val = ((count / size));
        if (mounted) {
          var msg =
              '${widget.urlDownloadItem!.urlDownloadTitle} Download to $_filePath/${widget.urlDownloadItem!.urlDownloadId}';
          for (val; val == 1.0; val++) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  msg,
                  style: TextStyle(color: AppColors.mainColor),
                ),
                backgroundColor: AppColors.textColor));
            print('The message is ' + msg);
          }
        }

        if (mounted) {
          // if the state is exist
          setState(() {
            _progress = val;
          });
          // Write to file.
          output.add(data);
        }
      }

      print('Yes Done');
      if (mounted) {
        _isProgressingFinish = true;
        BlocProvider.of<UrlDownloadBloc>(context).isDownloadingFinishSetter =
            true;
      }
    } else {
      setState(() {
        _downloading = false;
      });
      await Permission.storage.request();
    }
  }

// Confirm if the File path is exist or not // if it is not create a new one
  Future<void> _prepareSaveDir() async {
    _filePath = (await _findLocalPath());
    print(_filePath);
    final saveDir = Directory(_filePath);
    bool hasExisted = await saveDir.exists();
    if (!hasExisted) {
      saveDir.create();
    }
  }

// Create File Path
  Future<String> _findLocalPath() async {
    print("Hi i am findLocal file paht");
    var _externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        _externalStorageDirPath =
            await ExternalPath.getExternalStoragePublicDirectory(
                ExternalPath.DIRECTORY_DOWNLOADS);
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        _externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      _externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    print('the File path $_externalStorageDirPath');
    return _externalStorageDirPath;
  }
}
