import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/bloc/url_download_bloc.dart';
import 'package:youtube_downloader_app/data/models/url_download_model.dart';
import 'package:youtube_downloader_app/route/route_helper.dart';
import 'package:youtube_downloader_app/screens/base_screens/empty_screen.dart';
import 'package:youtube_downloader_app/screensWidget/delete_alret_dialog_widget.dart';
import 'package:youtube_downloader_app/screensWidget/text_widget.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/dimensions.dart';
import 'package:open_filex/open_filex.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  List<UrlDownloadModel> list = [];

  @override
  void initState() {
    list = BlocProvider.of<UrlDownloadBloc>(context).storageData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (list.length > 0)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              print('The Length of List is ${list.length} ');
              return GestureDetector(
                onTap: () {
                  OpenFilex.open(list[index].urlDownloadPath);
                },
                child: Container(
                    height: Dimensions.height20 * 4,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ListTile(
                            title: TextWidget(
                                text: list[index].urlDownloadTitle,
                                textAlign: TextAlign.right,
                                size: Dimensions.font12,
                                color: AppColors.textColor),
                            leading: GestureDetector(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DeleteAlretDialogWidget(
                                              confirm: 'Delete',
                                              cancel: 'Cancel',
                                              confirmFun: () {
                                                BlocProvider.of<
                                                            UrlDownloadBloc>(
                                                        context)
                                                    .removeStorageDataItem(
                                                        list[index]
                                                            .urlDownloadTitle);
                                                setState(() {
                                                  list = BlocProvider.of<
                                                              UrlDownloadBloc>(
                                                          context)
                                                      .storageData;
                                                });
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        RouteHelper
                                                            .getVideoListScreen());
                                              },
                                              cancelFun: () {
                                                Navigator.of(context).pop(
                                                    RouteHelper
                                                        .getVideoListScreen());
                                              }));
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: AppColors.textColor,
                                  size: Dimensions.iconSize15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextWidget(
                                  textAlign: TextAlign.right,
                                  text: format(list[index].urlDownloadDuration!)
                                      .toString(),
                                  size: Dimensions.font10,
                                  color: AppColors.textColor),
                              SizedBox(
                                width: Dimensions.width10,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: Dimensions.font10),
                                child: TextWidget(
                                    textAlign: TextAlign.right,
                                    text:
                                        '-   ' + list[index].urlDownloadAuthor,
                                    size: Dimensions.font12,
                                    color: AppColors.textColor),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade900,
                        ),
                      ],
                    )),
              );
            })
        : const Center(child: EmptyScreen());
  }

  format(Duration d) =>
      d.toString().split('.').first.padLeft(8, "0"); // Format for duration
}
