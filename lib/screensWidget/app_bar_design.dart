import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/screensWidget/text_widget.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

import '../utils/colors.dart';

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      backgroundColor: AppColors.mainColor,
      title: TextWidget(
        text: "YouTube Downloader ",
        size: Dimensions.font20,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
