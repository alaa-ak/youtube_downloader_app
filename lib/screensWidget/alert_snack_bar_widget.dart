import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

SnackBar AlertSnackBarFunction(String text) {
  final SnackBar snackBar = SnackBar(
    content: Container(
      child: Text(
        text,
        style:
            TextStyle(color: AppColors.textColor, fontSize: Dimensions.font14),
      ),
    ),
    //AppColors.mainColor.withOpacity(0.1)
    backgroundColor: Colors.red.shade900,
  );

  return snackBar;
}
