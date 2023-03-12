import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  late final TextEditingController textEditingController;
  final String hintText;
  TextFieldWidget(
      {super.key, required this.textEditingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: (EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.height * 0.05)),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height * 0.02),
      ),
      child: TextField(
        style: TextStyle(color: AppColors.textColor),
        controller: textEditingController,
        //hintText
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: Dimensions.font15),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.textColor)),
        ),
      ),
    );
  }
}
