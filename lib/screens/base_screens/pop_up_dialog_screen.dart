import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/data/models/url_download_model.dart';
import 'package:youtube_downloader_app/screensWidget/text_button_widget.dart';
import 'package:youtube_downloader_app/screensWidget/text_widget.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';

class PopupDialogScreen extends StatelessWidget {
  final BuildContext context;
  final UrlDownloadModel urlDownloadModel;

  const PopupDialogScreen({
    super.key,
    required this.context,
    required this.urlDownloadModel,
  });

  @override
  Widget build(BuildContext context) {
    String? urlDownloadType;
    return Container(
      child: AlertDialog(
          backgroundColor: AppColors.mainColor,
          title: Container(
            margin: EdgeInsets.only(bottom: Dimensions.height8),
            child: Column(
              children: [
                TextWidget(
                  text: urlDownloadModel.urlDownloadTitle,
                  color: AppColors.textColor,
                  size: Dimensions.font15,
                ),
                SizedBox(
                  height: Dimensions.height8,
                ),
                Container(
                  height: Dimensions.height80,
                  decoration: BoxDecoration(
                    color: AppColors.textColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${urlDownloadModel.urlDownloadThumbnail}'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          content: Row(
            children: [
              Expanded(
                child: TextButtonWidget(
                  onPressed: () {
                    urlDownloadType =
                        'video' + urlDownloadModel.urlDownloadId.toString();
                    Navigator.pop(context, urlDownloadType);
                  },
                  text: 'Video',
                ),
              ),
              Expanded(
                child: TextButtonWidget(
                  onPressed: () {
                    urlDownloadType =
                        'audio' + urlDownloadModel.urlDownloadId.toString();
                    Navigator.pop(context, urlDownloadType);
                  },
                  text: 'Audio',
                ),
              ),
            ],
          )),
    );
  }
}
