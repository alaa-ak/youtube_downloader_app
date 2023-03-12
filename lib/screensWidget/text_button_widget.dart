import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/screensWidget/text_widget.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  double? size;
  Color? color;
  final Function onPressed;
  TextButtonWidget(
      {super.key,
      required this.text,
      this.size,
      this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: AppColors.textColor),
      onPressed: () => onPressed(),
      child: TextWidget(
        text: text,
        color: color ?? AppColors.textColor,
        size: size ?? Dimensions.font15,
      ),
    );
  }
}
