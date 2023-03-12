import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

SnackBar infoSnackBarFunction(String text) {
  final SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 8),
    content: Container(
      height: Dimensions.height10 * 2,
      child: Text(
        text,
        style:
            TextStyle(color: AppColors.mainColor, fontSize: Dimensions.font14),
      ),
    ),
    backgroundColor: AppColors.textColor,
  );

  return snackBar;
}
