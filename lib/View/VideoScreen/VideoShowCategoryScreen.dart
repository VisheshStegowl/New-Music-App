import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/VideoScreen/VideoWatchScreen.dart';

class VideoShowCategoryListScreen extends GetView<VideoController> {
  final String title;

  const VideoShowCategoryListScreen({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          child: SingleChildScrollView(
            child: GetBuilder<VideoController>(
                init: controller,
                builder: (controller) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TitleBackButtonWidget(
                        title: title,
                      ),
                      GridView.builder(
                        itemCount: controller.videoCategoryDataListModel.value
                                ?.data?.length ??
                            1,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 15.h,
                          crossAxisSpacing: 15.w,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              AppConst.liveVideoUrl.value = false;
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return VideoWatchScreen(
                                  videosId: controller
                                          .videoCategoryDataListModel
                                          .value
                                          ?.data?[index]
                                          .videosId ??
                                      0,
                                  datas: controller.videoCategoryDataListModel
                                          .value?.data ??
                                      [],
                                  videoUrl: controller
                                          .videoCategoryDataListModel
                                          .value
                                          ?.data?[index]
                                          .videosLink ??
                                      '',
                                  videoDescp: controller
                                      .videoCategoryDataListModel
                                      .value
                                      ?.data?[index]
                                      .videosDescription,
                                  videoTitle: controller
                                      .videoCategoryDataListModel
                                      .value
                                      ?.data?[index]
                                      .videosName,
                                  videoData: controller
                                      .videoCategoryDataListModel
                                      .value
                                      ?.data?[index],
                                );
                              }));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r)),
                              clipBehavior: Clip.hardEdge,
                              child: Stack(
                                children: [
                                  CachedNetworkImageWidget(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    image: controller.videoCategoryDataListModel
                                            .value?.data?[index].videosImage ??
                                        '',
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.only(
                                      bottom: 15.h,
                                    ),
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            stops: [0.7, 0.8, 0.85],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColors.transparent,
                                              AppColors.black.withOpacity(0.65),
                                              AppColors.black.withOpacity(0.75)
                                            ])),
                                    child: AppTextWidget(
                                      txtTitle: controller
                                              .videoCategoryDataListModel
                                              .value
                                              ?.data?[index]
                                              .videosName ??
                                          '',
                                      txtColor: AppColors.error,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
