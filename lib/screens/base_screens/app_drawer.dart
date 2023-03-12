import 'package:flutter/material.dart';
import 'package:youtube_downloader_app/screensWidget/list_tile_widget.dart';
import 'package:youtube_downloader_app/screensWidget/text_widget.dart';
import 'package:youtube_downloader_app/route/route_helper.dart';
import 'package:youtube_downloader_app/utils/colors.dart';
import 'package:youtube_downloader_app/utils/dimensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.mainColor,
      child: Container(
        child: Column(
          children: [
            Container(
              color: AppColors.mainColor,
              height: Dimensions.height80,
              width: double.infinity,
              padding: EdgeInsets.only(top: Dimensions.height20),
              alignment: Alignment.center,
              child: TextWidget(
                text: "Downloads",
                color: AppColors.textColor,
                size: Dimensions.font18,
              ),
            ),
            Divider(
              color: Colors.grey.shade900,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteHelper.getHomeScreen(),
                    (route) => false,
                  );
                },
                child: ListTileWidget(
                  text: 'Home',
                  icon: Icons.home_filled,
                  textSize: Dimensions.font15,
                  iconColor: AppColors.textColor,
                )),
            SizedBox(
              height: Dimensions.height20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteHelper.getVideoListScreen(),
                  (route) => false,
                );
              },
              child: ListTileWidget(
                text: 'Downloads',
                icon: Icons.download,
                textSize: Dimensions.font15,
                iconColor: AppColors.textColor,
              ),
            ),
            SizedBox(
              height: Dimensions.height10 * 0.7,
            ),
          ],
        ),
      ),
    );
  }
}
