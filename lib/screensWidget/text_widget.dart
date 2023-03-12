import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

import '../utils/colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  double? size;
  Color? color;
  TextAlign? textAlign;
  TextOverflow textOverflow;
  TextWidget(
      {super.key,
      required this.text,
      this.size,
      this.color,
      this.textAlign,
      this.textOverflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign ?? TextAlign.center,
      text,
      maxLines: 1,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: size ?? Dimensions.font18,
        color: color ?? AppColors.textColor,
      ),
    );
  }
}
