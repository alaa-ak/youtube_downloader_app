import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/screens/base_screens/paste_link_screen.dart';
import 'package:youtube_downloader_app/screens/base_screens/main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Hello I am Home Screen');
    return MainScreen(screenBodyWidget: PasteLinkScreen());
  }
}
