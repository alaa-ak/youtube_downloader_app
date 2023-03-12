import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/bloc/url_download_bloc.dart';
import 'package:youtube_downloader_app/screensWidget/button_widget.dart';
import 'package:youtube_downloader_app/screens/base_screens/pop_up_dialog_screen.dart';
import '/screensWidget/info_snack_bar_widget.dart' as infoSnackBarWidget;
import '/screensWidget/alert_snack_bar_widget.dart' as alertSnackBarWidget;
import 'package:youtube_downloader_app/screensWidget/text_field_widget.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_helper.dart';

class PasteLinkScreen extends StatelessWidget {
  PasteLinkScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //Instance of urlDownloadBloc class
    final urlDownloadBloc = BlocProvider.of<UrlDownloadBloc>(context);

    print('Hello I am a Download Link Screen and the EndPoint is ' +
        urlDownloadBloc.urlDownloadEndPoint!);

    //urlController for TextField Controller
    var urlController = TextEditingController();

    return BlocListener<UrlDownloadBloc, UrlDownloadState>(
        listener: (context, state) async {
          if (state is EmptyUrlState) {
            print("State is Empty Url State");
            ScaffoldMessenger.of(context).showSnackBar(
                alertSnackBarWidget.AlertSnackBarFunction(
                    'PLEASE PASTE The LINK '));
          }
          if (state is ExistUrlState) {
            print('State is Exist Url State');
            ScaffoldMessenger.of(context).showSnackBar(infoSnackBarWidget
                .infoSnackBarFunction('Preparing to download '));
          }
          if (state is LoadUrlDownloadState) {
            urlDownloadBloc.urlDownloadTypeSetter = '';
            showDialog(
                context: context,
                builder: (context) => PopupDialogScreen(
                      context: context,
                      urlDownloadModel: urlDownloadBloc.urlDownloadItem!,
                    ));
            urlDownloadBloc.urlDownloadTypeSetter = await showDialog(
                context: context,
                builder: (context) => PopupDialogScreen(
                      context: context,
                      urlDownloadModel: urlDownloadBloc.urlDownloadItem!,
                    ));
            print(
                'State is Load Url Download State And urlDownloadType = ${urlDownloadBloc.urlDownloadTypeGetter}');
          }
          if (state is CheckUrlDownloadTypeState) {
            print('State is Check Url Download State');
            ScaffoldMessenger.of(context).showSnackBar(
                alertSnackBarWidget.AlertSnackBarFunction(
                    'Please Choose The Type! '));
          }
          if (state is SuccessUrlDownloadState) {
            print('State is Success Url Download State');
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => state.widget));
          }
          if (state is UpdateDataState) {
            print('Storage Data ${urlDownloadBloc.storageData.length}');

            Navigator.of(context).pushNamed(RouteHelper.getVideoListScreen());
          }
          if (state is ErrorUrlDownloadState) {
            ScaffoldMessenger.of(context).showSnackBar(
                alertSnackBarWidget.AlertSnackBarFunction('Invalid Link '));
          }
        },
        child: Container(
          height: Dimensions.height250,
          child: Column(children: [
            TextFieldWidget(
              hintText: 'Paste YouTube Link Here ',
              textEditingController: urlController,
            ),
            SizedBox(
              height: Dimensions.height10 * 5,
            ),
            GestureDetector(
                onTap: () {
                  String url = urlController.text.trim();
                  print("URL is " + url);
                  urlDownloadBloc.urlDownloadEndPointSetter = url;

                  print("URL Bloc is " + urlDownloadBloc.urlDownloadEndPoint!);
                  urlDownloadBloc.add(PressDownloadButtonEvent());
                },
                child: ButtonWidget())
          ]),
        ));
  }
}
