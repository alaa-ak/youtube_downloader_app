import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

class ListTileWidget extends StatelessWidget {
  final String text;
  double? textSize;
  final IconData icon;
  double? iconSize;
  final Color iconColor;

  ListTileWidget({
    super.key,
    required this.text,
    this.textSize,
    required this.icon,
    this.iconSize,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
        size: iconSize ?? Dimensions.iconSize20,
      ),
      title: Text(
        text,
        style: TextStyle(
            fontSize: textSize ?? Dimensions.font17,
            color: AppColors.textColor),
      ),
    );
  }
}
