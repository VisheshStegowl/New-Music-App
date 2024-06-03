import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataListModel.dart'
    as data;
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/VideoPlayer.dart';
import 'package:new_music_app/View/VideoScreen/Widgets/DescriptionWidget.dart';

class VideoWatchScreen extends StatelessWidget {
  final String videoUrl;
  final int videosId;
  final String? videoTitle;
  final String? videoDescp;
  final data.Data? videoData;
  late List<data.Data> datas;

  VideoWatchScreen(
      {super.key,
      required this.videoUrl,
      this.videoTitle,
      this.videoDescp,
      this.videoData,
      required this.datas,
      required this.videosId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppNavigationBar(
            defaultAppBar: AppBar(),
          ),
          body: Container(
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.blackBackgroundScreen,
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                TitleBackButtonWidget(
                  onTap: () {
                    Get.back();
                    if (datas.isNotEmpty) {
                      datas = [];
                    }
                  },
                  title: videoTitle ?? '',
                ),
                SizedBox(
                    width: double.maxFinite,
                    height: 200.h,
                    child: VideoPlayerWidget(
                      videoUrl: videoUrl,
                      canDispose: true,
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: DescriptionWidget(
                      videoId: videosId,
                      videoData: videoData,
                      videoDescription: videoDescp ?? '',
                      videoTitle: videoTitle,
                      datas: datas,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
