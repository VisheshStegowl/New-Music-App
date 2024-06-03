import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/VideoScreen/VideoWatchScreen.dart';

class MyFavoriteVideoScreen extends GetView<MenuPageController> {
  const MyFavoriteVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppNavigationBar(
          defaultAppBar: AppBar(),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppAssets.blackBackgroundScreen,
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              TitleBackButtonWidget(title: 'My Favorite Video'),
              5.verticalSpace,
              GetBuilder<MenuPageController>(
                  init: controller..favouriteVideoApi(),
                  builder: (controller) {
                    if (controller
                            .favouriteVideoModel.value?.data?.isNotEmpty ??
                        false) {
                      return GridView.builder(
                        itemCount: controller
                                .favouriteVideoModel.value?.data?.length ??
                            0,
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
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return VideoWatchScreen(
                                  videoData: controller
                                      .favouriteVideoModel.value?.data?[index],
                                  videosId: controller.favouriteVideoModel.value
                                          ?.data?[index].videosId ??
                                      0,
                                  datas: controller
                                          .favouriteVideoModel.value?.data ??
                                      [],
                                  videoUrl: controller.favouriteVideoModel.value
                                          ?.data?[index].videosLink ??
                                      '',
                                  videoDescp: controller.favouriteVideoModel
                                      .value?.data?[index].videosDescription,
                                  videoTitle: controller.favouriteVideoModel
                                      .value?.data?[index].videosName,
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
                                    image: controller.favouriteVideoModel.value
                                            ?.data?[index].videosImage ??
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
                                            stops: const [0.65, 0.75, 0.85],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColors.transparent,
                                              AppColors.black.withOpacity(0.75),
                                              AppColors.black.withOpacity(0.89)
                                            ])),
                                    child: AppTextWidget(
                                      txtTitle: controller.favouriteVideoModel
                                              .value?.data?[index].videosName ??
                                          '',
                                      txtColor: AppColors.error,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 8,
                                    child: InkWell(
                                      onTap: () async {
                                        controller
                                                .favouriteVideoModel
                                                .value
                                                ?.data?[index]
                                                .favouritesStatus =
                                            await Get.find<VideoController>()
                                                .addRemoveFavoriteVideoApi(
                                                    menuId: controller
                                                            .favouriteVideoModel
                                                            .value
                                                            ?.data?[index]
                                                            .menuId ??
                                                        0,
                                                    videoId: controller
                                                            .favouriteVideoModel
                                                            .value
                                                            ?.data?[index]
                                                            .videosId ??
                                                        0);
                                        controller
                                            .favouriteVideoModel.value?.data
                                            ?.removeWhere((element) =>
                                                element.videosId ==
                                                controller
                                                    .favouriteVideoModel
                                                    .value
                                                    ?.data?[index]
                                                    .videosId);
                                        controller.update();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColors.appButton,
                                        size: 25.r,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Flexible(
                        child: Center(
                            child: AppTextWidget(
                          txtTitle: 'No Data Found !!',
                          txtColor: AppColors.white,
                          fontSize: 18,
                        )),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
