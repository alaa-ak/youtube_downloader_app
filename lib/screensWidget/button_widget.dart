import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

class ButtonWidget extends StatelessWidget {
  Color? iconColor;
  ButtonWidget({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(
      Icons.download,
      color: iconColor ?? AppColors.textColor,
      size: Dimensions.iconSize30 * 2,
    ));
  }
}
