import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/data/models/url_download_model.dart';
import 'package:youtube_downloader_app/screens/base_screens/main_screen.dart';
import 'package:youtube_downloader_app/screensWidget/audio_video_body_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_downloader_app/route/route_helper.dart';

class DownloadListScreen extends StatelessWidget {
  const DownloadListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MainScreen(screenBodyWidget: AudioVideoBodyWidget());
  }
}
