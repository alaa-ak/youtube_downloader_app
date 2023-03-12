import 'package:flutter/material.dart';
import '../../screensWidget/text_widget.dart';
import '../../utils/colors.dart';
import 'app_drawer.dart';

class MainScreen extends StatelessWidget {
  final Widget screenBodyWidget;
  const MainScreen({super.key, required this.screenBodyWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        primary: true,
        backgroundColor: AppColors.mainColor,
        title: TextWidget(
          text: "YouTube Downloader ",
        ),
      ),
      drawer: const AppDrawer(),
      body: screenBodyWidget,
    );
  }
}
