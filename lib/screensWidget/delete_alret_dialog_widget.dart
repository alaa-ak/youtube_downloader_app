import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/screensWidget/text_button_widget.dart';
import 'package:youtube_downloader_app/screensWidget/text_widget.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

class DeleteAlretDialogWidget extends StatelessWidget {
  final String confirm;
  final String cancel;
  final Function confirmFun;
  final Function cancelFun;
  const DeleteAlretDialogWidget(
      {super.key,
      required this.confirm,
      required this.cancel,
      required this.confirmFun,
      required this.cancelFun});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height80,
      child: AlertDialog(
          backgroundColor: AppColors.mainColor,
          title: TextWidget(
            text: 'Confirm',
            color: AppColors.textColor,
            size: Dimensions.font17,
          ),
          content: Row(
            children: [
              Expanded(
                child: TextButtonWidget(
                  onPressed: confirmFun,
                  text: confirm,
                  size: Dimensions.font14,
                  color: AppColors.textColor,
                ),
              ),
              Expanded(
                child: TextButtonWidget(
                  onPressed: cancelFun,
                  text: cancel,
                  size: Dimensions.font14,
                  color: AppColors.textColor,
                ),
              ),
            ],
          )),
    );
  }
}
