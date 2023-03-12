import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/screens/base_screens/app_drawer.dart';
import 'package:youtube_downloader_app/screens/base_screens/empty_screen.dart';
import '../screens/base_screens/home_screen.dart';
import '../screens/base_screens/download_list_screen.dart';

class RouteHelper {
  static const homeScreen = '/homeScreen';
  static const videoListScreen = '/videoListScreen';
  static const audioListScreen = '/audioListScreen';
  static const videoItemScreen = '/videoItemScreen';
  static const appDrawerScreen = '/appDrawerScreen';
  static const emptyScreen = '/emptyScreen';

  static String getHomeScreen() => '$homeScreen';
  static String getVideoListScreen() => '$videoListScreen';

  static String getAudioListScreen() => '$audioListScreen';
  static String getAppDrawerScreen() => '$appDrawerScreen';
  static String getEmptyScreen() => '$emptyScreen';

  static Map<String, Widget Function(BuildContext context)> routes = {
    homeScreen: (context) => const HomeScreen(),
    videoListScreen: (context) => const DownloadListScreen(),
    appDrawerScreen: (context) => const AppDrawer(),
    emptyScreen: (context) => const EmptyScreen(),
  };
}
